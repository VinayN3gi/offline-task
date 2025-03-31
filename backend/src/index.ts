import express from 'express'
import dotenv from 'dotenv'
import authRouter from './routes/auth';
import cors from 'cors'
import taskRouter from './routes/task';

dotenv.config()
const app=express();

app.use(express.json())
app.use(cors());
app.use("/auth",authRouter)
app.use("/task",taskRouter)

app.get("/",(req,res)=>{
    res.json({msg:"Hello world"})
})



app.listen(process.env.PORT,()=>{
    console.log(`Listening to port on ${process.env.PORT }`);
})
