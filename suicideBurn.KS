lock trueRadar to alt:radar.
lock totalSpeed to sqrt((ship:verticalspeed^2)+(ship:groundspeed^2)).
lock g to (constant():g * body:mass) / (body:radius + trueRadar)^2.
lock maxDeceleration to (ship:availableThrust / ship:mass) - g.
lock stoppingDistance to totalSpeed^2 / (2 * maxDeceleration).
lock pct to stoppingDistance / trueRadar.
lock impactTime to trueRadar / abs(totalSpeed).

clearscreen.

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
		if totalSpeed >= -0.1 {
			set runmode to 0.
		}
	}
	print pct at(0,1).
	print stoppingDistance at(0,2).
	print totalSpeed at(0,3).
	print maxDeceleration at (0,4).
	print impactTime at(0,5).
}
print "Ship Has Landed!".
rcs off.
lock throttle to 0.
sas on.