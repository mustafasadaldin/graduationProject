const express=require('express')
const admin=require('../models/Admin')
const bcrypt=require('bcryptjs')
const jwt=require('jsonwebtoken')
const nodemailer = require('nodemailer');
const store = require('../models/store')
const prodStars= require('../models/productsStars')
const user = require('../models/user')
const trainer = require('../models/Trainer')
const stars= require('../models/Stars')
const multer=require('multer')
const sharp=require('sharp')
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
    
      const Admin=await admin.findOne({_id: isValid._id,'tokens.token':token})
      if(!Admin)
      return res.status(401).send('not authenticated')

      req.Admin=Admin
      req.token=token
      next()
    } catch(e){
      res.status(401).send('not authenticated')
    }
    }
    
    router.post('/admin/update-password',middleWare ,async(req,res) => {

        try{
        req.Admin.password=req.body.password.trim()
        await req.Admin.save()
        req.Admin.password= await bcrypt.hash(req.body.password.trim(),8)
        await req.Admin.save()
        return res.status(200).send('updated')
        } catch(e) {
          return res.status(400).send('too weak password')
        }
      })

      router.post('/admin/log-out',middleWare, async (req,res)=>{

        req.Admin.tokens=req.Admin.tokens.filter((element)=>{
          return element.token!=req.token
        })
        await req.Admin.save()
        res.status(200).send('done')
      })
    

      router.post('/admin/addProduct', middleWare, async(req,res) => {
const s = new store({
  name:req.body.name.trim(),
  price:req.body.price,
  amount:req.body.amount,
  desc:req.body.desc
})
const prodNew=new prodStars ({
  productName:req.body.name.trim()
})
await s.save()
await prodNew.save()
await res.status(200).send('done')
      })


      router.post('/store/productImage', middleWare, upload.single('upload'), async (req, res) => {
        const buffer = await sharp(req.file.buffer).resize({ width: 250, height: 250 }).png().toBuffer()
        const s=await store.findOne({}, {}, { sort: { '_id' : -1 } }) .limit(1) .exec()

       s.image=buffer
        await s.save()
        res.status(200).send()
      }, (error, req, res, next) => {
        res.status(400).send({ error: error.message })
      })
      
      router.post('/admin/deleteAllProduct', async(req,res) => {
        await store.deleteMany({})
        res.status(200).send('deleted')
      })
 
      router.post('/store/deleteProduct', middleWare, async(req, res) => {
        try {

         await store.deleteOne({name:req.body.name.trim()})
         await prodStars.deleteOne({productName:req.body.name.trim()})
         res.status(200).send('deleted')
        } catch(e) {
          res.status(400).send('error')
        }
      })


      router.post('/users/deleteUsersFromAdmin', middleWare, async(req,res) => {
        try {

          await user.deleteOne({userName:req.body.name.trim()})
          res.status(200).send('deleted')
         } catch(e) {
           res.status(400).send('error')
         }
      })

      router.post('/users/deleteTrainersFromAdmin', middleWare, async(req,res) => {
        try {

          await trainer.deleteOne({userName:req.body.name.trim()})
          await stars.deleteOne({trainerUsername: req.body.name.trim()})
          res.status(200).send('deleted')
         } catch(e) {
           res.status(400).send('error')
         }
      })


      router.post('/admin/updateProductFromAdmin', middleWare, async(req,res) => {
        try{
       const prod= await store.findOne({name:req.body.name.trim()})
       if(req.body.hasOwnProperty('pName')) {
        const prodS=await prodStars.findOne({productName:req.body.name.trim()})
        prod.name=req.body.pName.trim()
        await prod.save()
        prodS.productName = req.body.pName.trim()
        await prodS.save()
       }
       
      else if(req.body.hasOwnProperty('price')) {
        prod.price=req.body.price
        await prod.save()
       }

       else if(req.body.hasOwnProperty('amount')) {
        prod.amount=req.body.amount
        await prod.save()
       }

       else if(req.body.hasOwnProperty('desc')) {
        prod.desc=req.body.desc.trim()
        await prod.save()
       }

        await res.status(200).send('done')
      } catch(e) {
        res.status(400).send('error')
      }
              })


              router.post('/store/UpdateproductImageAdmin', middleWare, upload.single('upload'), async (req, res) => {
                const buffer = await sharp(req.file.buffer).resize({ width: 250, height: 250 }).png().toBuffer()
                const s=await store.findOne({name:req.query.name.trim()})
               s.image=buffer
                await s.save()
                res.status(200).send()
              }, (error, req, res, next) => {
                res.status(400).send({ error: error.message })
              })

              router.post('/store/getProdInfoAdmin', middleWare, async(req,res) => {
                try{
                const prod=await store.findOne({name:req.body.name.trim()})
                res.status(200).send({
                  price:prod.price.toString(),
                  amount:prod.amount.toString(),
                  desc:prod.desc,
                  image:prod.image.toString('base64')

                })
                } catch(e) {
                  res.status(400).send('error')
                }

              })
     
              router.post('/admin/getUserInfoAdmin', async(req, res) => {
                try{
                const userFromDb = await user.findOne({userName: req.body.name.trim()})
                if(userFromDb.image) {
                res.status(200).send({
                  email:userFromDb.email,
                  location:userFromDb.location,
                  age:userFromDb.age.toString(),
                  image:userFromDb.image.toString('base64'),
                  me:userFromDb.membershipEnd
                })
              }
              else if(!userFromDb.image) {
                res.status(200).send({
                  email:userFromDb.email,
                  location:userFromDb.location,
                  age:userFromDb.age.toString(),
                  image:"",
                  me:userFromDb.membershipEnd
                })
              }
                } catch(e) {
                  res.status(400).send('error')
                }
              })


              
