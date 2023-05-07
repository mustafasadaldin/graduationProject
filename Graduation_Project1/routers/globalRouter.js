const express=require('express')
const trainer=require('../models/Trainer')
const user=require('../models/user')
const admin=require('../models/Admin')
const jwt=require('jsonwebtoken')
const nodemailer = require('nodemailer');
const bcrypt=require('bcryptjs')
const router=new express.Router()




const genUserToken = async (_id)=> {
    const token = await jwt.sign({ _id },'secretKey')
    return token
    }

router.post('/login', async (req,res) => {
const user2 = await user.validateUser(req.body.email.trim(), req.body.password.trim())
    if(user2) {
  const token=await genUserToken(user2._id.toString())
  user2.tokens=user2.tokens.concat([{token:token}])
  await user2.save()
  return res.status(200).send({
    token:token,
    logged:"user",
    email:user2.email,
    username:user2.userName,
    ME:user2.membershipEnd,
    age:user2.age,
    height:user2.height,
    weight:user2.weight,
    
  })
    }

const trainer2 = await trainer.validateTrainer(req.body.email.trim(), req.body.password.trim())

if(trainer2) {
    
    const token=await genUserToken(trainer2._id.toString())
    trainer2.tokens=trainer2.tokens.concat([{token:token}])
    await trainer2.save()
    return res.status(200).send({
      token:token,
      logged:"trainer",
      email:trainer2.email,
      username: trainer2.userName,
      age:trainer2.age,
      excperience:trainer2.excperience

    })
}
    const admin2 = await admin.validateAdmin(req.body.email.trim(), req.body.password.trim())

    if(admin2) {

    const token=await genUserToken(admin2._id.toString())
    admin2.tokens=admin2.tokens.concat([{token:token}])
    await admin2.save()
    return res.status(200).send({
      token:token,
      logged:"admin",
      email:admin2.email
    })

    }

return res.status(401).send('invalid credantials')

})

router.post('/forget-password', async (req,res) => {


    const user2 = await user.validateEmail(req.body.email.trim())
    if(user2) {
        
        var transporter = nodemailer.createTransport({
            service: 'gmail',
            auth: {
              user: 'mustafa001063@gmail.com',
              pass: 'gpdfheoephmnnfat'
            }
          });
        
          const verificationCode = Math.floor(1000+Math.random()*9000)
          
          var mailOptions = {
            from: 'mustafa001063@gmail.com',
            to: user2.email,
            subject: 'Varification code',
            text: verificationCode + ''
          };
        
          await user.updateOne({email:user2.email},{pin:verificationCode})
          transporter.sendMail(mailOptions, function(error, info){
            if (error) {
            return  res.status(404).send(error);
            } else {
            return  res.status(200).send(user2.email)
            }
          });
    }

const trainer2 = await trainer.validateEmail(req.body.email.trim())

if(trainer2) {
    var transporter = nodemailer.createTransport({
        service: 'gmail',
        auth: {
          user: 'mustafa001063@gmail.com',
          pass: 'gpdfheoephmnnfat'
        }
      });
    
      const verificationCode = Math.floor(1000+Math.random()*9000)
      
      var mailOptions = {
        from: 'mustafa001063@gmail.com',
        to: trainer2.email,
        subject: 'Varification code',
        text: verificationCode + ''
      };
    
      await trainer.updateOne({email:trainer2.email},{pin:verificationCode})
      transporter.sendMail(mailOptions, function(error, info){
        if (error) {
         return res.status(404).send(error);
        } else {
        return  res.status(200).send(trainer2.email)
        }
      });
    
}
    const admin2 = await admin.validateEmail(req.body.email.trim())

    if(admin2) {

        var transporter = nodemailer.createTransport({
            service: 'gmail',
            auth: {
              user: 'mustafa001063@gmail.com',
              pass: 'gpdfheoephmnnfat'
            }
          });
        
          const verificationCode = Math.floor(1000+Math.random()*9000)
          
          var mailOptions = {
            from: 'mustafa001063@gmail.com',
            to: admin2.email,
            subject: 'Varification code',
            text: verificationCode + ''
          };
        
          await admin.updateOne({email:admin2.email},{pin:verificationCode})
          transporter.sendMail(mailOptions, function(error, info){
            if (error) {
             return res.status(404).send(error);
            } else {
             return res.status(200).send(admin2.email)
            }
          });    
        }

        if(!user2 && !trainer2 && !admin2)
        return res.status(401).send('invalid credantials')


})



router.post('/verification-code', async (req,res) => {

  const userVerification=parseInt(req.body.pin)
  const user2 = await user.validateEmail(req.body.email.trim())

  if(user2) {
    if(user2.pin==userVerification) {
      return res.status(200).send('user verified')
    }
    return res.status(401).send('invalid code')
    
  }

  const trainer2 = await trainer.validateEmail(req.body.email.trim())
  if(trainer2) {
    if(trainer2.pin==userVerification) {
      return res.status(200).send('trainer verified')
    }
    return res.status(401).send('invalid code')
  }


  const admin2 = await admin.validateEmail(req.body.email.trim())
  if(admin2) {
    if(admin2.pin==userVerification) {
      return res.status(200).send('admin verified')
    }
    return res.status(401).send('invalid code')
  }

  return res.status(400).send('invalid credantials')

})


router.post('/update-password', async(req, res) => {

  const user2 = await user.validateEmail(req.body.email.trim())

  if(user2) {
    try{
    user2.password= req.body.password.trim()
    await user2.save()
    req.body.password= await bcrypt.hash(req.body.password.trim(), 8)
    user2.password=req.body.password
    await user2.save()
    return res.status(200).send()
    } catch(e) {
      
      return  res.status(400).send('too weak password')
    
    }
  }

  const trainer2 = await trainer.validateEmail(req.body.email.trim())

  if(trainer2) {
    try{
      trainer2.password= req.body.password.trim()
    await trainer2.save()
    req.body.password= await bcrypt.hash(req.body.password.trim(), 8)
    trainer2.password=req.body.password
    await trainer2.save()
    return res.status(200).send()
    } catch(e) {
    
      return  res.status(400).send('too weak password')
    
    }
  }

  const admin2 = await admin.validateEmail(req.body.email.trim())
  if(admin2) {
    try{
      
    admin2.password= req.body.password.trim()
    await admin2.save()
    req.body.password= await bcrypt.hash(req.body.password.trim(), 8)
    admin2.password=req.body.password
    await admin2.save()
    return res.status(200).send()
    } catch(e) {
      
       return res.status(400).send('too weak password')
    
    }
  }

  return res.status(401).send('invalid credantials')

})


module.exports=router