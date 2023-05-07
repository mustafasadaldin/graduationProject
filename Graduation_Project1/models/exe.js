const mongoose=require('mongoose')

const schema=new mongoose.Schema({

    name: {
        type:String,
        required:false,
        trim:true,
        default:"empty",
    },

    duration: {
        type:String,
        required:false,
        trim:true,
        default:"empty",
    },

    desc: {
        type:String,
        required:false,
        trim:true,
        default:"empty",
    },

    image: {
        type:Buffer,
        required:false,
    },

    trainerName: {
        type:String,
        required:false,
        trim:true,
        default:"empty",
    },

    userName: {
        type:String,
        required:false,
        trim:true,
        default:"empty"
    },

    day:{
        type:String,
        required:false,
        trim:true,
        default:"empty"
    },

    url:{
        type:String,
        required:false,
        trim:true,
        default:"empty"
    }

})

const exe = mongoose.model('exercises', schema)

module.exports = exe