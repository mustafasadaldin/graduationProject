const express=require('express')
const User=require('../models/user')
const bcrypt=require('bcryptjs')
const jwt=require('jsonwebtoken')
const nodemailer = require('nodemailer');
const Trainer=require('../models/Trainer')
const multer=require('multer')
const sharp=require('sharp');
const trainer = require('../models/Trainer');
const Stars = require("../models/Stars")
const prodStars=require('../models/productsStars')
const router=new express.Router()
const exe=require('../models/exe')
const store=require('../models/store')
const upload = multer({
  limits: {
      fileSize: 1000000
  },
})


const middleWare= async (req,res,next)=>{
try{
  const token = req.header('token')

  const isValid = jwt.verify(token,'secretKey')

  const user=await User.findOne({_id: isValid._id,'tokens.token':token})
  if(!user)
  return res.status(401).send('not authenticated')

  req.user=user
  req.token=token
  next()
} catch(e){
  res.status(401).send('not authenticated')
}


}


const genUserToken = async (_id)=> {
const token = await jwt.sign({ _id },'secretKey')
return token
}


router.post('/users/sign-up',async(req,res)=>{
  try{
    
    const trainer= await Trainer.findOne({ email:req.body.email.trim()})
    if((trainer!=null)||(req.body.email.trim()=='mustafa001063@gmail.com'))
    return res.status(400).send('not unique email')

   const trainer2=await Trainer.findOne({ userName:req.body.userName.trim()})
    if(trainer2!=null)
    return res.status(400).send('not unique username')
    
    
    
    const user=new User(req.body)
    await user.save()
    req.body.password= await bcrypt.hash(req.body.password.trim(), 8)
    user.password=req.body.password
    const token = await genUserToken(user._id.toString())
    user.tokens=user.tokens.concat([{token:token}])
    await user.save()
    res.status(201).send({
      token:token,
      username: user.userName,
      age: user.age,
      height: user.height,
      weight:user.weight
    })

  }catch(e) {
      if(e.hasOwnProperty('errors')) {
          if(e.errors.hasOwnProperty('email')){
          res.status(400).send('Invalid email form')
          }
        else if(e.errors.hasOwnProperty('password')){
            res.status(400).send('too weak password')
        }

        else if(e.errors.hasOwnProperty('userName')){
            res.status(400).send('invalid username')
        }
        else if(e.errors.hasOwnProperty('age')) {
          res.status(400).send('age is required')
        }
        else if(e.errors.hasOwnProperty('gender')) {
          res.status(400).send('gender is required')
        }

      }

    else if(e.hasOwnProperty('keyValue')) {
        if(e.keyValue.hasOwnProperty('userName')) {
            res.status(400).send('not unique username')
        }
        else if(e.keyValue.hasOwnProperty('email')) {
            res.status(400).send('not unique email')
        } 
    }
    
  }
})


  router.post('/users/update-password',middleWare ,async(req,res) => {

    try{
    req.user.password=req.body.password.trim()
    await req.user.save()
    req.user.password= await bcrypt.hash(req.body.password.trim(),8)
    await req.user.save()
    return res.status(200).send('updated')
    } catch(e) {
      return res.status(400).send('too weak password')
    }
  })


router.post('/users/info', middleWare ,async(req,res) => {
try{
  if(req.body.hasOwnProperty('username')) {
  const trainer=await Trainer.findOne({userName:req.body.username.trim()})
  if(trainer)
  return res.status(400).send('not unique username')
    req.user.userName = req.body.username.trim()
    await req.user.save()
 
  }
  if(req.body.hasOwnProperty('height')) {
  req.user.height=parseFloat(req.body.height)
  await req.user.save()
  }
  if(req.body.hasOwnProperty('weight')) {
  req.user.weight=parseFloat(req.body.weight)
  await req.user.save()
  }
  if(req.body.hasOwnProperty('age')) {
    req.user.age=parseInt(req.body.age)
    await req.user.save()
  }
  return res.status(200).send('changed')
}catch(e) {
  if(e.hasOwnProperty('errors')) {
    if(e.errors.hasOwnProperty('userName')){
      res.status(400).send('invalid username')
  }
  }

  else if(e.hasOwnProperty('keyValue')) {
    if(e.keyValue.hasOwnProperty('userName')) {
        res.status(400).send('not unique username')
    }
  }

}
})


router.post('/users/log-out',middleWare, async (req,res)=>{

  req.user.tokens=req.user.tokens.filter((element)=>{
    return element.token!=req.token
  })
  await req.user.save()
  res.status(200).send('done')
})

