@lazyglobal off.
runoncepath("0:/partlist.ks").

function DEFINE_PARTS {
    //Define Ground Stage 
    global GND_CPU to ship:partstagged(GND_TAGS["GROUND STAGE"]["CPU"]).
    global GND_STRONGBACK to ship:partstagged(GND_TAGS["GROUND STAGE"]["STRONGBACK"]).
    global GND_BASE to ship:partstagged(GND_TAGS["GROUND STAGE"]["BASE"]).
    global GND_CLAMPS to ship:partstagged(GND_TAGS["GROUND STAGE"]["CLAMPS"]).

    //Define Stage 1
    global S1_CPU to ship:partstagged(SHIP_TAGS["FIRST STAGE"]["CPU"]).
    global S1_ENGINE to ship:partstagged(SHIP_TAGS["FIRST STAGE"]["ENGINE"]).
    global S1_TANK to ship:partstagged(SHIP_TAGS["FIRST STAGE"]["TANK"]).
    global S1_INTERSTAGE to ship:partstagged(SHIP_TAGS["FIRST STAGE"]["INTERSTAGE"]).

    //Define Stage 2
    global S2_CPU to ship:partstagged(SHIP_TAGS["SECOND STAGE"]["CPU"]).
    global S2_ENGINE to ship:partstagged(SHIP_TAGS["SECOND STAGE"]["ENGINE"]).
    global S2_TANK to ship:partstagged(SHIP_TAGS["SECOND STAGE"]["TANK"]).
    global S2_PAYLOAD_ADAPTER to ship:partstagged(SHIP_TAGS["SECOND STAGE"]["PAYLOAD ADAPTER"]).
    global S2_FAIRING to ship:partstagged(SHIP_TAGS["SECOND STAGE"]["FAIRING"]).
}