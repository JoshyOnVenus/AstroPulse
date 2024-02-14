runoncepath("0:/mainFunctions.ks").

set startTime to time:seconds.
lock g to (constant():g * body:mass) / (body:radius + ship:altitude)^2. //Calculates the gravity of the current celestial body
lock idealPitch to max(0,(90-90*(apoapsis/body:atm:height))). //Calculates the ideal pitch based on the altitude and atmosphere height
set targetAlt to 80000. //Set this to the targeted orbit altitude
set navHeading to 90.

//wait 10.	

set ship:control:pilotmainthrottle to 0.
lock throttle to 0.

ENGINE_CONTROL("FIRST STAGE", "Start").

when altitude >= 70000 and ship:dynamicpressure <= 2 and fairings_attached then {
	PF_DEPLOY().
}

set runmode to 1. //Starts the 1st stage of the script
until runmode = 0 {
	// if maxthrust = 0 {
	// 	if(ship:liquidfuel > 0 or ship:solidfuel > 0) {
	// 		HUDTEXT("Staging!", 4, 2, 32, YELLOW, false).
	// 		lock throttle to 0.
	// 		stage.
	// 		wait 1.
	// 		lock throttle to 1.
	// 	} else {
	// 		HUDTEXT("No Fuel Detected!", 4, 2, 32, RED, false).
	// 	}
	// }
	if runmode = 1 {
		sas off.
		lock throttle to 1. //-(apoapsis/targetAlt). //Locks throttle to 100%
		lock steering to heading(navHeading,90,0). //Locks steering to straight up, east
		print "Begining Pitch Manoeuvre".
		set runmode to 2. //Begins 2nd stage of the script
	}
	else if runmode = 2 {
		lock steering to heading(navHeading, idealPitch,0). //Locks steering to idealPitch pointing east
		if apoapsis >= targetAlt { //Check if apoapsis is greater than or equal to target altitude (with a margin of error of 100m)
			lock throttle to 0. 
			set runmode to 3. //Begins 3rd stage of the script
		} 
	}
	else if runmode = 3 {
		lock targetVel TO SQRT(CONSTANT:G * KERBIN:MASS / (targetAlt + body:radius)).
		lock shipMaxAcc TO SHIP:AVAILABLETHRUST / SHIP:MASS. // F = ma rearranged to find acceleration. a = F / m
		lock burnTime TO (targetVel - Ship:VELOCITY:ORBIT:MAG) / shipMaxAcc.
		lock timeToBurn TO (TIME:SECONDS + ETA:APOAPSIS - (burnTime / 2) - TIME:SECONDS).
		lock steering to prograde.
		if timeToBurn <= 0 {
			set runmode to 4. //Begins 4th stage of the script
		} else if timeToBurn <= 10 {
			//set warp to 0.
		} else {
			//set warp to 0.
		}
	}
	else if runmode = 4 {
		lock throttle to mass*(1000*orbit:eccentricity)/ship:availablethrust. //-(periapsis/targetAlt).
		if bestEccentricity() = true {
			//Locks throttle to 0 and unlocks throttle control
			lock throttle to 0.
			set ship:control:pilotmainthrottle to 0.	
			set runmode to 0. //Ends the script
		}
	}
	//Display neccesary data for in-flight analysing
	// print "Ideal Pitch: " + idealPitch AT(0,5).
	// print "Pitch: " + (90 - vectorangle(UP:FOREVECTOR, FACING:FOREVECTOR)) AT(0,6).
	// print "Pitch Error (best at 0): " + ((90 - vectorangle(UP:FOREVECTOR, FACING:FOREVECTOR)) - idealPitch) AT(0,7).
	// print "Apoapsis: " + apoapsis AT(0,8).
	// print "Periapsis: " + periapsis AT(0,9).
	// print "Inclination: " + orbit:inclination AT(0,10).
	// print "Runmode: " + runmode AT(0,1).
	// print "Altitude: " + altitude AT(0,11).
}
print "In Orbit! (Hopefully)".
set runmode to -1.

//returns true when best eccentricity is achieved
function bestEccentricity
{
	set ecc1 to orbit:eccentricity.
	wait 0.
	set ecc2 to orbit:eccentricity.
	if ecc1<ecc2 or round(apoapsis,1)=round(periapsis,1){return true.}
	else{return false.}
}