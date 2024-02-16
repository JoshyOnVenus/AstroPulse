runoncepath("0:/partlist.ks").
runoncepath("0:/groundFunctions.ks").
runoncepath("0:/mainFunctions.ks").
set kuniverse:defaultloaddistance to 30000.

//clearscreen.
S2_CPU[0]:getmodule("kOSProcessor"):doevent("Open Terminal").
print "Stage 2 - Waiting For Message".

set terminal:width to 40.
set terminal:height to 12.

until false {
    wait until not core:messages:empty.
    set recievedMessage to core:messages:pop.
    set decodedMessage to recievedMessage:content.
    clearscreen.
    print "Stage 2 - Message Recieved: " + decodedMessage at(0,2).

    if decodedMessage = "Run Stage 2" {
        lock throttle to 1.
        runoncepath("0:/main.ks").
    }
    if decodedMessage = "Static Fire" {
        lock throttle to 1.
        ENGINE_CONTROL("FIRST STAGE", "Start").
        wait 30.
        ENGINE_CONTROL("FIRST STAGE", "Shutdown").
        lock throttle to 0.
    }
}