const mongoos = require('mongoose');

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

});

const Product = new mongoos.model("Product", productScema);

module.exports = Product;