router.post('/users/deleteMe', middleWare, async(req,res) => {
  try{
  await User.deleteOne({_id:req.user._id})
  res.status(200).send('deleted')
  } catch(e) {
    console.log(e)
  }
})

router.post('/users/logoutAll',middleWare,(req,res)=>{

  req.user.tokens=[]
  req.user.save()
})


router.post('/users/image', middleWare, upload.single('upload'), async (req, res) => {
  console.log('enter')
  const buffer = await sharp(req.file.buffer).resize({ width: 250, height: 250 }).png().toBuffer()
  req.user.image = buffer
  
  await req.user.save()
  res.send()
}, (error, req, res, next) => {
  res.status(400).send({ error: error.message })
})

router.post('/users/image1', async (req, res) => {
  try {
    console.log('here')
      const user = await User.findOne({email:req.body.email})
      res.send(user.image.toString("base64"))
  } catch (e) {
      res.status(404).send()
  }
})


router.get('/trainers/get-images', middleWare ,async(req, res) => {
  try{
    const trainers = await Trainer.find({}).select('image -_id')
    var str = ""
    trainers.forEach((element) => {
      if(element.image)
      str = str+element.image.toString("base64")+","
      else {
        str = str+""+","
      }
    })
    str=str+"stop"
    res.status(200).send({
      str
    })
  }catch(e) {
    res.status(400).send('error')
  }
    
})

router.get('/trainers/usernames', middleWare ,async(req, res) => {
  try{
    const trainers = await Trainer.find({}).select('userName -_id')
    var str=""
    trainers.forEach((element) => {
      str = str+element.userName+","
    })
    res.status(200).send({
      str
    })
  }catch(e) {
    res.status(400).send('error')
  }
})

router.post('/trainer/all-info', middleWare,async(req,res) => {
  try{
  const trainer = await Trainer.findOne({userName:req.body.username.trim()})
  if(trainer) {
    if(!trainer.image) {
   return res.status(200).send({
      email:trainer.email,
      age:trainer.age,
      experience:trainer.excperience,
      image:"",
      startWorkHoures:trainer.startWorkHoures,
      endWorkHoures:trainer.endWorkHoures,
      location:trainer.location
    })
  }

  else {
    return res.status(200).send({
      email:trainer.email,
      age:trainer.age,
      experience:trainer.excperience,
      image:trainer.image.toString("base64"),
      startWorkHoures:trainer.startWorkHoures,
      endWorkHoures:trainer.endWorkHoures,
      location:trainer.location
    })
  }

  }
  }catch(e) {
    res.status(400).send('error')
  }
})

router.post('/trainers/breaks', middleWare, async(req,res) => {
  try{
    const trainer2 = await Trainer.findOne({userName:req.body.username.trim()}).select('freeTimes -_id')
    var str = ""
    trainer2.freeTimes.forEach((element) => {
      if(element.day == req.body.workingDay.trim())
      str = str + element.session + ","
    })
    res.status(200).send({
      str
    })
  } catch(e) {
    res.status(400).send(e)
  }

})

router.post('/trainers/reserveTime', middleWare, async(req, res) => {
  try{
    var numberOfDays=req.body.day.trim().split(",")
    var breakTimeList=req.body.breakTime.trim().split(",")
    var i=0
   
  const trainer2 = await Trainer.findOne({userName:req.body.username.trim()})
  trainer2.notif= req.user.userName
  for(z=0;(z<breakTimeList.length-1);z++){
  trainer2.freeTimes = trainer2.freeTimes.filter((element) => {
    if(element.day==numberOfDays[z].trim()){
      if(element.session==breakTimeList[z].trim()) {
        return false
      }
      else{
        return true
      }
    }
    else{
      return true
    }
  })
  }
for(var j=0;j<(numberOfDays.length-1);j++){
  trainer2.reservedTimes=trainer2.reservedTimes.concat([{session:breakTimeList[j].trim(), day:numberOfDays[j].trim()}])
  req.user.reservedTimes = req.user.reservedTimes.concat([{session:breakTimeList[j].trim(), day:numberOfDays[j].trim(), trainerUsername:req.body.username}])
}
  await trainer2.save()
  await req.user.save()
  // req.user.trainerUsername = req.body.username.trim()
  // req.user.numberOfClasses = req.body.numberOfClasses
  req.user.trainers = req.user.trainers.concat([{trainerUsername:req.body.username.trim(), classesNumber:req.body.numberOfClasses}])
  await req.user.save()
  res.status(200).send(trainer2.freeTimes)
} catch(e) {
  res.status(400).send('error')
}
})


