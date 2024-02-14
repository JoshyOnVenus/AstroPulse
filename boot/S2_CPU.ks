runoncepath("0:/partlist.ks").
runoncepath("0:/groundFunctions.ks").
DEFINE_PARTS().

clearscreen.
S2_CPU[0]:getmodule("kOSProcessor"):doevent("Open Terminal").
print "Stage 2 - Waiting For Message".

set terminal:width to 40.
set terminal:height to 12.

until false {
    wait until not core:messages:empty.
    set recievedMessage to core:messages:pop.
    set decodedMessage to recievedMessage:content.

    print "Stage 2 - Message Recieved: " + decodedMessage.

    if decodedMessage = "Run Stage 2" {
        lock throttle to 1.
        runoncepath("0:/main.ks").
    } 
    else if decodedMessage = "Run Static Fire" {

    }
}