const user=require('./models/user.js')
require('./test2.js')
const testFn= async ()=>{
    try{
   const t= await user.find({}).skip(3).limit(2)
   console.log(t)
    } catch(e){
        console.log(e)
    }
}
testFn()
//req.query.???=>name of feild