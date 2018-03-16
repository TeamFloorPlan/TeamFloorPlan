'use strict'

function setFloorNumber(floorNumber){
	document.getElementById('floor').value = floorNumber;
}

function getFloorNumber(){
	return document.getElementById('floor').value;
}

function updateFloorNumber(){
	document.getElementById('floor').onchange();
}

function testFloor(data,wantChange){
	setFloorNumber(data);
	updateFloorNumber();
	let output = getFloorNumber();
	if(wantChange){
		if(data == output){
			return false;
		}else{
			return true;
		}
	}else{
		if(data == output){
			return true;
		}else{
			return false;
		}
	}
}


function setRoomName(roomName){
	document.getElementById('room').value = roomName;
}

function getRoomName(){
	return document.getElementById('room').value;
}

function updateRoomName(){
	document.getElementById('room').onchange();
}

function testRoomName(data,wantChange){
	setRoomName(data);
	updateRoomName();
	let output = getRoomName();
	if(wantChange){
		if(data == output){
			return false;
		}else{
			return true;
		}
	}else{
		if(data == output){
			return true;
		}else{
			return false;
		}
	}

}

function setEntranceNumber(entranceNumber){
	document.getElementById('entrance').value = entranceNumber;
}

function getEntranceNumber(){
	return document.getElementById('entrance').value;
}

function updateEntranceNumber(){
	document.getElementById('entrance').onchange();
}

function testEntranceNumber(data,wantChange){
	setEntranceNumber(data);
	updateEntranceNumber();
	let output = getEntranceNumber();
	if(wantChange){
		if(data == output){
			return false;
		}else{
			return true;
		}
	}else{
		if(data == output){
			return true;
		}else{
			return false;
		}
	}
}

function outputOutcome(number,result){
	if(result == 1){
		result = "Passed";
	}else{
		result = "Failed";
	}
	console.log("Test "+ number + ": " + result + ".");
}

function testing(){
	let i = 1;
	//Test 1
	if(testRoomName("AAA",true)){
		outputOutcome(i,1);
	}else{
		outputOutcome(i,0);
	}
	i+=1;
	//Test 2
	if(testRoomName(7,true)){
		outputOutcome(i,1);
	}else{
		outputOutcome(i,0);
	}
	i+=1;
	//Test 3
	if(testRoomName("0.07",false)){
		outputOutcome(i,1);
	}else{
		outputOutcome(i,0);
	}
	i+=1;
	//Test 4
	if(testFloor(10,true)){
		outputOutcome(i,1);
	}else{
		outputOutcome(i,0);
	}
	i+=1;
	//Test 5
	if(testFloor(-5,true)){
		outputOutcome(i,1);
	}else{
		outputOutcome(i,0);
	}
	i+=1;
	//Test 6
	if(testFloor("e",true)){
		outputOutcome(i,1);
	}else{
		outputOutcome(i,0);
	}
	i+=1;
	//Test 6
	if(testFloor(1.5,true)){
		outputOutcome(i,1);
	}else{
		outputOutcome(i,0);
	}
	i+=1;
	//Test 7
	if(testFloor(1,false)){
		outputOutcome(i,1);
	}else{
		outputOutcome(i,0);
	}
	i+=1;
	//Test 8
	if(testEntranceNumber("entranceTest",true)){
		outputOutcome(i,1);
	}else{
		outputOutcome(i,0);
	}
	i+=1;
	//Test 9
	if(testEntranceNumber(4,true)){
		outputOutcome(i,1);
	}else{
		outputOutcome(i,0);
	}
	i+=1;
	//Test 10
	if(testEntranceNumber(-1,true)){
		outputOutcome(i,1);
	}else{
		outputOutcome(i,0);
	}
	i+=1;
	//Test 11
	if(testEntranceNumber(0.5,true)){
		outputOutcome(i,1);
	}else{
		outputOutcome(i,0);
	}
	i+=1;
	//Test 12
	if(testEntranceNumber(1,false)){
		outputOutcome(i,1);
	}else{
		outputOutcome(i,0);
	}
	i+=1;

}


function setUsername(usernameInput){
	document.getElementById('username').value = usernameInput;
}

function getUsername(){
	return document.getElementById('username').value;
}

function updateName(){
	document.getElementById('username').onchange();
}

function testUsername(data,wantChange){
	setUsername(data);
	updateName();
	let output = getUsername();
	if(wantChange){
		if(data == output){
			return false;
		}else{
			return true;
		}
	}else{
		if(data == output){
			return true;
		}else{
			return false;
		}
	}
}




