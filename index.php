<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Home</title>
    <link rel="icon" href="img/UOPLogos/UOPLogoSmall.PNG">
    <link rel="stylesheet" href="style/stylesheet.css">
    <script src="mapScript.js"></script>
  </head>
  <header id="headBG">
    <a href="index.php"><img id="logo" src="img/UOPLogos/roomFinderUOPLogo.png"
     alt="Logo"></a>
    <h1>Home</h1>
      <nav id="navArea">
        <a id="current_page">Home</a> |
        <a href="login.php" aria-label="Navigate to the sign in page">Login</a> |
        <a href="buildingSelect.php" aria-label="Navigate to the building select page">Building Select</a> |
        <a href="settings.php" aria-label="Navigate to the settings page">Settings</a> |
      </nav>
  </header>
  <body id="bodyBG" onload="storageRetrieval()">

    <section id="pageBG">
      <div id="homeBanner">
        <p id="bannerMain">UoP Room Finder</p>
        <p id="bannerSub">INSE Project</p>
        <a href="login.php"><img id="loginBtnHome" src="img/homeLogin.png" width="180px"></a>
      </div>
      <div id="homeInfo">
        <h2>Why Sign Up?</h2>
        <p>The 'University Of Portsmouth Room Finder' is a web application designed to help you on your educational journey through life. By signing up you will gain access to a system designed by and for students to get you from A to B in your first days on campus.</p>
        <p>It's as simple as entering your building, floor and room number. Our world class mapping algorithm will guide you to your classroom, avoiding that first week panic.</p>.
        <img src="img/lostStudent.png" width="90%">
      </div>
      <div id="homeInfo2">
        <h2>Features and Updates</h2>
        <ul>
          <li>A modern login system with strong password encryption</li>
          <li>A complex mapping algorithm that will find you the quickest route</li>
          <li>A simplistic and intuitive design</li>
          <li>Created by a team of experts from all over portsea island</li>
          <li>Planned expansion to dozens of university buildings</li>
          <li>Planned expansion to university accommodation buildings</li>
          <li>Planned integration with Google Calendar</li>
        </ul>
      </div>
    </section>

  </body>
</html>
