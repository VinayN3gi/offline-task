import {drizzle} from "drizzle-orm/node-postgres"
import {Pool} from "pg"
import dotenv from 'dotenv'
dotenv.config()

const pool=new Pool({
    connectionString : process.env.CONNECT_STRING
})

export const db= drizzle(pool);
