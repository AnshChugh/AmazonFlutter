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





adminRouter.get('/admin/analytics',admin, async (req,res) => {
    try{
        const orders = Order.find({});
        let totalEarnings = 0;
        for(let i = 0; i < orders.length;i++){
            totalEarnings += orders[i].totalPrice;
        }
        // category wise product earning
        let mobileEarnings =  await fetchCategoryWiseProducts('Mobiles');
        let essentialsEarnings =  await fetchCategoryWiseProducts('Essentials');
        let appliancesEarnings =  await fetchCategoryWiseProducts('Appliances');
        let booksEarnings =  await fetchCategoryWiseProducts('Books');
        let fashionEarnings =  await fetchCategoryWiseProducts('Fashion');

        let earnings = {totalEarnings , mobileEarnings, essentialsEarnings , appliancesEarnings, booksEarnings, fashionEarnings};
        res.json(earnings);
        
    }catch(err){
        res.status(500).json({error:err.message});
    }
});

async function fetchCategoryWiseProducts(category){
    let totalEarnings = 0;
    let categoryOrders = await Order.find({
        'products.product.category': category
    });
    for(let i = 0; i < categoryOrders.length; i++){
        for(let j = 0; j <  categoryOrders[i].products.length;j++){
            totalEarnings += categoryOrders[i].products[j].quantity *  categoryOrders[i].products[j].price;
        }
    }
    return totalEarnings;
}

module.exports = {adminRouter:adminRouter};
