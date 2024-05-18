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

productRouter.post('/api/rate-product', auth , async (req,res)=>{
    try{
        const {id, rating} = req.body;
        let product = await Product.findById(id);
        for(let i = 0;i < product.ratings.length;i++){
            if(product.ratings[i].userId == req.user){
                product.ratings.splice(i,1);
                break;
            }
        }
        const ratingSchema = {
            userId: req.user,
            rating:rating
        };
        product.ratings.push(ratingSchema);
        product = await product.save();
        res.json(product);
        
    }catch(e){
        res.status(500).json({error:e.message});
    }
});

module.exports = {productRouter:productRouter};