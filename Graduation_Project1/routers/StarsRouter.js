const express=require('express')
const User=require('../models/user')
const stars = require('../models/Stars')
const trainer = require('../models/Trainer')
const jwt=require('jsonwebtoken')

const router=new express.Router()

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
        console.log('here')
      res.status(401).send('not authenticated')
    }
}    


router.post('/trainer/rating', middleWare, async (req, res) => {
    try{
    const trainer = await stars.findOne({trainerUsername:req.body.username.trim()})
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


router.post('/trainer/getTrainerRating', middleWare, async (req, res) => {
    try{
    const trainer = await stars.findOne({trainerUsername:req.body.username.trim()})
    res.status(200).send(trainer.avgRate.toFixed(2).toString())
    } catch(e) {
        res.status(400).send('error')
    }
})

module.exports=router