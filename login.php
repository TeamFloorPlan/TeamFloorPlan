<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Login</title>
    <link rel="icon" href="img/UOPLogos/UOPLogoSmall.PNG">
    <link rel="stylesheet" href="style/stylesheet.css">
  </head>
  <header>
    <a href="index.html"><img id="logo" src="img/UOPLogos/roomFinderUOPLogo.PNG"
     alt="Logo"></a>
    <h1>Login</h1>
      <nav>
        <a id="current_page">Login</a> |
        <a href="index.html" aria-label="Navigate to the start page">Home</a> |
      </nav>
  </header>
  <body>
    <section>
    <form action="/TeamFloorPlan/Backend/Backend.php" method="post">
      <br>
      <fieldset id="fieldsetid">
        <legend id="legendid">Login</legend>
         <!-- <p class="FormTitle">Username:</p> -->
         <input type="text" name="username" placeholder="Username"   class="EmailPass">

         <!-- <p class="FormTitle">Password:</p> -->
         <input type="password" name="password" placeholder="Password"  class="EmailPass">
         <?php
          include("/Backend/Backend.php");
          if(isset($_SESSION['user']))
          {
            header("location: buildingSelect.php");
          }

          if(isset($_GET['loginError']))
          {
            echo "Please enter a valid username and password";
          }
          
         ?>
         <input type="hidden" name="Login" value="1">
       </fieldset>
       <button type="submit" class ="signupbtn"> Sign in</button>
       </form>
       <br>
       
       <a href="createAccountForm.html" style="text-decoration:none;">Don't have one? Sign up now</a>
       </section>
       </body>
     </html>