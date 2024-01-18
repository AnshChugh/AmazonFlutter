// import dependencies
const express = require('express')
const mongoose = require('mongoose');

// import other files
const db = require('./dbCredentials')
const authRouter = require('./routes/auth');



// INIT
const app = express()
const port = 3000

// middleware
// client -> middleware ->  server -> client
app.use(express.json());
app.use(authRouter.authRouter); 

//connections
mongoose.connect(db).then(()=>{
    console.log('connection successful');
}).catch((e)=>{console.log(e)});

app.listen(port,"192.168.137.1",()=>{
    console.log(`example program running on ${port}`)
})



