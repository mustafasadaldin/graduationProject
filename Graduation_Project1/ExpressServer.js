require('./MongoConnection.js')
const userRoute = require('./routers/UserRouters')
const adminRouter = require('./routers/AdminRouter')
const trainerRouter=require('./routers/TrainerRouter')
const globalRouter=require('./routers/globalRouter')
const starsRouter = require('./routers/StarsRouter')
var bodyParser = require('body-parser');
const express=require('express')
const cors=require('cors')
const app=express()
const port=process.env.port || 3000
app.use(cors())
app.use(bodyParser.json({limit: '50mb' }));
app.use(bodyParser.urlencoded({ limit: '50mb', extended: true, parameterLimit: 50000 }));
app.use(express.json())
app.use(userRoute)
app.use(adminRouter)
app.use(trainerRouter)
app.use(globalRouter)
app.use(starsRouter)
app.listen(port,()=>{
  console.log('on listening')
})