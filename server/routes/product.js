const express = require('express');
const productRouter = express.Router();
const auth = require('../middlewares/auth');
const Product = require('../models/product');

// /api/products?category=Essentials
productRouter.get('/api/products', auth, async (req,res) => {
    try{

        const products = await Product.find({category:req.query.category});
        res.json(products);
        
    }catch(err){
        res.status(500).json({error:err.message});
    }
});

// get request for search query
productRouter.get('/api/products/search/:searchQuery', auth, async (req,res)=>{
    try{
        const products = await Product.find({name: {$regex: req.params.searchQuery, $options: "i"}});
        res.json(products);

    }catch(err){
        res.status(500).json({error:err.message});
    }
});

module.exports = {productRouter:productRouter};