router.post('/trainer/membership', middleWare, async (req, res) => {
  try{

    req.user.membershipStart = req.body.membershipStart
    req.user.membershipEnd = req.body.membershipEnd
    await req.user.save()
    res.status(200).send('saved')
  }catch(e) {
    res.status(400).send('error')
  }
})

router.post('/user/getMemberShipEnd', middleWare,async(req,res) => {
  try{

    if(req.user.membershipEnd) {
    res.status(200).send({
      membershipEnd:req.user.membershipEnd
    })
  }
  else {
    res.status(200).send({
      membershipEnd:"user"
    })
  }
  }catch(e) {
    res.status(400).send('error')
  }
})

router.post('/trainers/getWorkingDays', middleWare, async(req, res) => {
  try{
    const trainer2 = await Trainer.findOne({userName:req.body.username.trim()})
    var str=trainer2.workingDays
    res.status(200).send({
      str
    })
  } catch(e) {
    res.status(400).send(e)
  }
})

router.post('/trainers/regWith', middleWare, async(req,res) => {
  const found=req.user.trainers.find((element) => {
    return element.trainerUsername==req.body.username.trim()
  })
  if(found) {
    res.status(200).send('found')
  }
  else{
    res.status(200).send('ok')
  }
})

router.post('/trainers/getPersonalUsernames', middleWare, async(req,res) => {
  try{
  var str=""
  if(req.user.trainers.length!=0){
  req.user.trainers.forEach((element) => {
    str = str+element.trainerUsername+","
  })
  
  res.status(200).send({
    str:str
  })
}
else{
  res.status(200).send('empty')
}
}catch(e) {
  res.status(400).send('error')
}
})


router.post('/trainers/getPersonalTrainersImages1', middleWare, async(req,res) => {

  try{
  var str=""
  var strImage=""
  if(req.user.trainers.length!=0){
  req.user.trainers.forEach((element) => {
    str = str+element.trainerUsername+","
  })
  var array1 = str.split(',')
  for(var i=0; i<(array1.length-1); i++) {
    var temp= await Trainer.findOne({userName:array1[i]})
    if(temp.image)
    strImage = strImage + temp.image.toString("base64").trim() + ","
    else{
      strImage = strImage + "" + ","
    }
  }

  console.log(strImage.split(",").length)
  res.status(200).send({
    strImage:strImage
  })
}
else{
  res.status(200).send('empty')
}
}catch(e) {
  res.status(400).send('error')
}
})


router.post('/trainers/getPersonalTrainersRates1', middleWare, async(req,res) => {
  try{
  var str=""
  var strRate=""
  if(req.user.trainers.length!=0){
  req.user.trainers.forEach((element) => {
    str = str+element.trainerUsername+","
  })
  var array1 = str.split(',')
  for(var i=0; i<(array1.length-1); i++) {
    var temp= await Stars.findOne({trainerUsername:array1[i]})
    strRate = strRate + temp.avgRate.toFixed(2) + ","
  }
  res.status(200).send({
    strRate:strRate
  })
}
else{
  res.status(200).send('empty')
}
}catch(e) {
  res.status(400).send('error')
}
})

router.post('/trainers/personalTrainerProfileInfo', middleWare, async(req,res) => {
  try{

    const array=req.user.reservedTimes.filter((element) => {
      return element.trainerUsername==req.body.username.trim()
    })
    const array2=req.user.trainers.filter((element) => {
      return element.trainerUsername==req.body.username.trim()
    })
    var str=""
    for(var i=0;i<array.length;i++) {
    str=str+array[i].day+":"+array[i].session +","
    }
    res.status(200).send({
      str:str,
      numberOfClasses:array2[0].classesNumber
    })
  }catch(e) {
    res.status(400).send('error')
  }
})

router.post('/trainers/checkConflict', middleWare, async(req,res) => {
  try{
  const found = req.user.reservedTimes.find((element) => {
    if(element.day==req.body.day.trim()){
      if(element.session==req.body.breakTime.trim()) {
        return true
      }
      else{
        return false
      }
    }
    else{
      return false
    }
  })


  if(found)
  return res.status(200).send('conflict')

  res.status(200).send('no conflict')
} catch(e){
  res.status(400).send('error')
}
})

router.post('/trainer/getUserPersonalRate', middleWare, (req,res) => {
  try{
  const array2=req.user.trainers.filter((element) => {
    return element.trainerUsername==req.body.username.trim()
  })

  res.status(200).send({
    
    numberOfClasses:array2[0].classesNumber
  })
} catch(e){
  res.status(400).send('error')
}
})



