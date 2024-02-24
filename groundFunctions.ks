@lazyglobal off.
runoncepath("0:/partlist.ks").

DEFINE_PARTS().

function DEFINE_PARTS {
    //Define Ground Stage 
    global GND_CPU to core:vessel:partstagged(GND_TAGS["GROUND STAGE"]["CPU"]).
    global GND_STRONGBACK to core:vessel:partstagged(GND_TAGS["GROUND STAGE"]["STRONGBACK"]).
    global GND_BASE to core:vessel:partstagged(GND_TAGS["GROUND STAGE"]["BASE"]).
    global GND_CLAMPS to core:vessel:partstagged(GND_TAGS["GROUND STAGE"]["CLAMPS"]).
    global GND_DECOUPLER to core:vessel:partstagged(GND_TAGS["GROUND STAGE"]["LAUNCH DECOUPLER"]).

    //Define Stage 1
    global S1_CPU to core:vessel:partstagged(SHIP_TAGS["FIRST STAGE"]["CPU"]).
    global S1_ENGINE to core:vessel:partstagged(SHIP_TAGS["FIRST STAGE"]["ENGINE"]).
    global S1_TANK to core:vessel:partstagged(SHIP_TAGS["FIRST STAGE"]["TANK"]).
    global S1_INTERSTAGE to core:vessel:partstagged(SHIP_TAGS["FIRST STAGE"]["INTERSTAGE"]).
    global S1_CHUTE to core:vessel:partstagged(SHIP_TAGS["FIRST STAGE"]["PARACHUTE"]).

    //Define Stage 2
    global S2_CPU to core:vessel:partstagged(SHIP_TAGS["SECOND STAGE"]["CPU"]).
    global S2_ENGINE to S2_CPU[0]:ship:partstagged(SHIP_TAGS["SECOND STAGE"]["ENGINE"]).
    global S2_TANK to core:vessel:partstagged(SHIP_TAGS["SECOND STAGE"]["TANK"]).
    global S2_PAYLOAD_ADAPTER to core:vessel:partstagged(SHIP_TAGS["SECOND STAGE"]["PAYLOAD ADAPTER"]).
    global S2_FAIRING to core:vessel:partstagged(SHIP_TAGS["SECOND STAGE"]["FAIRING"]).

    global S1_CPU_COMMAND is S1_CPU[0]:getmodule("kOSProcessor"):connection.
    global S2_CPU_COMMAND is S2_CPU[0]:getmodule("kOSProcessor"):connection.
}

function GND_STRONGBACK_RETRACT {
    for part in GND_STRONGBACK {
        part:getmodulebyindex(10):doaction("toggle 2-step fallback retract", true).
		print "Strongback Retracted".
    }
}

function GND_HOLD_DOWN_CLAMP_RELEASE {
    for part in GND_CLAMPS {
        part:getmodule("ModuleAnimateGenericExtra"):doaction("toggle hold-down", true).
		print "Hold Down Clamp Released".
    }
}

function GND_DECOUPLER_DECOUPLE {
    GND_DECOUPLER[0]:getmodule("ModuleDecouple"):doaction("Decouple", true).
}