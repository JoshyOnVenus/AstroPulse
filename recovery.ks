runoncepath("0:/partlist.ks").
runoncepath("0:/groundFunctions.ks").
lock landTime to alt:radar / abs(ship:verticalspeed).
//clearscreen.
print "Attempting To Recover...".

wait until verticalSpeed <= 10.

rcs on.
lock steering to lookdirup(ship:velocity:surface, facing:topvector).

wait until verticalSpeed <= 0.

for p in S1_CHUTE {
    p:getmodule("ModuleParachute"):doaction("deploy chute", true).
}

until status = "SPLASHED" or status = "LANDED" {
    print landTime at(0,3).
    print altitude at(0,4).
    S2_CPU_COMMAND:sendmessage(altitude).
}