<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Settings</title>
    <link rel="icon" href="img/UOPLogos/UOPLogoSmall.PNG">
    <link rel="stylesheet" href="style/stylesheet.css">
    <script src="mapScript.js"></script>
  </head>
  <header id="headBG">
    <a href="index.php"><img id="logo" src="img/UOPLogos/roomFinderUOPLogo.PNG"
     alt="Logo"></a>
    <h1>Settings</h1>
      <nav id="navArea">
        <a id="current_page">Settings</a> |
        <a href="index.php" aria-label="Navigate to the home page">Home</a> |
        <a href="buildingSelect.php" aria-label="Navigate to the building select page">Building Select</a> |
        <a id="logout" href="logout.php" aria-label="Logout from your account">Logout</a>
      </nav>
  </header>
  <body id="bodyBG" onload="storageRetrieval()">

    <section id="pageBG">
      <form id="settingsMenu">
        <input type="checkbox" id="cb" onclick="changeCB()" name="colourblind" value="colourblind">    Enable Colourblind Mode<br>
        <input type="checkbox" id="lt" onclick="changeLT()" name="largeText" value="largeText">    Enable Large Font<br>
      </form>
      <br><br><br><br><br><br><br><br><br><br><br><br>
    </section>

  </body>
</html>
