const req=require('postman-request')
const url = "https://api.openweathermap.org/data/2.5/weather?q=Nablus&appid=b0a22dc9fdf5c1a0eb70ffc8c92b4068"+"&t=" + Date.now()
req({url:url,json:true},(error,response)=>{
if(!error){
   console.log(response.body)
 console.log(response.body.weather[0].main)
}
else{
    console.log('there is an error')
}
})
