//Initialization app

const express = require('express');
const app = express();

//connecting db
const mongoose = require('mongoose');
const Note = require('./models/Note');
const bodyParser = require('body-parser');
app.use(bodyParser.urlencoded({extended:false}));
//true -> Nested Objects Correct
//faslse -> Nested Objects Not Correct
app.use(bodyParser.json());
const mongoDbPath = "mongodb+srv://emon:Abc123456@cluster0.elue5wu.mongodb.net/notesdb";
mongoose.connect(mongoDbPath).then(function(){
        //Routes
//Home 
app.get("/",function(req,res){

    const response = {message:"Api Worked!"};

    res.json(response);
    });
    const noteRouter = require('./routes/Note');
app.use("/notes",noteRouter)


});



//Strating the server on a port 
const PORT = process.env.PORT || 9000;
app.listen(PORT,function(){
    console.log("Server Started at port: " + PORT);
});