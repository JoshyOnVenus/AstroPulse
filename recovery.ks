runoncepath("0:/partlist.ks").
runoncepath("0:/groundFunctions.ks").

//clearscreen.
print "Attempting To Recover...".

lock steering to srfretrograde.

for p in S1_CHUTE {
    p:getmodule("ModuleParachute"):doaction("deploy chute", true).
}