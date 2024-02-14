@lazyglobal off.

global GND_TAGS is lexicon(
    "GROUND STAGE", lexicon(
        "CPU", "GND_CPU",
        "STRONGBACK", "GND_STRONGBACK",
        "BASE", "GND_LAUNCH_BASE",
        "CLAMPS", "GND_HOLD_DOWN_CLAMP"
    )
).

global SHIP_TAGS is lexicon(
    "FIRST STAGE", lexicon(
        "CPU", "S1_CPU",
        "ENGINE", "S1_ENGINE",
        "TANK", "S1_TANK",
        "INTERSTAGE", "S1_INTERSTAGE",
        "PARACHUTE", "S1_CHUTE"
    ),

    "SECOND STAGE", lexicon(
        "CPU", "S2_CPU",
        "ENGINE", "S2_ENGINE",
        "TANK", "S2_TANK",
        "PAYLOAD ADAPTER", "S2_PAYLOAD_ADAPTER",
        "FAIRING", "S2_PF"
    )
).
