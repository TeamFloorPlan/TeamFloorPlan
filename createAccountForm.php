<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Create An Account</title>
    <link rel="icon" href="img/UOPLogos/UOPLogoSmall.PNG">
    <link rel="stylesheet" href="style/stylesheet.css">
  </head>
  <header>
    <a href="index.html"><img id="logo" src="img/UOPLogos/roomFinderUOPLogo.PNG"
     alt="Logo"></a>
    <h1>Homepage</h1>
      <nav>
        <a id="current_page">Sign up/Login</a> |
        <a href="index.html" aria-label="Navigate to the start page">Home</a> |
      </nav>
  </header>
  <body>
    <section>
    <form action="/backend/backend.php">
      <br>
       <fieldset id="fieldsetid">
         <legend id="legendid">Personal information:</legend>
         <p class="FormTitle">Name:</p>
         <input type="text" name="FirstName" placeholder="First Name"   class="Name">


         <!-- <p class="FormTitle">Surname:</p> -->
         <input type="text" name="Surname" placeholder="Last Name"  class="Name">
      </fieldset>

         <p class="FormTitle">Username:</p>
         <input type="text" name ="Username" placeholder="Unique Username" class="EmailPass">

         <p class="FormTitle">Password:</p>
         <input type="password" name="password" placeholder="Password"  class="EmailPass">



         <p class="FormTitle">Confirm Password:</p>
         <input type="password" name="cpassword" placeholder="Re-enter Password" class="EmailPass">

         <p class="FormTitle">Email Address:</p>
         <input type="text" name="E-mail" placeholder="Your Email" class="EmailPass">

         <br>

         <!-- <input type="submit" value="Sign Up" id="submitbut"> -->
         <button type="submit" class ="signupbtn"> Sign me up!</button>
         <br>
         <button type= "button" class ="cancelbtn">Cancel</button>
       </form>

       </section>
       </body>
     </html>
