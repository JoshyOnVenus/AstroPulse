runoncepath("0:/partlist.ks").
runoncepath("0:/groundFunctions.ks").
runoncepath("0:/mainFunctions.ks").
lock landTime to alt:radar / abs(ship:verticalspeed).
//clearscreen.
print "Attempting To Recover...".

lock steering to prograde.

wait 2.

gear on.

rcs on.

lock steering to lookdirup(-ship:velocity:surface, facing:topvector).

wait until verticalSpeed <= 20.

wait until verticalSpeed <= 0.

for p in S1_CHUTE {
    p:getmodule("ModuleParachute"):doaction("deploy chute", true).
}

until status = "SPLASHED" or status = "LANDED" {
    print landTime at(0,3).
    print altitude at(0,4).
	if landTime <= 1 {
		ENGINE_CONTROL("FIRST STAGE", "Start").
		lock throttle to 1.
	} else {
		lock throttle to 0.
	}
}
lock throttle to 0.
rcs off.
unlock steering.