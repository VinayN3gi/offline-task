import {Router,Request,Response} from 'express'
import { db } from '../db'
import { NewUser, users } from '../db/schema'
import { eq } from 'drizzle-orm'
import bcryptjs from "bcryptjs"
import jwt from 'jsonwebtoken'
import dotenv from 'dotenv'


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

export default authRouter