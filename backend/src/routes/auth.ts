import {Router,Request,Response} from 'express'
import { db } from '../db'
import { NewUser, users } from '../db/schema'
import { eq } from 'drizzle-orm'
import bcryptjs from "bcryptjs"
import jwt from 'jsonwebtoken'
import dotenv from 'dotenv'
import { auth, AuthRequest } from '../middleware/auth'


dotenv.config()

const authRouter=Router()

interface SignUpBody{
    name:string,
    email:string,
    password:string,
}


interface LoginBody{
    email:string,
    password:string
}


authRouter.post("/signup",async(req :Request<{},{},SignUpBody>,res:Response)=>{
    try{
        //Extracting name,email and password parameters from req body
        const {name,email,password} = req.body
        
        //Checking if users already exist or not
        const fetchedUser = await db.select().from(users).where(eq(users.email,email))
        
        
        if(fetchedUser.length)
        {
            res.status(400).json({msg:"User with same email already exist"});
            return;
        }

        const hashedPassword = await bcryptjs.hash(password,8);
        //Creating a new user
        const newUser:NewUser=
        {
            name : name,
            email : email,
            password : hashedPassword
        }

       const [user]= await db.insert(users).values(newUser).returning()
       res.status(201).json(user)

    }
    catch(e)
    {
        res.status(500).json({error : e})
    }
})

authRouter.get("/login",async (req:Request<{},{},LoginBody>,res:Response)=>{

    try{
        const {email,password} = req.body
        const [existingUser] = await db.select().from(users).where(eq(users.email,email))
            
        if(!existingUser)
        {
            res.status(400).send({msg:"The user does not exist"})
            return;
        }

        const matching=await bcryptjs.compare(password,existingUser.password)

        if(!matching)
        {
            res.status(400).send({msg:"Invalid credintials"})
            return;
        }

        if (!process.env.JWT_SECRET) {
            throw new Error("JWT_SECRET is not defined in environment variables");
        }

        const token = jwt.sign({ id: existingUser.id }, process.env.JWT_SECRET);


        res.json({token,...existingUser})
        
    }
    catch(e)
    {
        res.status(500).send({error:e})
    }

})


authRouter.post("/validToken",async(req:Request,res:Response)=>{
    try 
    {
        //get the header : jwt token will be in the header
        const token=req.header("x-auth-token");
        if(!token)
        {
                
            res.json(false);
            return;
        } 
            
        //verify the token
        if(!process.env.JWT_SECRET)
        {
            throw new Error("JWT_SECRET is not defined in environment variables");
        }

        const verified=jwt.verify(token,process.env.JWT_SECRET)

        if(!verified)
        {
            res.json(false)
            return;
        }

        //getting the verified token
        const verifiedToken=verified as {id:string};
        
        //fetch the user depending on the id 
        const [user] = await db.select().from(users).where(eq(users.id,verifiedToken.id))

        if(!user)
        {
            res.json(false);
            return;
        }

        res.send(true);

    } 
    catch (e) {
        res.status(500).json(false)
    }
})


authRouter.get("/",auth,async(req : AuthRequest,res:Response)=>{
    try {
        
        if(!req.user)
        {
            res.status(401).json({msg:"User with the ide does not exist"});
            return;
        }
        const [user]= await db.select().from(users).where(eq(users.id,req.user))
        res.json({...user,token:req.token})

    } catch (e) {
        res.status(500).json(false)
    }
        
})

export default authRouter