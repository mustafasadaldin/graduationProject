const mongoose=require('mongoose')

const connectionUrl='mongodb://127.0.0.1:27017/gymDB'

mongoose.connect(connectionUrl,{
    useNewUrlParser:true
})

