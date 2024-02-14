runoncepath("0:/partlist.ks").
runoncepath("0:/groundFunctions.ks").

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
    print "Stage 2 - Message Recieved: " + decodedMessage[0] at(0,2).

    if decodedMessage[0] = "Run Stage 2" {
        lock throttle to 1.
        runoncepath("0:/main.ks").
    } 
    else if decodedMessage[1] = "S1_CPU" {
        decodedMessage[1]:getmodule("kOSProcessor"):connection:sendmessage(list("Altitude",S2_CPU[0])).
    }
}