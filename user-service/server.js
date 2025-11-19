const express = require("express");
const mongoose = require("mongoose");
const bcrypt = require("bcrypt");
const cors = require("cors");
const User = require("./models/User");
const app = express();
app.use(express.json());
app.use(cors());
const MONGO_URL = process.env.MONGO_URL || "mongodb://localhost:27017/micro-users";
mongoose.connect(MONGO_URL, { useNewUrlParser: true, useUnifiedTopology: true })
 .then(()=> console.log("Connected to Mongo:", MONGO_URL))
 .catch(err => console.error("Mongo error", err));
app.post("/signup", async (req, res) => {
 try {
 const { name, email, password } = req.body;
 if(!name || !email || !password){
 return res.status(400).json({ message: "Missing fields" });
 }
 const exists = await User.findOne({ email });
 if(exists) return res.status(409).json({ message: "Email already registered" });
 const hashedPassword = await bcrypt.hash(password, 10);
 const user = await User.create({ name, email, password: hashedPassword });
 res.json({ message: "User Registered Successfully", user: { id: user._id, name, email } }) } catch (err) {
 res.status(400).json({ message: "Error: " + err });
 }
});
app.get("/get-user/:email", async (req, res) => {
 const user = await User.findOne({ email: req.params.email });
 res.json(user);
});
const PORT = process.env.PORT || 4000;
app.listen(PORT, () => console.log(`User Service on ${PORT}`));
