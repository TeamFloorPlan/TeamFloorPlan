'use strict';

function displayMap(el) {
  var c = el.getContext("2d");
  c.clearRect(0, 0, 500, 350);
  c.lineWidth = 5;
  c.strokeStyle = "red";
  c.lineCap = "round";
  var img = new Image();
  img.src = getBuilding();
  img.onload = function() {
    c.drawImage(img, 0, 0, 500, 350)
  }
}

function getBuilding() {

  switch (document.getElementById('buildingVal').value) {
    case "liongate":
      switch (document.getElementById('floor').value) {
        case "0":
          var build="img/Liongate/liongateLevel0.svg"
          break;
        case "1":
          var build="img/Liongate/liongateLevel1.svg"
          break;
        case "2";
          var build="img/Liongate/liongateLevel2.svg"
          break;
      }
      break;
    case "portland":
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
  return build;
}
