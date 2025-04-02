import {Router,Request,Response} from 'express'
import { db} from '../db'
import dotenv from 'dotenv'
import { tasks} from '../db/schema'
import { auth, AuthRequest } from '../middleware/auth';
import { newTask } from '../db/schema';
import { eq } from 'drizzle-orm';

dotenv.config()


const taskRouter=Router();

taskRouter.post("/",auth,async (req : AuthRequest,res)=>{
    try {
        req.body={...req.body,dueAt:new Date(req.body.dueAt),uid:req.user!}
        const newTask:newTask=req.body;

        const [task]=await db.insert(tasks).values(newTask).returning();


        res.status(201).json(task);
        
    } catch (error) {
        console.log(error)
        res.status(500).json({msg:error})
    }
    
})

taskRouter.get("/",auth,async (req: AuthRequest,res)=>{
    try {
        const userId=req.user!;
        const allTasks=await db.select().from(tasks).where(eq(tasks.uid,userId));
        res.status(200).json(allTasks);
    } catch (error) {
        res.status(500).json({msg:error});
    }
})

taskRouter.delete("/",auth,async (req:AuthRequest,res)=>{
    try {
        const {taskId}:{taskId:string}=req.body;
        await db.delete(tasks).where(eq(tasks.id, taskId));
        res.status(200).json(true);
    } 
    catch (error) {
        res.status(500).json(false);
    }
})



export default taskRouter;