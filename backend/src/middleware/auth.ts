import { UUID } from "crypto"
import { Request ,Response,NextFunction} from "express"
import jwt from 'jsonwebtoken'
import { db } from '../db'
import dotenv from 'dotenv'
import { users } from "../db/schema"
import { eq } from "drizzle-orm" // Adjust the import path based on your ORM library


dotenv.config()

export interface AuthRequest extends Request
{
    user?:UUID;
    token?:string
}

export const auth=async (req:AuthRequest,res:Response,next:NextFunction)=>{
    try
    {
        const token=req.header("x-auth-token")

        if(!token)
        {
            res.status(401).json({msg:"The validation token is present"});
            return;
        }

        if(!process.env.JWT_SECRET)
        {
            throw new Error("JWT token is not defined is enviornment variables");
        }

        const verified=jwt.verify(token,process.env.JWT_SECRET);

        if(!verified)
        {
            res.status(401).json({msg:"Validation failed"});
            return;
        }

        const verifiedToken=verified as {id:UUID}

        const [fectchedUser]= await db.select().from(users).where(eq(users.id,verifiedToken.id))

        if(!fectchedUser)
        {
            res.status(401).json({msg:"User not found"})
        }

        req.user=verifiedToken.id
        req.token=token

        next();
    }
    catch(e)
    {
        res.status(500).json({error:e})
    }
}