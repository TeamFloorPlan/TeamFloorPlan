'use strict';

function toRichmondLT(el) {
  var c = el.getContext("2d");
  c.lineWidth = 5;
  c.strokeStyle = "red";
  c.lineCap = "round";
  var img = new Image();
  img.src = 'LT1testMap.png';
  img.onload = function() {
    c.drawImage(img, 0, 0)
    c.beginPath();
    c.moveTo(35,260);
    c.lineTo(180,230);
    c.stroke();

    c.beginPath();
    c.moveTo(180,230);
    c.lineTo(210,230);
    c.stroke();

    c.beginPath();
    c.moveTo(210,230);
    c.lineTo(210,295);
    c.stroke();

    c.beginPath();
    c.moveTo(210,295);
    c.lineTo(240,295);
    c.stroke();


  }
}
