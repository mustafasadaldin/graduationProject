const mongoose=require('mongoose')

const schema=new mongoose.Schema({

    star1: {
        type:Number,
        required:false,
        default:0,
    },

    star2: {
        type:Number,
        required:false,
        default:0,
    },

    star3: {
        type:Number,
        required:false,
        default:0,
    },

    star4: {
        type:Number,
        required:false,
        default:0,
    },

    star5: {
        type:Number,
        required:false,
        default:0,
    },

    avgRate: {
        type:Number,
        required:false,
        default:0
    },

    trainerUsername: {
        type:String,
        trim:true,
        required:false,
    },
})

const stars = mongoose.model('stars', schema)

module.exports = stars