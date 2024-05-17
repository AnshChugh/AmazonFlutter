const express = require('express');
const adminRouter = express.Router();
const admin = require('../middlewares/admin');
const Product = require('../models/product');
// creating an admin middle ware
// done

adminRouter.post('/admin/add-product',admin,async(req,res)=>{
    try{
        const {name, description, images,quantity, price,category} = req.body;
        let product = new Product({name,description,images,price,category,quantity});
        product = await product.save();
        res.json(product);
    }catch(err){
        res.status(500).json({error: err.message});
    }
});

// get all products



module.exports = {adminRouter:adminRouter};
