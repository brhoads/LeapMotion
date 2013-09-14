var propellerId;
function onOpen(openInfo){
	connectionId = openInfo.connectionId;
	propellerId = connectionId;
	console.log('connectionId: '+connectionId);
	if(connectionId == -1){
		console.log('Could not open serial port');
		document.getElementById('errors').innerHTML = "Unable to connect to serial port";
		return;
	}
	leapLoop(connectionId);
}
	
function leapLoop(connectionId){

	var buffer = new ArrayBuffer(1);
	uint8b = new Uint8Array(buffer);


	var controller = new Leap.Controller({
		host: "127.0.0.1",
		port: 6437,
		enableGestures: false,
		frameEventName: "animationFrame"
	});
	
	var fingers = 0;
	var pwm = 0;
	
	controller.loop(function(frame){
		fingers = frame.fingers.length;
		
		if(fingers != 0){
			//Update brightness
			pwm = 31-Math.max(Math.floor((31*frame.fingers[0].tipPosition[1])/400)-5,0);
			console.log(pwm);
		}		
		
		//console.log(fingers);
		//Turn number of pins on
		for(var pin=0;pin<fingers;pin++){
			uint8b[0] = pwm | (pin << 5);
			chrome.serial.write(connectionId,buffer,function(){});
		}			
		//Turn the rest off
		for(var pin=fingers;pin<0x8;pin++){
			uint8b[0] = 31 | (pin << 5);
			chrome.serial.write(connectionId,buffer,function(){});
		}
		
	});
	
	controller.connect();
}

tempserial = chrome.serial.open("COM68",{"bitrate":115200}, onOpen);
