runoncepath("0:/partlist.ks").
runoncepath("0:/groundFunctions.ks").
DEFINE_PARTS().

//clearscreen.
print "Attempting To Recover...".

lock steering to srfretrograde.

for p in S1_CHUTE {
    p:getmodule("ModuleParachute"):doaction("deploy chute", true).
}

until status = "LANDED" or status = "SPLASHED" {
    S2_CPU[0]:getmodule("kOSProcessor"):connection:sendmessage(altitude).
}