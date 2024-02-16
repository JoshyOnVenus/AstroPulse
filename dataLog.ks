runoncepath("0:/mainFunctions.ks").

set startTime to time:seconds.
lock g to (constant():g * body:mass) / (body:radius + ship:altitude)^2. //Calculates the gravity of the current celestial body
lock idealPitch to max(0,(90-90*(apoapsis/body:atm:height))). //Calculates the ideal pitch based on the altitude and atmosphere height

initLogger().

until false {
    logData().
}

function initLogger {
	log "." to "0:/logs/log.csv".
	log "." to "0:/logs/s1_alt.txt".
	log "." to "0:/logs/s2_alt.txt".
	log "." to "0:/logs/s1_speed.txt".
	log "." to "0:/logs/s1_speed.txt".
	log "." to "0:/logs/s1_fuel.txt".
	log "." to "0:/logs/s2_fuel.txt".
	deletepath("0:/logs/log.csv").
	deletepath("0:/logs/s1_alt.txt").
	deletepath("0:/logs/s2_alt.txt").
	deletepath("0:/logs/s1_speed.txt").
	deletepath("0:/logs/s2_speed.txt").
	deletepath("0:/logs/s1_fuel.txt").
	deletepath("0:/logs/s2_fuel.txt").
	set header to "UT,TIME,ALTITUDE,APOAPSIS,PERIAPSIS,INCLINATION,S VELOCITY,O VELOCITY,THRUST,MASS,IDEAL PITCH,PITCH,GRAVITY,STAGE,S1 FUEL,S1 OX,S2 FUEL,S2 OX".
	log header to "0:/logs/log.csv".
}

function logData {
	GET_RESOURCE("FIRST STAGE").
	GET_RESOURCE("SECOND STAGE").
	GET_ALTITUDE("FIRST STAGE").
	GET_ALTITUDE("SECOND STAGE").
	GET_SPEED("FIRST STAGE").
	GET_SPEED("SECOND	 STAGE").
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
		stage:number + "," +
		round((S1_FUEL_AMOUNT/S1_FUEL_CAPACITY)*100, 1) + "%" +"," +
		round((S1_OX_AMOUNT/S1_OX_CAPACITY)*100, 1) + "%" +"," +
		round((S2_FUEL_AMOUNT/S2_FUEL_CAPACITY)*100, 1) + "%" +"," +
		round((S2_OX_AMOUNT/S2_OX_CAPACITY)*100, 1) + "%".
				
	log data to "0:/logs/log.csv".
	log floor(S1_ALTITUDE / 1000, 1)+"KM" to "0:/logs/s1_alt.txt".
	log floor(S2_ALTITUDE / 1000, 1)+"KM" to "0:/logs/s2_alt.txt".
	log floor(S1_SPEED * 3.6)+"KM/H" to "0:/logs/s1_speed.txt".
	log floor(S2_SPEED * 3.6)+"KM/H" to "0:/logs/s2_speed.txt".
	log round((S1_FUEL_AMOUNT/S1_FUEL_CAPACITY)*100, 1) + "%" to "0:/logs/s1_fuel.txt".
	log round((S2_FUEL_AMOUNT/S2_FUEL_CAPACITY)*100, 1) + "%" to "0:/logs/s2_fuel.txt".
}