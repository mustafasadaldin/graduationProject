const express=require('express')
const trainer=require('../models/Trainer')
const bcrypt=require('bcryptjs')
const jwt=require('jsonwebtoken')
const nodemailer = require('nodemailer');
const User=require('../models/user')
const multer=require('multer')
const sharp=require('sharp')
const stars=require('../models/Stars')
const exe=require('../models/exe')
const router=new express.Router()

const upload = multer({
  limits: {
      fileSize: 1000000
  },
})





const middleWare= async (req,res,next)=>{
  try{
    const token = req.header('token')
  
    const isValid = jwt.verify(token,'secretKey')
  
    const Trainer=await trainer.findOne({_id: isValid._id,'tokens.token':token})
    if(!Trainer)
    return res.status(401).send('not authenticated')

    req.Trainer=Trainer
    req.token=token
    next()
  } catch(e){
    res.status(401).send('not authenticated')
  }
  }




const genRandomNumber = (length) => {
    return Math.floor(Math.random()
    * (length-1) + 1)
}

const genStrongPass= () =>{

    var pass = '';
    const smallAlph = 'abcdefghijklmnopqrstuvwxyz'
    const capitalAlph = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    const digits = '0123456789'
    const symbols = '@#$'
    const str = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' +
            'abcdefghijklmnopqrstuvwxyz0123456789@#$';
    max=2
    min=0
    pass+= smallAlph.charAt(genRandomNumber(smallAlph.length))
    pass+= capitalAlph.charAt(genRandomNumber(capitalAlph.length))
    pass+= digits.charAt(genRandomNumber(digits.length))
    pass+= digits.charAt(genRandomNumber(digits.length))
    pass+= symbols.charAt(genRandomNumber(Math.floor(Math.random() * (max - min + 1) + min)))

      
    for (let i = 1; i <= 3; i++) {
        var char = Math.floor(Math.random()
                    * str.length + 1);
          
        pass += str.charAt(char)
    }
      
    return pass;

}


