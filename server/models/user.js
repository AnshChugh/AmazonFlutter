const mongoos = require('mongoose');
const { productSchema} = require('./product');

const userScema = new mongoos.Schema({
    name: {
        type: String,
        trim: true,
        required: true
    },
    email: {
        required: true,
        type: String,
        trim: true,
        validate: {
            validator: (value) => {
                return /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test(value);
            },
            message: "Please enter a valid email address"
        },
    },
    password:{
        required: true,
        type: String,
        validate: {
            validator: (value) =>{
                return value.length > 6;
            },
            message: "weak password"
        },
    },
    address: {
        type: String,
        default: ""
    },
    type: {
        type: String,
        default: "user"
    },
    cart:
    [   {
        product: productSchema,
        quantity: {
            type: Number,
            required: true
        }
        }
    ]


});

const User = new mongoos.model("User", userScema);

module.exports = User;

