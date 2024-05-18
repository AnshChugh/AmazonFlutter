const mongoos = require('mongoose');
const ratingSchema = require('./rating');

const productScema = new mongoos.Schema({
    name: {
        type: String,
        trim: true,
        required: true
    },
    description: {
        type: String,
        trim: true,
        required: true
    },
    price: {
        type: Number,
        required: true
    },
    quantity: {
        type: Number,
        required : true
    },
    images: [
        {
            type: String,
            required: true
        }
    ],
    category: {
        type: String,
        required: true
    },
    ratings: [ratingSchema],    

});

const Product = new mongoos.model("Product", productScema);

module.exports = Product;

