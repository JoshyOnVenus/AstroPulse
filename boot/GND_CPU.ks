runoncepath("0:/partlist.ks").
runoncepath("0:/groundFunctions.ks").

//clearscreen.
GND_CPU[0]:getmodule("kOSProcessor"):doevent("Open Terminal").
print "Waiting For AG6 To Be Pressed..." at(2,10).

set terminal:width to 40.
set terminal:height to 12.

until false {
    if ag6 {
        GND_STRONGBACK_RETRACT().
        GND_HOLD_DOWN_CLAMP_RELEASE().
        S2_CPU_COMMAND:sendmessage("Run Stage 2").
        break.
    }
    if ag7 {
        S2_CPU_COMMAND:sendmessage("Static Fire").
        break.
    }
}