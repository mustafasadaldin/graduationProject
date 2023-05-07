const mongoose = require('mongoose')
const passwordValidator=require('password-validator');
const bcrypt=require('bcryptjs');
const valid=require('validator')

const passwordLimits = new passwordValidator();

passwordLimits.is().min(8)
passwordLimits.is().max(100)
passwordLimits.has().uppercase()
passwordLimits.has().lowercase()
passwordLimits.has().symbols()
passwordLimits.has().digits(2)
passwordLimits.has().not().spaces()

const schema = new mongoose.Schema({
    userName: {
        type:String,
        trim:true,
        unique:true,
        required:true,
        validate(value){
            const arr = value.split(' ')
                if(arr.length!=4){
                    throw new Error('not valid username')
                }
            }
    }
    ,
    email: {
        type:String,
        trim:true,
        unique:true,
        required:true,
        validate(value){
            if(!valid.isEmail(value)){
                throw new Error('not valid email')
            }
        }

    },

    gender: {
        type:String,
        required:true
    },

    password: {
        type:String,
        trim:true,
        required:true,
        validate(value){
            if(!passwordLimits.validate(value)){
                throw new Error('weak password')
            }
        }
    },

    age: {
        required:true,
        type:Number
    },

    startWorkHoures: {
        type:Number,
        required:true
    },
    image: {
        type:Buffer,
        required:false
    },

    endWorkHoures: {
        type:Number,
        required:true
    },

    pin: {
        type:Number,
        required:false,
        default:0
    },

    excperience: {
        type:String,
        required:false,
        default:"Experience not filled by trainer until now"
    },

    tokens:[{
        token:{
            type:String,
            required:true
        }
    }],

    freeTimes:[
        {
      session:{ type:String,
        trim:true,
        required:false
      }
      , day:{
        type:String,
        trim:true,
        required:false
      }
    }],

    location:{
        type:String,
        trim:true,
        required:false
    },

    reservedTimes:[
        {
         session: {type:String,
            trim:true,
            required:false
         } ,
         day:{
            type:String,
            trim:true,
            required:false
          }
        }
    ],

    workingDays:{
        type:String,
        required:true
    },
    notif: {
        type:String,
        required:false,
        trim:true,
        default:"N"
    }


})


schema.statics.validateTrainer = async (email, password) => {

            const trainer2= await trainer.findOne({email})
          
            if(!trainer2) {
            return null
            }
          
            const isMatch= await bcrypt.compare(password, trainer2.password)
          
            if(!isMatch) {
            return null
            }
          
            return trainer2
}





schema.statics.validateEmail = async (email) => {

    const trainer2 = await trainer.findOne({email})

    if(!trainer2) {
        return null
    }

    return trainer2
    
  }
  schema.methods.toJSON = function () {
    const user = this
    const userObject = user.toObject()

    delete userObject.password
    delete userObject.tokens
    if(userObject.avatar){
        userObject.avatar=userObject.avatar.toString("base64")
    }

    return userObject
}



const trainer = mongoose.model('trainers', schema)
module.exports=trainer