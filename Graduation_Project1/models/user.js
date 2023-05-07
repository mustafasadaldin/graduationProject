const valid=require('validator')
const mongoose=require('mongoose')
const passwordValidator=require('password-validator');
const bcrypt=require('bcryptjs');

const passwordLimits = new passwordValidator();

passwordLimits.is().min(8)
passwordLimits.is().max(100)
passwordLimits.has().uppercase()
passwordLimits.has().lowercase()
passwordLimits.has().symbols()
passwordLimits.has().digits(2)
passwordLimits.has().not().spaces()

const schema=new mongoose.Schema({

    userName:{
        type:String,
        required:true,
        unique:true,
        trim:true,
        validate(value){
        const arr = value.split(' ')
            if(arr.length!=4){
                throw new Error('not valid username')
            }
        }
    },

    email:{
        type:String,
        unique:true,
        trim:true,
        required:true,
        validate(value){
            if(!valid.isEmail(value)){
                throw new Error('not valid email')
            }
        }
    },

    password:{
        type:String,
        required:true,
        trim:true,
        validate(value){
            if(!passwordLimits.validate(value)){
                throw new Error('weak password')
            }
        }
    },

    age: {
        type:Number,
        required:true
    },

    gender:{
        type:String,
        trim:true,
        required:true
    },

    height: {
        type:Number,
        required:false,
        default:0
    },

    weight: {
        type: Number,
        required: false,
        default:0
    },
    image: {
        type:Buffer,
        required:false
    },

    membership: {
        type:String,
        required:false
    },

    membershipStart: {
        type: String,
        trim:true,
        required:false
    },

    membershipEnd: {
        type: String,
        trim:true,
        required:false,
       
    },

    trainers:[{
        classesNumber:{
            type:Number,
            required:false,
            default:0
        },
        trainerUsername: {
            type:String,
            trim:true,
            required:false
        }
    }],
    

    pin: {
        type:Number,
        required:false,
        default:0
    },

    tokens:[{
        token:{
            type:String,
            required:true
        }
    }],

    numberOfClasses:{
        type:Number,
        required:false,
        default:0
    },

    location:{
        type:String,
        trim:true,
        required:false
    },

    reservedTimes:[{
        trainerUsername:{
            type:String,
            trim:true,
            required:false
        },
        day:{
            type:String,
            trim:true,
            required:false
        },
        session:{
            type:String,
            trim:true,
            required:false
        },
        completed:{
            type:String,
            required:false,
            trim:true,
            default:"N"
        }
    }],
    notif: {
        type:String,
        required:false,
        trim:true,
        default:"N"
    }
    })
    

        schema.statics.validateUser= async (email,password)=> {
            const user2= await user.findOne({email})
          
            if(!user2) {
            return null
            }
          
            const isMatch= await bcrypt.compare(password,user2.password)
          
            if(!isMatch) {
            return null
            }
          
            return user2
          }

          schema.statics.validateEmail = async (email) => {

            const user2 = await user.findOne({email})

            if(!user2) {
                return null
            }

            return user2
            
          }
          schema.methods.toJSON = function () {
            const user = this
            const userObject = user.toObject()
        
            delete userObject.password
            delete userObject.tokens
            if(userObject.image){
                userObject.image=userObject.image.toString("base64")
            }
        
            return userObject
        }
        
          

const user=mongoose.model('users',schema)

module.exports=user