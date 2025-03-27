import express from 'express'
import dotenv from 'dotenv'
import authRouter from './routes/auth';

dotenv.config()
const app=express();

app.use(express.json())
app.use("/auth",authRouter)

app.get("/",(req,res)=>{
    res.json({msg:"Hello world"})
})

app.listen(process.env.PORT,()=>{
    console.log(`Listening to port on ${process.env.PORT }`);
})