router.post('/trainer/sign-up', async (req,res) => {
try{
    const user= await User.findOne({ email:req.body.email.trim()})
    if((user!=null)||(req.body.email.trim()=='mustafa001063@gmail.com'))
    return res.status(400).send('not unique email')

    const user2=await User.findOne({ userName:req.body.userName.trim()})
    if(user2!=null)
    return res.status(400).send('not unique username')

    const password = genStrongPass()
    console.log(password)
    const hashedPassword = await bcrypt.hash(password,8)
    const trainer2=new trainer({
        ...req.body,
        password:hashedPassword
    })
    await trainer2.save()
    var transporter = nodemailer.createTransport({
        service: 'gmail',
        auth: {
          user: 'mustafa001063@gmail.com',
          pass: 'gpdfheoephmnnfat'
        }
      });
      const sendTo=req.body.email.trim()

      var mailOptions = {
        from: 'mustafa001063@gmail.com',
        to: sendTo,
        subject: 'log in password',
        text: password
      };
    
      transporter.sendMail(mailOptions, function(error, info){
        if (error) {
          res.status(404).send(error);
        } else {
          res.status(200).send(sendTo)
        }
      });

      const trainerStars = new stars({
        trainerUsername:req.body.userName
      })
      await trainerStars.save()
    } catch(e){
       
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

          else if(e.errors.hasOwnProperty('startWorkHoures')) {
            res.status(400).send('startWorkHoures is required')
          }

          else if(e.errors.hasOwnProperty('endWorkHoures')) {
            res.status(400).send('endWorkHoures is required')
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

router.post('/trainers/update-password',middleWare ,async(req,res) => {

  try{
  req.Trainer.password=req.body.password.trim()
  await req.Trainer.save()
  req.Trainer.password= await bcrypt.hash(req.body.password.trim(),8)
  await req.Trainer.save()
  return res.status(200).send('updated')
  } catch(e) {
    return res.status(400).send('too weak password')
  }
})


router.post('/trainer/info', middleWare, async(req,res) => {
  try {
    if(req.body.hasOwnProperty('username')) {
      const user=await User.findOne({userName:req.body.username.trim()})
      if(user)
      return res.status(400).send('not unique username')
      const tStar = await stars.findOne({trainerUsername:req.Trainer.userName})
        req.Trainer.userName = req.body.username
        await req.Trainer.save()
        tStar.trainerUsername=req.body.username
        await tStar.save()
      }

      if(req.body.hasOwnProperty('age')) {
        req.Trainer.age=parseInt(req.body.age)
        await req.Trainer.save()
      }

      if(req.body.hasOwnProperty('excperience')){
      req.Trainer.excperience=req.body.excperience.trim()
      await req.Trainer.save()
      }

      res.status(200).send('changed')
  } catch(e) {

    if(e.hasOwnProperty('errors')) {
      if(e.errors.hasOwnProperty('userName')){
       return res.status(400).send('invalid username')
    }
    }

    else if(e.hasOwnProperty('keyValue')) {
      if(e.keyValue.hasOwnProperty('userName')) {
         return res.status(400).send('not unique username')
      }
    }
      return res.status(400).send('error')
  }
})

router.post('/trainer/log-out',middleWare, async (req,res)=>{

  req.Trainer.tokens=req.Trainer.tokens.filter((element)=>{
    return element.token!=req.token
  })
  await req.Trainer.save()
  res.status(200).send('done')
})

router.post('/trainer/deleteMe', middleWare, async(req,res) => {
  try{
    await stars.deleteOne({trainerUsername:req.Trainer.userName})
  await trainer.deleteOne({_id:req.Trainer._id})
  res.status(200).send('deleted')
  } catch(e) {
    console.log(e)
  }
})



router.post('/trianers/image', middleWare, upload.single('upload'), async (req, res) => {
  console.log('enter')
  const buffer = await sharp(req.file.buffer).resize({ width: 250, height: 250 }).png().toBuffer()
  req.Trainer.image = buffer
  
  await req.Trainer.save()
  res.send()
}, (error, req, res, next) => {
  res.status(400).send({ error: error.message })
})

router.post('/trianers/image1', async (req, res) => {
  try {
    console.log('here')
      const Trainer2 = await trainer.findOne({email:req.body.email})
      res.send(Trainer2.image.toString("base64"))
  } catch (e) {
      res.status(404).send()
  }
})

router.post('/trainer/fill-hours', async(req,res) => {
try{
  var numberOfDays = req.body.workingDays.trim().split(',')
  console.log(numberOfDays.length)
  const trainer2 = await trainer.findOne({userName:req.body.username.trim()})
  var endHours=parseInt(trainer2.endWorkHoures)
  var startHours=parseInt(trainer2.startWorkHoures)
  var classEnd = startHours+1
  var loop=endHours-startHours
  for(var j=0;j<(numberOfDays.length-1);j++) {
  for(var i=0;i<loop;i++) {
    console.log('here')

    var classTime = startHours.toString()+ " - " + classEnd 
    trainer2.freeTimes=trainer2.freeTimes.concat([{session:classTime, day:numberOfDays[j]}])
    classEnd++
    startHours++
  }
   endHours=parseInt(trainer2.endWorkHoures)
   startHours=parseInt(trainer2.startWorkHoures)
  classEnd = startHours+1
  loop=endHours-startHours
}
  await trainer2.save()
  
  res.status(200).send(trainer2.freeTimes)
 } catch(e) {
 res.status(400).send(e)
 }
})

router.post('/users/getMyUsersImages', middleWare, async(req,res) => {
  try{
  const users= await User.find({'reservedTimes.trainerUsername':req.Trainer.userName})
  var strImage=""
  users.forEach((element) => {
    if(element.image)
    strImage = strImage + element.image.toString("base64") + ","
    else{
      strImage = strImage + "" + ","
    }
  })
  res.status(200).send({
    strImage:strImage
  })
} catch(e) {
  res.status(400).send('error')
}
})



router.post('/users/getMyUsersUserNames', middleWare, async(req,res) => {
  try{
  const users= await User.find({'reservedTimes.trainerUsername':req.Trainer.userName})
  var strNames=""
  users.forEach((element) => {
    strNames = strNames + element.userName + ","
  })
  res.status(200).send({
    strNames:strNames
  })
} catch(e) {
  res.status(400).send('error')
}
})




router.post('/users/getMyUsersTimes', middleWare, async(req,res) => {
  try{
  const users= await User.find({'reservedTimes.trainerUsername':req.Trainer.userName})
  var strTimes=""
  users.forEach((element) => {
    element.reservedTimes.forEach((ele) => {
      if(ele.trainerUsername == req.Trainer.userName){
        if(element.image)
      strTimes = strTimes + ele.day + ":" + ele.session + ":"+ element.image.toString("base64") + ":"+ element.userName + ","
        else{
          strTimes = strTimes + ele.day + ":" + ele.session + ":"+ "" + ":"+ element.userName + ","

        }
      }
    })
  })
  res.status(200).send({
    strTimes:strTimes
  })
} catch(e) {
  res.status(400).send('error')
}
})


  router.post('/users/getMyUserAllInfo', middleWare, async(req,res) => {
    try{
      console.log('i entered')
const user=await User.findOne({userName:req.body.username.trim()})
const array=user.trainers.filter((element)=>{
  return element.trainerUsername == req.Trainer.userName
})
if(user.image){
  return res.status(200).send({
    location:user.location,
    email:user.email,
    age:user.age,
    height:user.height,
    weight:user.weight,
    numberOfCalsses:array[0].classesNumber,


  })
}

else{
 return res.status(200).send({
    location:user.location,
    email:user.email,
    age:user.age,
    height:user.height,
    weight:user.weight,
    numberOfCalsses:array[0].classesNumber,


  })
}

    } catch(e) {
      res.status(400).send('error')
    }

  })



  router.post('/users/getMyUserAllInfoImage', middleWare, async(req,res) => {
    try{
      console.log('i entered222222')
const user=await User.findOne({userName:req.body.username.trim()})
if(user.image){
  return res.status(200).send({
    image:user.image.toString("base64"),


  })
}

else{
 return res.status(200).send({
    image:"",


  })
}

    } catch(e) {
      res.status(400).send('error')
    }

  })

  router.post('/users/markCompleted', middleWare,async(req,res) => {
    try{
    const user = await User.findOne({userName:req.body.username.trim()})
    user.notif=req.Trainer.userName
    user.reservedTimes.forEach((element) => {
      if((element.day==req.body.day.trim())&&(element.session==req.body.session.trim())) {
        element.completed="Y"
      }
    })
    user.trainers.forEach((element) => {
      if(element.trainerUsername == req.Trainer.userName) {
        element.classesNumber = element.classesNumber-1
      }
    })
    await user.save()

    res.status(200).send('done')
  } catch(e) {
    res.status(400).send('error')
  }
  })

  router.post('/users/markNotComp', middleWare, async(req,res) => {
    try{
      console.log('onthe router')
    const users=await User.find({'reservedTimes.trainerUsername':req.Trainer.userName})
    users.forEach(async(element) => {
      element.reservedTimes.forEach((ele) => {
        if(ele.day!=req.body.day){
          ele.completed="N"
        }
      })
      await element.save()
    }
    )
    res.status(200).send('done')
  } catch(e) {
    res.status(400).send('error')
  }
  })


  router.post('/users/getCompleted', middleWare, async(req,res) => {
    try{
    const users=await User.find({'reservedTimes.trainerUsername':req.Trainer.userName})
    var strTimes=""

    users.forEach((element) => {
      element.reservedTimes.forEach((ele) => {
        if((ele.trainerUsername == req.Trainer.userName)&&(ele.completed=="Y")&&(ele.day==req.body.day.trim())){
          if(element.image)
        strTimes = strTimes + ele.day + ":" + ele.session + ":"+ element.image.toString("base64") + ":"+ element.userName + ","
          else{
            strTimes = strTimes + ele.day + ":" + ele.session + ":"+ "" + ":"+ element.userName + ","
  
          }
        }
      })
    })
    res.status(200).send({
      strTimes:strTimes
    })
  } catch(e) {
    res.status(400).send('error')
  }
  })


  router.post('/users/getNotCompleted', middleWare, async(req,res) => {
    try{
    const users=await User.find({'reservedTimes.trainerUsername':req.Trainer.userName})
    var strTimes=""

    users.forEach((element) => {
      element.reservedTimes.forEach((ele) => {
        if((ele.trainerUsername == req.Trainer.userName)&&(ele.completed=="N")&&(ele.day==req.body.day.trim())){
          if(element.image)
        strTimes = strTimes + ele.day + ":" + ele.session + ":"+ element.image.toString("base64") + ":"+ element.userName + ","
          else{
            strTimes = strTimes + ele.day + ":" + ele.session + ":"+ "" + ":"+ element.userName + ","
  
          }
        }
      })
    })
    res.status(200).send({
      strTimes:strTimes
    })
  } catch(e) {
    res.status(400).send('error')
  }
  })

  router.get('/trainers/get-users-imagesForSearch' ,async(req, res) => {
    try{
      const trainers = await User.find({}).select('image -_id')
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
  
  router.get('/trainers/users-usernamesForSearch' ,async(req, res) => {
    try{
      const trainers = await User.find({}).select('userName -_id')
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

  router.get('/trainers/getMyRatePls', middleWare, async(req,res) => {
    try{

      const trainer=await stars.findOne({trainerUsername:req.Trainer.userName})
      res.status(200).send({
        avgRate:trainer.avgRate
      })
      console.log('ifsydsufhhhh')
    } catch(e) {
      res.status(400).send('error')
    }
  })




  router.post('/users/getMyUserAllInfoSearchTrainer', middleWare, async(req,res) => {
    try{
      console.log('i entered')
const user=await User.findOne({userName:req.body.username.trim()})
  return res.status(200).send({
    location:user.location,
    email:user.email,
    age:user.age,
    height:user.height,
    weight:user.weight,


  })


    } catch(e) {
      res.status(400).send('error')
    }

  })


  

  
router.post('/trianers/imageExercise', middleWare, upload.single('upload'), async (req, res) => {
  console.log('enter')
  const buffer = await sharp(req.file.buffer).resize({ width: 250, height: 250 }).png().toBuffer()
 // req.Trainer.image = buffer
  
  const exersice=new exe({
    image:buffer,
    trainerName:req.Trainer.userName
  })
  await exersice.save()
  res.send()
}, (error, req, res, next) => {
  res.status(400).send({ error: error.message })
})

router.post('/trianers/Exercises', middleWare, async (req, res) => {
  
  const trainer=await exe.findOne({trainerName:req.Trainer.userName}).sort({ _id: -1 }) .limit(1) .exec()

  trainer.name=req.body.name
  trainer.duration=req.body.duration
  trainer.desc=req.body.desc
  trainer.userName=req.body.userName
  trainer.url=req.body.url
  trainer.day=req.body.day
  
  await trainer.save()
  res.status(200).send('done')
})


router.post('/trainers/get-users-imagesForSearchedLoc' ,async(req, res) => {
  try{
    const trainers = await User.find({location:req.body.location.trim()}).select('image -_id')
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

router.post('/trainers/users-usernamesForSearchedLoc' ,async(req, res) => {
  try{
    const trainers = await User.find({location:req.body.location.trim()}).select('userName -_id')
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

router.get('/trainers/notify', middleWare, async(req, res) => {

  try {

    if(req.Trainer.notif!="N") {
      var temp = req.Trainer.notif
      req.Trainer.notif="N"
      await req.Trainer.save()
      return res.status(200).send({
        val:temp
      })
    }

    else if(req.Trainer.notif == "N") {
      return res.status(200).send({
        val:"N"
      })
    }
  } catch(e) {
    res.status(400).send('error')
  }
})


module.exports=router