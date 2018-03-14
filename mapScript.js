'use strict';

/*a function to draw the map to the screen using the canvas module*/
function displayMap(el) {
  var c = el.getContext("2d");
  c.clearRect(0, 0, 800, 500);
  c.lineWidth = 5;
  c.strokeStyle = "red";
  c.lineCap = "round";
  var img = new Image();
  img.src = getBuilding();
  img.onload = function() {
    /*Draws image onto canvas size 500px by 350px*/
    c.drawImage(img, 0, 0, 800, 500)
  }
}

/*Function to determine which building and which floor to display*/
function getBuilding() {
  /*Gets input of building name from text entry box*/
  switch ((document.getElementById('buildingVal').value).toLowerCase()) {
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

var testArray = [542,522,542,492];

function arrayToFirstCoords(roomCoords, coordPoint) {
  var coord = [(roomCoords[coordPoint*2-2]),(roomCoords[coordPoint*2-1])]
  return coord;
}

function arrayToSecondCoords(roomCoords, coordPoint) {
  var coord = [(roomCoords[coordPoint*2]),(roomCoords[coordPoint*2+1])]
  return coord;
}

function httpGet(urlToGet,getParams)
{
    urlToGet = urlToGet + getParams;
    let httpGetRequest = new XMLHttpRequest();
    httpGetRequest.open( "GET", urlToGet, false ); // false for synchronous request
    httpGetRequest.send( null );
    let responseToGet = httpGetRequest.responseText;
    let responseStatus = httpGetRequest.status;
    if(responseToGet != null && responseStatus == 200)
    {
      return responseToGet;
    }
    else
    {
      return "Error cannot fetch data";
    }

}


function plotArray(el, roomCoords) {
  for (var i=1; i < (roomCoords.length/2)+1; i+=1) {
    var c = el.getContext("2d");
    c.beginPath();
    c.moveTo(arrayToFirstCoords(roomCoords,i)[0],arrayToFirstCoords(roomCoords,i)[1]);
    c.lineTo(arrayToSecondCoords(roomCoords,i)[0],arrayToSecondCoords(roomCoords,i)[1]);
    c.stroke();
  }
}
