const express = require('express');
const User = require('../models/user');


const authRouter = express.Router()

authRouter.post('/api/signup',async (req,res)=>{
    // get the data from client
    // post the data in database
    // return the response to data

    console.log(req.body);

    const {name, email,password} = req.body;
    
    const existingUser = await User.findOne({email});

    if(existingUser){
        return res.status(400).json({msg:"User with same email address already exists"});
    }

    let user = new User({email , name , password});
    
    user = await user.save();
    
    res.json({user});

});


// export file
module.exports = {authRouter:authRouter};