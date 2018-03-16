<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Login</title>
    <link rel="icon" href="img/UOPLogos/UOPLogoSmall.PNG">
    <link rel="stylesheet" href="style/stylesheet.css">
    <script src="mapScript.js"></script>
    <script src="testing.js"></script>
  </head>
  <header id="headBG">
    <a href="index.php"><img id="logo" src="img/UOPLogos/roomFinderUOPLogo.PNG"
     alt="Logo"></a>
    <h1>Login</h1>
      <nav id="navArea">
        <a id="current_page">Login</a> |
        <a href="index.php" aria-label="Navigate to the start page">Home</a> |
      </nav>
  </header>
  <body id="bodyBG" onload="storageRetrieval()">
    <section id="pageBG">
    <form action="/TeamFloorPlan/Backend/BackendFunctional.php" method="post">
      <br>
      <fieldset id="fieldsetid">
        <legend id="legendid">Login</legend>
         <!-- <p class="FormTitle">Username:</p> -->
         <input type="text" name="username" placeholder="Username" class="EmailPass" id="username" onchange="validateUsername();" />

         <!-- <p class="FormTitle">Password:</p> -->
         <input type="password" name="password" placeholder="Password"  class="EmailPass">
         <?php
          include("/Backend/BackendFunctional.php");
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

       <a href="createAccountForm.php" id="signUpLink">Don't have one? Sign up now</a>
       </section>
       </body>
     </html>
