function cal()
{
  var result = 0;
  var fat_loss = 0;
  var ex_fat_loss = 0;
  var weight = document.getElementById("weight").value;
  var height = document.getElementById("height").value;
  var age = document.getElementById("age").value;
  var ex_level = document.getElementById("level").value;


  if ( weight <= 0 || isNaN(weight))
  {
    alert("Invalid Input");
    return;
  }

if ( height <= 0 || isNaN(height))
  {
    alert("Invalid Input");
    return;
  }

if ( age <= 0 || isNaN(age))
  {
    alert("Invalid Input");
    return;
  }

  result = 66 + (13.7 * weight) + (5 * height) - (6.8 * age);
  if (ex_level == 1)
  {
    result = result * 1.2;
  }
  if (ex_level == 2)
  {
    result = result * 1.375;
  }
  if (ex_level == 3)
  {
    result = result * 1.55;
  }
  if (ex_level == 4)
  {
    result = result * 1.725;
  }
  if (ex_level == 5)
  {
    result = result * 1.9;
  }

  document.getElementById("result").innerHTML = result;
  document.getElementById("fat_loss_result").innerHTML = result - 400;
  document.getElementById("ex_fat_loss_result").innerHTML = result - 800;


}
