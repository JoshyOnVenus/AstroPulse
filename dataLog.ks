set startTime to time:seconds.
lock g to (constant():g * body:mass) / (body:radius + ship:altitude)^2. //Calculates the gravity of the current celestial body
lock idealPitch to max(0,(90-90*(apoapsis/body:atm:height))). //Calculates the ideal pitch based on the altitude and atmosphere height

initLogger().

until false {
    logData().
    wait 0.075.
}

function initLogger {
	log "." to "0:/logs/log.csv".
	log "." to "0:/logs/alt.txt".
	log "." to "0:/logs/speed.txt".
	deletepath("0:/logs/log.csv").
	deletepath("0:/logs/alt.txt").
	deletepath("0:/logs/speed.txt").
	set header to "UT,TIME,ALTITUDE,APOAPSIS,PERIAPSIS,INCLINATION,S VELOCITY,O VELOCITY,THRUST,MASS,IDEAL PITCH,PITCH,GRAVITY,STAGE,RUNMODE".
	log header to "0:/logs/log.csv".
}

function logData {
	set data to time:seconds + "," +
				(time:seconds - startTime) + "," +
				ship:altitude + "," +
				ship:orbit:apoapsis + "," +
				max(0,ship:orbit:periapsis) + "," +
				ship:orbit:inclination + "," +
				ship:velocity:surface:mag + "," +
				ship:velocity:orbit:mag + "," +
				ship:availablethrust + "," +
				ship:mass + "," +
				idealPitch + "," +
				(90 - vectorangle(UP:FOREVECTOR, FACING:FOREVECTOR)) + "," +
				g + "," +
				stage:number.
				
	log data to "0:/logs/log.csv".
	log floor(ship:altitude / 1000, 1) to "0:/logs/alt.txt".
	log floor(ship:airspeed * 3.6) to "0:/logs/speed.txt".
}