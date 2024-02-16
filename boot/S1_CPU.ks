runoncepath("0:/partlist.ks").
runoncepath("0:/groundFunctions.ks").
set kuniverse:defaultloaddistance to 30000.

//clearscreen.
S1_CPU[0]:getmodule("kOSProcessor"):doevent("Open Terminal").
print "Stage 1 - Waiting For Message".

set terminal:width to 40.
set terminal:height to 12.

until false {
    wait until not core:messages:empty.
    set recievedMessage to core:messages:pop.
    set decodedMessage to recievedMessage:content.
    clearscreen.
    print "Stage 1 - Message Recieved: " + decodedMessage at(0,2).

    if decodedMessage = "Run Recovery" {
        runoncepath("0:/recovery.ks").
    }
}