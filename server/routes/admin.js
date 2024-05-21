const express = require('express');
const adminRouter = express.Router();
const admin = require('../middlewares/admin');
const {Product} = require('../models/product');
const {Order} = require('../models/order');
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

adminRouter.get('/admin/get-products',admin, async (req,res) => {
    try{
        const products = await Product.find({})
        res.json(products);
        
    }catch(err){
        res.status(500).json({error:err.message});
    }
});
adminRouter.get('/admin/get-orders',admin, async (req,res) => {
    try{
        const orders = await Order.find({});
        res.json(orders);
        
    }catch(err){
        res.status(500).json({error:err.message});
    }
});

adminRouter.post('/admin/delete-product', admin, async (req,res) => {
    try{
        const {id} = req.body;

        // TODO: delete the images from server before removing product from database
        // remove the product
        await  Product.findByIdAndDelete(id);
        res.status(200);
        
    }catch(e){
        res.status(500).json({error:e.message});
    }
});
adminRouter.post('/admin/change-order-status', admin, async (req,res) => {
    try{
        const {id , status} = req.body;
        let order = await Order.findById(id);
        order.status = status;
        order = await order.save();
        res.json(order);
        
    }catch(e){
        res.status(500).json({error:e.message});
    }
});




module.exports = {adminRouter:adminRouter};
