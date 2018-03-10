'use strict';

/*a function to draw the map to the screen using the canvas module*/
function displayMap(el) {
  var c = el.getContext("2d");
  c.clearRect(0, 0, 500, 350);
  c.lineWidth = 5;
  c.strokeStyle = "red";
  c.lineCap = "round";
  var img = new Image();
  img.src = getBuilding();
  img.onload = function() {
    /*Draws image onto canvas size 500px by 350px*/
    c.drawImage(img, 0, 0, 500, 350)
  }
}

/*Function to determine which building and which floor to display*/
function getBuilding() {
  /*Gets input of building name from text entry box*/
  var inputString = document.getElementById('buildingVal').value;
  var inputStringLower = inputString.toLowerCase();
  switch (inputStringLower) {
    case "liongate":
    /*Gets input of floor number from spinner*/
      switch (document.getElementById('floor').value) {
        case "0":
          var build="img/Liongate/liongateLevel0.svg"
          break;
          case "1":
          var build="img/Liongate/liongateLevel1.svg"
          break;
        case "2":
          var build="img/Liongate/liongateLevel2.svg"
          break;
      }
      break;
    /*Gets input of building name from text entry box*/
    case "portland":
      /*Gets input of floor number from spinner*/
      switch (document.getElementById('floor').value) {
        case "0":
          var build="img/Portland/portlandLevel0.svg"
          break;
        case "1":
          var build="img/Portland/portlandLevel0.svg"
          break;
        }
      break;
  }
  /*Returns the location of the appropriate image*/
  return build;
}