router.post('/trainers/getMyReservedTimes', middleWare, async(req,res) => {
  try{
 
    var str=""
    req.user.reservedTimes.forEach((element) => {
      str=str+element.day+":"+element.session +","
    })
    var str2=""
    req.user.reservedTimes.forEach((element) => {
      str2=str2 + element.trainerUsername + ","
    })
   
    res.status(200).send({
      str:str,
      str2:str2
    })
  }catch(e) {
    res.status(400).send('error')
  }
})



router.get('/trainers/get-imagesForSearch' ,async(req, res) => {
  try{
    const trainers = await Trainer.find({}).select('image -_id')
    var str = ""
    trainers.forEach((element) => {
      if(element.image)
      str = str+element.image.toString("base64")+","
      else {
        str = str+""+","
      }
    })
    str=str+"stop"
    res.status(200).send({
      str
    })
  }catch(e) {
    res.status(400).send('error')
  }
    
})

router.get('/trainers/usernamesForSearch' ,async(req, res) => {
  try{
    const trainers = await Trainer.find({}).select('userName -_id')
    var str=""
    trainers.forEach((element) => {
      str = str+element.userName+","
    })
    res.status(200).send({
      str
    })
  }catch(e) {
    res.status(400).send('error')
  }
})


router.post('/users/testRouter', middleWare, async(req,res) => {

  try{
  // await exe.deleteMany({day:req.body.day})
  // res.status(200).send('ok')

  const array=await exe.find({userName:req.user.userName}).select('trainerName -_id')
  const uniqueArr = array.filter((elem, index, self) => {
    return index === self.findIndex((t) => t.trainerName === elem.trainerName);
  });
var str=""

uniqueArr.forEach((e) => {
  str=str+e.trainerName+","
})

  res.status(200).send({
    str:str
  })
} catch(e) {
  res.status(400).send('error')
}
})


router.post('/users/getMyExercisesUser', middleWare, async(req,res) => {
  try{
  const users= await exe.find({userName:req.user.userName, trainerName:req.body.trainerName.trim()})
  var strExe=""
  console.log(users.length)
  users.forEach((element) => {
   
        if(element.image)
        strExe = strExe + element.name + ":" + element.day + ":"+ element.duration  + ":"+ element.image.toString("base64") + ","
        else{
          strExe = strExe + element.name + ":" + element.day + ":"+ element.duration  + ":"+ "" + ","

        }
      
  })
  res.status(200).send({
    strExe:strExe
  })
} catch(e) {
  res.status(400).send('error')
}
})


router.post('/trainer/getDetailsExercises', middleWare, async(req,res) => {
  try{
const exer = await exe.findOne({name:req.body.name.trim()})
res.status(200).send({
  url:exer.url,
  desc:exer.desc
})
  } catch(e) {
    res.status(400).send('error')
  }
})

router.get('/trainers/getHighlyRatedNames', middleWare , async (req,res) => {
  try{
 const trainers= await Stars.find({ avgRate: { $gt: 3 } }).select(' trainerUsername -_id')
 var str=""
 trainers.forEach((element) => {
str=str+element.trainerUsername + ","
 })

res.status(200).send({
  str:str
})
  } catch(e) {
    res.status(400).send('error')
  }
})


router.get('/trainers/getHighlyRatedImages', middleWare , async (req,res) => {
  try{
    const trainers = await Stars.find({ avgRate: { $gt: 3 } }).select(' trainerUsername -_id')
    var strImage = ""
    for (let i = 0; i < trainers.length; i++) {
      const temp = await Trainer.findOne({ userName: trainers[i].trainerUsername })
      if (temp.image) {
        console.log('first')
        strImage += temp.image.toString("base64") + ","
      } else {
        strImage += "" + ","
      }
    }
    res.status(200).send({
      strImage
    })
  } catch(e) {
    res.status(400).send('error')
  }
})

router.get('/store/allProducts',  async(req,res) => {
  try{
const products = await store.find({})
var strImage=""
products.forEach((element) => {
strImage = strImage + element.image.toString('base64') + ","
})
res.status(200).send({
  strImage
})
  } catch(e) {
    res.status(400).send('error')
  }
})

router.get('/store/allProductsData',  async(req,res) => {
  try{
  const products = await store.find({})
  var names=""
  var prices=""
  var amount=""
  products.forEach((element) => {
    names = names + element.name + ","
    prices=prices+ element.price.toString()+ ","
    amount=amount+ element.amount.toString()+ ","
    })

    res.status(200).send({
      names:names,
      prices:prices,
      amount:amount
    })
  } catch(e) {
    res.status(400).send('error')
  }
})


