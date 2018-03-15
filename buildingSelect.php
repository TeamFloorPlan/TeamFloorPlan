<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Building Select</title>
    <!-- Links the HTML page to a javascript file, a css file and an icon -->
    <link rel="icon" href="img/UOPLogos/UOPLogoSmall.PNG">
    <link rel="stylesheet" href="style/stylesheet.css">
    <script src="mapScript.js"></script>
  </head>
  <header>
    <a href="index.php"><img id="logo" src="img/UOPLogos/roomFinderUOPLogo.PNG"
     alt="Logo"></a>
    <h1>Building Select</h1>
      <nav id="navArea">
        <a id="current_page">Building Select</a> |
        <a href="index.php" aria-label="Navigate to the home page">Home</a> |
        <a href="settings.php" aria-label="Navigate to the settings page">Settings</a> |
      </nav>
  </header>
  <body onload="storageRetrieval()">

    <section>
      <!--Form contains options for selecting building*/-->
      <form>
        <!--User enters building name -->
        <input type="text" name="buildingVal" id="buildingVal" value="liongate"/>
        <!-- User enters floor number -->
        <input type="number" name="floor" id="floor" value="0" min="0" max="2" />
        <!-- User enters room id -->
        <input type="text" name="roomVal" id="room" value="0.00">

        
        <!-- Click button to run displayMap function -->
        <input id="mapBtn" type="button" value="Show Map" onclick="displayMap(window.mapCanvas);" />
        <input id="arrBtn" type="button" value="Plot Array" onclick="plotArray(mapCanvas)" />
      </form>
      <!-- Div where the map will be drawn -->
      <div id="mapDiv">
        <canvas id="mapCanvas" width="700" height="563"></canvas>

      <div>
    </section>

  </body>
</html>
