const mongoose=require('mongoose')
const valid=require('validator')
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

    email: {
        type:String,
        required:true,
        trim:true,
        unique:true,
        validate(value){
            if(!valid.isEmail(value)){
                throw new Error('not valid email')
            }
        }
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

    image: {
        type:Buffer,
        required:false
    },

    pin:{
        type:Number,
        required:false,
        default:0
    },

    tokens: [{
        token: {
        type: String,
        required:true
        }
        
    }]
})


schema.statics.validateAdmin = async (email, password) => {
    const admin2 = await admin.findOne({email})

    if(!admin2)
    return null

    const isMatch = await bcrypt.compare(password, admin2.password)

    if(!isMatch)
    return null

    return admin2

}


schema.statics.validateEmail = async (email) => {

    const admin2 = await admin.findOne({email})

    if(!admin2) {
        return null
    }

    return admin2
    
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



const admin=mongoose.model('admin',schema)

const initFunction = async () => { 

    const admins = await admin.find({})

    if(admins.length==0) {
        const pass= await bcrypt.hash('0597633980$$Mm',8)
        const adminAdd= new admin({
            email:'mustafa001063@gmail.com',
            password: pass
        })
        adminAdd.save()
    }

}
initFunction()

module.exports=admin