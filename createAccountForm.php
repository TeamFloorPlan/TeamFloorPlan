<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Create An Account</title>
    <link rel="icon" href="img/UOPLogos/UOPLogoSmall.PNG">
    <link rel="stylesheet" href="style/stylesheet.css">
    <script src="mapScript.js"></script>
    <script src="testing.js"></script>
  </head>
  <header>
    <a href="index.html"><img id="logo" src="img/UOPLogos/roomFinderUOPLogo.PNG"
     alt="Logo"></a>
    <h1>Homepage</h1>
      <nav>
        <a id="current_page">Sign up/Login</a> |
        <a href="index.php" aria-label="Navigate to the start page">Home</a> |
        <a id="logout" href="logout.php" aria-label="Logout from your account">Logout</a>
      </nav>
  </header>
  <body>
    <section>
    <form action="/TeamFloorPlan/Backend/BackendFunctional.php" method="post">
      <br>
       <fieldset id="fieldsetid">
         <legend id="legendid">Personal information:</legend>
         <p class="FormTitle">Name:</p>
         <input type="text" name="FirstName" placeholder="First Name"  id="firstname" class="Name" onchange="validateFname();" />


         <!-- <p class="FormTitle">Surname:</p> -->
         <input type="text" name="Surname" placeholder="Last Name"  id="surname" class="Name" onchange="validateSname();">
      </fieldset>

         <p class="FormTitle">Username:</p>
         <input type="text" name ="username" id="username" placeholder="Unique Username" class="EmailPass" onchange="validateUsername();" />

         <p class="FormTitle">Password:</p>
         <input type="password" name="password" placeholder="Password"  class="EmailPass">



         <p class="FormTitle">Confirm Password:</p>
         <input type="password" name="cpassword" placeholder="Re-enter Password" class="EmailPass">

         <p class="FormTitle">Email Address:</p>
         <input type="text" name="email" id="email" placeholder="Your Email" class="EmailPass" onchange="validateEmail();">
         <input type="hidden" name="Signup" value="1">
         <br>
         <?php
         if(isset($_GET['error']))
         {
            $error = $_GET['error'];


         if($error == "errorUsernameTaken")
         {
          echo "Username or email already in use.";
         }else if ($error == "invalidUsername") {
           echo "Invalid username";
         }else if($error == "passwordError"){
            echo "Passwords do not match";
         }
         }

         ?>
         <!-- <input type="submit" value="Sign Up" id="submitbut"> -->
         <button type="submit" class ="signupbtn"> Sign me up!</button>
         <br>
         <button type= "button" class ="cancelbtn">Cancel</button>
       </form>

       </section>
       </body>
     </html>
