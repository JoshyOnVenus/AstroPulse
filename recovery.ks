runoncepath("0:/partlist.ks").
runoncepath("0:/groundFunctions.ks").

//clearscreen.
print "Attempting To Recover...".

wait until verticalSpeed <= 0.

lock steering to srfretrograde.

for p in S1_CHUTE {
    p:getmodule("ModuleParachute"):doaction("deploy chute", true).
}

until status = "SPLASHED" or status = "LANDED" {
    S2_CPU_COMMAND:sendmessage(altitude).
    wait 1.
}