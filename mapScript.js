'use strict';

/*a function to draw the map to the screen using the canvas module*/
function displayMap(el) {
  var c = el.getContext("2d");
  c.clearRect(0, 0, 700, 563);
  c.lineWidth = 5;
  c.strokeStyle = "red";
  c.lineCap = "round";
  var img = new Image();
  img.src = getBuilding();
  img.onload = function() {
    /*Draws image onto canvas size 500px by 350px*/
    c.drawImage(img, 0, 0, 700, 563)
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
        case "3":
          var build="img/Liongate/liongateError.svg"
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
          var build="img/Portland/portlandLevel1.svg"
          break;
        case "2":
          var build="img/Portland/portlandLevel2.svg"
          break;
        case "3":
          var build="img/Portland/portlandLevel3.svg"
          break;
        }
      break;
    case "buckingham":
      switch (document.getElementById('floor').value) {
        case "0":
          var build="img/BuckingHam/BuckingHamLevel0.svg"
          break;
        case "1":
          var build="img/BuckingHam/BuckingHamLevel1.svg"
          break;
        case "2":
          var build="img/BuckingHam/BuckingHamLevel2.svg"
          break;
        case "3":
          var build="img/BuckingHam/BuckingHamLevel3.svg"
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

// function uses building values and id that user has selected to display the map which is linked to the backend
function plotArray(el) {

  let buildingNameFromBox = document.getElementById('buildingVal').value;
  let roomNumberFromBox = document.getElementById('room').value;
  let entranceNumber = document.getElementById('entrance').value;
  let disabled = document.getElementById('disabled').checked;
  let buildRequest = "?roomID=" + roomNumberFromBox + "&buildingName="+buildingNameFromBox;
  let roomIDFromDatabase = httpGet("http://127.0.0.1/TeamFloorPlan/Backend/BackendFunctional.php",buildRequest);
  let [roomIDSplit,floorNumber] = roomIDFromDatabase.split(',');
  if(entranceNumber == 1 && buildingNameFromBox == "buckingham"){ //Done this horrible hack for compatibility issues.
    entranceNumber = 3;
  }
  if(entranceNumber == 2 && buildingNameFromBox == "buckingham"){
    entranceNumber = 4;
  }
  buildRequest = "?pathEntranceID="+entranceNumber+"&roomIDSelect=" + roomIDSplit + "&floor=" + floorNumber + "&disabled=" + disabled;
  let arrayOfData = httpGet("http://127.0.0.1/TeamFloorPlan/Backend/BackendFunctional.php",buildRequest);
  let roomCoords = arrayOfData.split(',').map(Number);

  for (var i=1; i < (roomCoords.length/2)+1; i+=1) {
    var c = el.getContext("2d");
    c.beginPath();
    c.moveTo(arrayToFirstCoords(roomCoords,i)[0],arrayToFirstCoords(roomCoords,i)[1]);
    c.lineTo(arrayToSecondCoords(roomCoords,i)[0],arrayToSecondCoords(roomCoords,i)[1]);
    c.stroke();
  }
}

function legacyDraw(el,roomCoords){
  for (var i=1; i < (roomCoords.length/2)+1; i+=1) {
    var c = el.getContext("2d");
    c.beginPath();
    c.moveTo(arrayToFirstCoords(roomCoords,i)[0],arrayToFirstCoords(roomCoords,i)[1]);
    c.lineTo(arrayToSecondCoords(roomCoords,i)[0],arrayToSecondCoords(roomCoords,i)[1]);
    c.stroke();
  }
}


function getFloorNum(roomNumber){
  return roomNumber.charAt(0);
}

function changeLT () {
  var navFont = document.getElementById("navArea");
  if(document.getElementById("lt").checked) {
    navFont.style.fontSize = "1.8em";
    localStorage.setItem('lt', true);
  } else {
    navFont.style.fontSize = "1em";
    localStorage.setItem('lt', false);
  }
}

function changeCB () {
  var pageBG = document.getElementById("pageBG");
  var navBG = document.getElementById("navArea");
  var bodyBG = document.getElementById("bodyBG");
  var headBG = document.getElementById("headBG");
  if(document.getElementById("cb").checked) {
    pageBG.style.backgroundColor = "#000000";
    navBG.style.backgroundColor = "#000000";
    bodyBG.style.background = "#000000";
    headBG.style.background = "#FFF";
    pageBG.style.color = "#FFFFFF";
    localStorage.setItem('cb', true);
  } else {
    pageBG.style.backgroundColor = "#FFFFFF";
    navBG.style.backgroundColor = "#1E73AC";
    bodyBG.style.background = "linear-gradient(to right, #009fe3 0%,#009fe3 50%, 50%, #621361 50%, #621361 100%)";
    pageBG.style.color = "#000000";
    headBG.style.background = "#e9e9e9";
    localStorage.setItem('cb', false);
  }
}

function storageRetrieval() {
  var navFont = document.getElementById("navArea");
  var pageBG = document.getElementById("pageBG");
  var navBG = document.getElementById("navArea");
  var bodyBG = document.getElementById("bodyBG");
  var headBG = document.getElementById("headBG");
  var ltChecked = localStorage.getItem('lt');
  if(ltChecked == "true") {
    if (document.URL.indexOf("settings.php") >= 0) {
      document.getElementById("lt").checked = true;
    }
    navFont.style.fontSize = "1.8em";
  } else {
    if (document.URL.indexOf("settings.php") >= 0) {
      document.getElementById("lt").checked = false;
    }
    navFont.style.fontSize = "1em";
  }

  var cbChecked = localStorage.getItem('cb');
  if(cbChecked == "true") {
    if (document.URL.indexOf("settings.php") >= 0) {
      document.getElementById("cb").checked = true;
    }
    pageBG.style.backgroundColor = "#000000";
    pageBG.style.color = "#FFFFFF";
    navBG.style.backgroundColor = "#000000";
    bodyBG.style.background = "#000000";
    headBG.style.background = "#FFF";
  } else {
    if (document.URL.indexOf("settings.php") >= 0) {
      document.getElementById("cb").checked = false;
    }
    pageBG.style.backgroundColor = "#FFFFFF";
    pageBG.style.color = "#000000";
    navBG.style.backgroundColor = "#1E73AC";
    bodyBG.style.background = "linear-gradient(to right, #009fe3 0%,#009fe3 50%, 50%, #621361 50%, #621361 100%)";
    headBG.style.background = "#e9e9e9";
  }
}

// Checks if room entered is valid in comparision with the building entered
function validateRoom() {
  var roomStr = document.getElementById('room').value;
  var buildRequest = "?checkRoom=1&roomName="+roomStr;
  var requestBack = httpGet("http://127.0.0.1/TeamFloorPlan/Backend/BackendFunctional.php",buildRequest);
  if(requestBack == "FAILURE"){
    window.alert("Error: Please Enter an Room Number");
    document.getElementById('room').value = "0.01";
    return "FAILURE";
  }

}

function validateFloor() {
  var floorStr = document.getElementById('floor').value;
  var buildingID = document.getElementById('buildingVal').value;
  var buildRequest = "?checkFloor=1&buildingName="+buildingID+"&floorNumber="+floorStr;
  var requestBack = httpGet("http://127.0.0.1/TeamFloorPlan/Backend/BackendFunctional.php",buildRequest);
  if(requestBack == "FAILURE" || floorStr == "" || floorStr % 1 != 0 || floorStr < 0) {
    window.alert("Error: Please Enter a Valid Floor");
    document.getElementById('floor').value = 1;
    return "FAILURE";
  }
}

function validateEntrance() {
  var entStr = document.getElementById('entrance').value;
  var buildRequest = "?checkEntrance=1&entranceNumber="+entStr;
  var requestBack = httpGet("http://127.0.0.1/TeamFloorPlan/Backend/BackendFunctional.php",buildRequest);
  if(requestBack == "FAILURE" || entStr == "" || entStr % 1 != 0 || entStr < 0) {
    window.alert("Error: Please Enter a Valid Entrance");
    document.getElementById('entrance').value = 1;
    return "FAILURE";
  }
}

  function checkCleanString(arg){
      var expressionToSearch = new RegExp("[^a-z|^A-Z]");
      if(expressionToSearch.test(arg)){
        window.alert("Error: Please Enter a Valid Username");
        return true;
      }
      return false;
  }


  function validateUsername(){
    var user = document.getElementById('username').value;
    if(checkCleanString(user)){
       document.getElementById('username').value = "";
    }
    if(user.length < 4){
      window.alert("Error: Username needs to be at least 4 characters.");
      document.getElementById('username').value = "";
    }
   }

   function validateFname(){
    var fname = document.getElementById('firstname').value;
    if(checkCleanString(fname)){
      document.getElementById('firstname').value = "";
    }
   }

   function validateSname(){
    var sname = document.getElementById('surname').value;
    if(checkCleanString(sname)){
      document.getElementById('surname').value = "";
    }
   }

   function validateEmail(){
     var email = document.getElementById('email').value;
     if(email.search("@") == -1){
       window.alert("Error: Please enter valid email address.")
       document.getElementById('email').value = "";
     }
   }
