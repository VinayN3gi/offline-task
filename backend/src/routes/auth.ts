import {Router,Request,Response} from 'express'
import { db } from '../db'
import { NewUser, users } from '../db/schema'
import { eq } from 'drizzle-orm'
import bcryptjs from "bcryptjs"

const authRouter=Router()

interface SignUpBody{
    name:string,
    email:string,
    password:string,
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

authRouter.get("/",(req,res)=>{

})

export default authRouter