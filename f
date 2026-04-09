<!DOCTYPE html>
<html>
<head>
<title>Payment Form</title>

<style>
body{
  font-family: Arial;
  text-align:center;
  background:#f2f2f2;
}

form{
  background:white;
  padding:20px;
  width:300px;
  margin:auto;
  border-radius:10px;
}

input, select{
  width:90%;
  padding:8px;
  margin:8px;
}

button{
  padding:10px 20px;
  background:green;
  color:white;
  border:none;
}
</style>
</head>

<body>

<h2>Payment Form</h2>

<form onsubmit="return validateForm()">

<input type="text" id="name" placeholder="Name">

<input type="text" id="card" placeholder="Card Number" maxlength="16">

<input type="text" id="cvv" placeholder="CVV" maxlength="3">

<select id="month"></select>
<select id="year"></select>

<br>
<button type="submit">Submit</button>

</form>

<script>

// ---------- Create Month Dropdown ----------
let month = document.getElementById("month");
for(let i=1;i<=12;i++){
  let option = document.createElement("option");
  option.value = i;
  option.text = i;
  month.add(option);
}

// ---------- Create Year Dropdown ----------
let year = document.getElementById("year");
let currentYear = new Date().getFullYear();

for(let i=currentYear;i<=currentYear+10;i++){
  let option = document.createElement("option");
  option.value = i;
  option.text = i;
  year.add(option);
}

// ---------- Auto Focus ----------
document.getElementById("card").addEventListener("input", function(){
  if(this.value.length == 16){
    document.getElementById("cvv").focus();
  }
});

// ---------- Validation ----------
function validateForm(){

let name = document.getElementById("name").value;
let card = document.getElementById("card").value;
let cvv = document.getElementById("cvv").value;
let m = month.value;
let y = year.value;

// Name validation
let nameRegex = /^[A-Za-z ]+$/;
if(!nameRegex.test(name)){
  alert("Name should contain only letters");
  return false;
}

// Card validation (start with 4 or 5 and 16 digits)
let cardRegex = /^[45][0-9]{15}$/;
if(!cardRegex.test(card)){
  alert("Invalid Card Number");
  return false;
}

// CVV validation (3 digits)
let cvvRegex = /^[0-9]{3}$/;
if(!cvvRegex.test(cvv)){
  alert("Invalid CVV");
  return false;
}

// Expiry validation
let today = new Date();
let expiry = new Date(y, m);

if(expiry <= today){
  alert("Card Expired");
  return false;
}

alert("Payment Successful!");
return true;
}

</script>

</body>
</html>
