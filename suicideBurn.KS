lock trueRadar to alt:radar - 2.
lock g to (constant():g * body:mass) / (body:radius + trueRadar)^2.
lock maxDeceleration to (ship:availableThrust / ship:mass) - g.
lock stoppingDistance to ship:verticalspeed^2 / (2 * maxDeceleration).
lock pct to stoppingDistance / trueRadar.
lock impactTime to trueRadar / abs(ship:verticalspeed).

clearscreen.

initLogger().

lock throttle to 1.
wait until apoapsis >= 10000.
lock throttle to 0.
wait until ship:verticalspeed <= 0.
set runmode to 1.

when impactTime <= 3.5 then {
	gear on.
}

until runmode = 0 {
	if runmode = 1 {
		sas off.
		stage.
		rcs on.
		brakes on.
		lock steering to lookdirup(-ship:velocity:surface, ship:up:vector).
		if trueRadar <= stoppingDistance {
			set runmode to 2.
		}
	}
	else if runmode = 2 {
		lock throttle to pct.
		if ship:verticalspeed >= -0.1 {
			set runmode to 0.
		}
	}
	logData().
}
print "Ship Has Landed!".
rcs off.
lock throttle to 0.
sas on.


function initLogger {
	log "." to "0:/logs/log.csv".
	deletepath("0:/logs/log.csv").
	set header to "UT,ALTITUDE,APOAPSIS,PERIAPSIS,INCLINATION,S VELOCITY,O VELOCITY,THRUST,MASS, ,PITCH,GRAVITY,STAGE,RUNMODE".
	log header to "0:/logs/log.csv".
}

function logData {
	set data to time:seconds + "," +
				ship:altitude + "," +
				ship:orbit:apoapsis + "," +
				max(0,ship:orbit:periapsis) + "," +
				ship:orbit:inclination + "," +
				ship:velocity:surface:mag + "," +
				ship:velocity:orbit:mag + "," +
				ship:availablethrust + "," +
				ship:mass + "," +
				" " + "," +
				(90 - vectorangle(UP:FOREVECTOR, FACING:FOREVECTOR)) + "," +
				g + "," +
				stage:number + "," +
				runmode.
				
	log data to "0:/logs/log.csv".
}