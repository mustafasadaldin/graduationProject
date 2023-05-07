const mongoose=require('mongoose')

const schema=new mongoose.Schema({

    name: {
        type:String,
        required:false,
        trim:true,
        default:"empty",
    },

    price: {
        type:Number,
        required:false,
        default:0,
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

    amount: {
        type:Number,
        required:false,
        default:0,
    },

    Rate:{
        type:Number,
        required:false,
        default:0
    }
   

})

const store = mongoose.model('store', schema)

module.exports = store