function testingLogins(){
	let i = 1;
	//Test 1
	if(testUsername("#",true)){
		outputOutcome(i,1);
	}else{
		outputOutcome(i,0);
	}
	i+=1;
	//Test 2
	if(testUsername("l l",true)){
		outputOutcome(i,1);
	}else{
		outputOutcome(i,0);
	}
	i+=1;
	//Test 3
	if(testUsername(" ", true)){
		outputOutcome(i,1);
	}else{
		outputOutcome(i,0);
	}
	i+=1;
	if(testUsername("bbb",true)){
		outputOutcome(i,1);
	}else{
		outputOutcome(i,0)
	}
	i+=1;
	if(testUsername(1,true)){
		outputOutcome(i,1);
	}else{
		outputOutcome(i,0);
	}

	i+=1;
	//Test 4
	if(testUsername("test",false)){
		outputOutcome(i,1)
	}else{
		outputOutcome(i,0);
	}

}


function setsurname(fnameInput){
	document.getElementById('surname').value = fnameInput;
}

function getsurname(){
	return document.getElementById('surname').value;
}

function updatesurname(){
	document.getElementById('surname').onchange();
}


function setFirstName(fnameInput){
	document.getElementById('firstname').value = fnameInput;
}

function getFirstName(){
	return document.getElementById('firstname').value;
}

function updateFirstName(){
	document.getElementById('firstname').onchange();
}

function setEmail(email){
	document.getElementById('email').value = email;
}

function getEmail(){
	return document.getElementById('email').value;
}

function updateEmail(){
	document.getElementById('email').onchange;
}

function testFirstName(data,wantChange){
	setFirstName(data);
	updateFirstName();
	let output = getFirstName();
	if(wantChange){
		if(data == output){
			return false;
		}else{
			return true;
		}
	}else{
		if(data == output){
			return true;
		}else{
			return false;
		}
	}
}

function testEmail(data,wantChange){
	setEmail(data);
	updateEmail();
	let output = getEmail();
	if(wantChange){
		if(data == output){
			return false;
		}else{
			return true;
		}
	}else{
		if(data == output){
			return true;
		}else{
			return false;
		}
	}
}


function testSurname(data,wantChange){
	setsurname(data);
	updatesurname();
	let output = getsurname();
	if(wantChange){
		if(data == output){
			return false;
		}else{
			return true;
		}
	}else{
		if(data == output){
			return true;
		}else{
			return false;
		}
	}
}

function testingCreateAccount(){
	let i = 1;
	//Test 1
	if(testUsername("#",true)){
		outputOutcome(i,1);
	}else{
		outputOutcome(i,0);
	}
	i+=1;
	//Test 2
	if(testUsername("l l",true)){
		outputOutcome(i,1);
	}else{
		outputOutcome(i,0);
	}
	i+=1;
	//Test 3
	if(testUsername(" ", true)){
		outputOutcome(i,1);
	}else{
		outputOutcome(i,0);
	}
	i+=1;
	//Test 4
	if(testUsername("test",false)){
		outputOutcome(i,1);
	}else{
		outputOutcome(i,0);
	}
	i+=1;
	//Test 5
	if(testFirstName("#",true)){
		outputOutcome(i,1);
	}else{
		outputOutcome(i,0);
	}
	i+=1;
	//Test 6
	if(testFirstName("l l",true)){
		outputOutcome(i,1);
	}else{
		outputOutcome(i,0);
	}
	i+=1;
	//Test 7
	if(testFirstName(" ", true)){
		outputOutcome(i,1);
	}else{
		outputOutcome(i,0);
	}
	i+=1;
	//Test 8
	if(testFirstName("test",false)){
		outputOutcome(i,1);
	}else{
		outputOutcome(i,0);
	}
	i+=1;
	//Test 9
	if(testSurname("#",true)){
		outputOutcome(i,1);
	}else{
		outputOutcome(i,0);
	}
	i+=1;
	//Test 10
	if(testSurname("l l",true)){
		outputOutcome(i,1);
	}else{
		outputOutcome(i,0);
	}
	i+=1;
	//Test 11
	if(testSurname(" ", true)){
		outputOutcome(i,1);
	}else{
		outputOutcome(i,0);
	}
	i+=1;
	//Test 12
	if(testSurname("test",false)){
		outputOutcome(i,1);
	}else{
		outputOutcome(i,0);
	}

	i+=1;
	if(testUsername("bbb",true)){
		outputOutcome(i,1);
	}else{
		outputOutcome(i,0)
	}
	i+=1;
	if(testUsername(1,true)){
		outputOutcome(i,1);
	}else{
		outputOutcome(i,0);
	}
	i+=1;
	if(testEmail("b",true)){
		outputOutcome(i,1);
	}else{
		outputOutcome(i,0);
	}
	i+=1;
	if(testEmail("hi@gmail.com",0)){
		outputOutcome(i,1);
	}else{
		outputOutcome(i,0);
	}

}