router.post('/store/productDesc',async(req,res) => {
  try{
  const product = await store.findOne({name:req.body.name.trim()})

  res.status(200).send({
    desc:product.desc
  })
} catch(e) {
  res.status(400).send('error')
}
})

router.post('/store/buyProduct', async(req,res) => {
  try{
  const product=await store.findOne({name:req.body.name.trim()})
  product.amount = product.amount - req.body.amount
  await product.save()
  res.status(200).send('ok')
  } catch(e) {
    res.status(400).send('error')
  }
})

router.post('/store/checkProductAmount', async(req, res) => {
try{
const prod= await store.findOne({name:req.body.name.trim()})
if((prod.amount < req.body.amount) || (prod.amount == 0)) {
  return res.status(200).send('No')
}
else {
  return res.status(200).send('ok')
}
} catch(e) {
  res.status(400).send('error')
}
})

router.post('/store/setProdRate', async (req, res) => {
  try{
    const trainer = await prodStars.findOne({productName:req.body.name.trim()})
    switch (Math.round(req.body.numberOfStars)) {
        case 1:
          trainer.star1 = trainer.star1 + 1
          await trainer.save()
          break;
          
        case 2:
              trainer.star2 = trainer.star2 + 1
              await trainer.save()
          break;

        case 3:
          trainer.star3 = trainer.star3 + 1
          await trainer.save()
          break;


          case 4:
          trainer.star4 = trainer.star4 + 1
          await trainer.save()
          break;

          case 5:
          trainer.star5 = trainer.star5 + 1
          await trainer.save()
          break;
      }

      trainer.avgRate = (
        5 * trainer.star5 + 
        4 * trainer.star4 + 
        3 * trainer.star3 + 
        2 * trainer.star2 + 
        1 * trainer.star1) /(trainer.star5 + trainer.star4 + trainer.star3 + trainer.star2 + trainer.star1)

        await trainer.save()
        res.status(200).send('rated')

    } catch(e) {
        res.status(200).send('error')
    }
})

router.post('/store/getProductRating', async (req, res) => {
  try{
  
  const trainer = await prodStars.findOne({productName:req.body.name.trim()})
  res.status(200).send(trainer.avgRate.toFixed(2).toString())
  } catch(e) {
      res.status(400).send('error')
  }
})

router.get('/store/getHighlyRatedProductsNames', middleWare , async (req,res) => {
  try{
 const trainers= await prodStars.find({ avgRate: { $gt: 3 } }).select(' productName -_id')
 var str=""
 trainers.forEach((element) => {
str=str+element.productName + ","
 })

res.status(200).send({
  str:str
})
  } catch(e) {
    res.status(400).send('error')
  }
})


router.get('/store/getHighlyRatedProductsImages', middleWare , async (req,res) => {
  try{
    const trainers = await prodStars.find({ avgRate: { $gt: 3 } }).select(' productName -_id')
    var strImage = ""
    for (let i = 0; i < trainers.length; i++) {
      const temp = await store.findOne({ name: trainers[i].productName })
      if (temp.image) {
        console.log('first')
        strImage += temp.image.toString("base64") + ","
      } else {
        strImage += "" + ","
      }
    }
    res.status(200).send({
      strImage
    })
  } catch(e) {
    res.status(400).send('error')
  }
})




router.post('/trainers/get-imagesForSearchedLocation' ,async(req, res) => {
  try{
    const trainers = await Trainer.find({location:req.body.location.trim()}).select('image -_id')
    var str = ""
    trainers.forEach((element) => {
      if(element.image)
      str = str+element.image.toString("base64")+","
      else {
        str = str+""+","
      }
    })
    str=str+"stop"
    res.status(200).send({
      str
    })
  }catch(e) {
    res.status(400).send('error')
  }
    
})

router.post('/trainers/usernamesForSearchedLocation' ,async(req, res) => {
  try{
    const trainers = await Trainer.find({location:req.body.location.trim()}).select('userName -_id')
    var str=""
    trainers.forEach((element) => {
      str = str+element.userName+","
    })
    res.status(200).send({
      str
    })
  }catch(e) {
    res.status(400).send('error')
  }
})

router.get('/users/notify', middleWare, async(req, res) => {

  try {

    if(req.user.notif!="N") {
      var temp = req.user.notif
      req.user.notif="N"
      await req.user.save()
      return res.status(200).send({
        val:temp
      })
    }

    else if(req.user.notif == "N") {
      return res.status(200).send({
        val:"N"
      })
    }
  } catch(e) {
    res.status(400).send('error')
  }
})



module.exports=router