router.post('/trainers/getPersonalUsernamesAdmin', middleWare, async(req,res) => {
  try{
    const userFromDb = await user.findOne({userName:req.body.name.trim()})
  var str=""
  if(userFromDb .trainers.length!=0){
    userFromDb .trainers.forEach((element) => {
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


router.post('/trainers/getPersonalTrainersImages1Admin', middleWare,async(req,res) => {

  try{
    const userFromDb = await user.findOne({userName:req.body.name.trim()})
  var str=""
  var strImage=""
  if(userFromDb.trainers.length!=0){
    userFromDb.trainers.forEach((element) => {
    str = str+element.trainerUsername+","
  })
  var array1 = str.split(',')
  for(var i=0; i<(array1.length-1); i++) {
    var temp= await trainer.findOne({userName:array1[i]})
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


router.post('/trainers/getPersonalTrainersRates1Admin', middleWare, async(req,res) => {
  try{
  var str=""
  var strRate=""
  const userFromDb = await user.findOne({userName:req.body.name.trim()})
  if(userFromDb.trainers.length!=0){
    userFromDb.trainers.forEach((element) => {
    str = str+element.trainerUsername+","
  })
  var array1 = str.split(',')
  for(var i=0; i<(array1.length-1); i++) {
    var temp= await stars.findOne({trainerUsername:array1[i]})
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




router.post('/trainer/all-infoAdmin', middleWare,async(req,res) => {
  try{
  const trainer1 = await trainer.findOne({userName:req.body.username.trim()})
  if(trainer1) {
    if(!trainer1.image) {
   return res.status(200).send({
      email:trainer1.email,
      age:trainer1.age,
      experience:trainer1.excperience,
      image:"",
      startWorkHoures:trainer1.startWorkHoures,
      endWorkHoures:trainer1.endWorkHoures,
      location:trainer1.location
    })
  }

  else {
    return res.status(200).send({
      email:trainer1.email,
      age:trainer1.age,
      experience:trainer1.excperience,
      image:trainer1.image.toString("base64"),
      startWorkHoures:trainer1.startWorkHoures,
      endWorkHoures:trainer1.endWorkHoures,
      location:trainer1.location
    })
  }

  }
  }catch(e) {
    res.status(400).send('error')
  }
})
router.post('/trainer/getTrainerRatingAdmin', middleWare, async (req, res) => {
  try{
  const trainer1 = await stars.findOne({trainerUsername:req.body.username.trim()})
  res.status(200).send(trainer1.avgRate.toFixed(2).toString())
  } catch(e) {
      res.status(400).send('error')
  }
})
module.exports=router