<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Building Select</title>
    <!-- Links the HTML page to a javascript file, a css file and an icon -->
    <link rel="icon" href="img/UOPLogos/UOPLogoSmall.PNG">
    <link rel="stylesheet" href="style/stylesheet.css">
    <script src="mapScript.js"></script>
    <script src="testing.js"></script>
  </head>
  <!-- heading links back to homepage and links in nav bar directs user to the correct pages -->
  <header id="headBG">
    <a href="index.php"><img id="logo" src="img/UOPLogos/roomFinderUOPLogo.PNG"
     alt="Logo"></a>
    <h1>Building Select</h1>
      <nav id="navArea">
        <a id="current_page">Building Select</a> |
        <a href="index.php" aria-label="Navigate to the home page">Home</a> |
        <a href="settings.php" aria-label="Navigate to the settings page">Settings</a> |
        <a id="logout" href="logout.php" aria-label="Logout from your account">Logout</a>
      </nav>
      <?php
      include 'Backend/BackendFunctional.php';
      if(!isset($_SESSION['user']))     //If the user hasn't logged in, it redirects them to the login page
      {
          header("location: login.php");
      }
      ?>
  

        </header>
  <body id="bodyBG" onload="storageRetrieval()">

    <section id="pageBG">
      <!--Form contains options for selecting building*/-->
      <div id="UserEnterForm">
      <form>
        <!--User enters building name -->
        <select id="buildingVal">
          <option   value="buckingham">Buckingham</option>
          <option   value="liongate">Liongate</option>

        </select>
           <!-- type="text" name="buildingVal" id="buildingVal" value="liongate"/> -->
        <!-- User enters floor number -->
        <input type="number" name="floor" id="floor" value="0" min="0" max="3" onchange="validateFloor()" />
        <!-- User enters room id -->
        <input type="text" name="roomVal" id="room" placeholder="Room Number E.g. 0.14" onchange="validateRoom()">

        <input type="text" name="entranceVal" id="entrance" placeholder="Entrance Number E.g. 1" onchange="validateEntrance()"/>
        <div class="disabled">
        <input type="checkbox" name="disabled" id="disabled" />
        <p>Display Disabled Pathing</p>
      </div>

        <!-- Click button to run displayMap function -->
        <input id="mapBtn" type="button" value="Show Map" onclick="displayMap(window.mapCanvas);" />
        <input id="arrBtn" type="button" value="Show Route" onclick="plotArray(mapCanvas)" />
        
      </form>
      <div>
      <!-- Div where the map will be drawn -->
      <div id="mapDiv">
        <canvas id="mapCanvas" width="700" height="563"></canvas>

      <div>
    </section>

  </body>
</html>
