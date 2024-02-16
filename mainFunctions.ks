@lazyglobal off.
runoncepath("0:/partlist.ks").
runoncepath("0:/groundFunctions.ks").

global FAIRINGS_ATTACHED to true.
global PAYLOAD_SEPARATED to false.
global S1_ENGINE_ON to false.
global S2_ENGINE_ON to false.
global S1_SEPARATED to false.

function PF_DEPLOY {
    for part in S2_FAIRING {
        if part:modules:contains("ModuleDecouple") {
            local m is part:getmodule("ModuleDecouple").
            for a in m:allactionnames() {
                if a:contains("Decouple") {
                    m:doaction(a, true).
                    set FAIRINGS_ATTACHED to false.
					//print "Fairing Deployed".
                }
            }
        } else if part:modules:contains("ProceduralFairingDecoupler") {
            local m is part:getmodule("ProceduralFairingDecoupler").
            for a in m:allactionnames() {
                if a:contains("Jettison Fairing") {
                    m:doaction(a, true).
                    set FAIRINGS_ATTACHED to false.
					//print "Fairing Deployed".
                }
            }
        }
    }
} 

function PAYLOAD_SEPARATION {
	if PAYLOAD_SEPARATED = false and FAIRINGS_ATTACHED = false {
		lock steering to prograde.
		if eta:apoapsis <= 1 {
			S2_PAYLOAD_ADAPTER[0]:getmodule("ModuleDecouple"):doaction("Decoupler Staging", true).
			set PAYLOAD_SEPARATED to true.
			//print "Payload Deployed!".
		}
	}
}

function ENGINE_CONTROL {
	parameter stageName, action.

	if stageName = "FIRST STAGE" {
		if action = "Start" {
			for ENGINE in S1_ENGINE {
				ENGINE:getmodule("ModuleEnginesFX"):doaction("Activate Engine", true).
				//print "Stage 1 - Engine Started".
			}
			set S1_ENGINE_ON to true.
		}
		else if action = "Shutdown" {
			for ENGINE in S1_ENGINE {
				ENGINE:getmodule("ModuleEnginesFX"):doaction("Shutdown Engine", true).
				//print "Stage 1 - Engine Shutdown".
			}
			set S1_ENGINE_ON to false.
		}
	}
	else if stageName = "SECOND STAGE" {
		if action = "Start" {
			for ENGINE in S2_ENGINE {
				ENGINE:getmodule("ModuleEnginesFX"):doaction("Activate Engine", true).
				//print "Stage 2 - Engine Started".
			}
			set S2_ENGINE_ON to true.
		}
		else if action = "Shutdown" {
			for ENGINE in S2_ENGINE {
				ENGINE:getmodule("ModuleEnginesFX"):doaction("Shutdown Engine", true).
				//print "Stage 2 - Engine Shutdown".
			}
			set S2_ENGINE_ON to false.
		}
	}
}

function GET_RESOURCE {
	parameter stageName.
	if stageName = "FIRST STAGE" {
		for resource in S1_TANK[0]:resources {
			if resource:name = "LIQUIDFUEL" {
				global S1_FUEL_AMOUNT to resource:amount.
				global S1_FUEL_CAPACITY to resource:capacity.
			}
			else if resource:name = "OXIDIZER" {
				global S1_OX_AMOUNT to resource:amount.
				global S1_OX_CAPACITY to resource:capacity.
			}
		}
	}
	else if stageName = "SECOND STAGE" {
		for resource in S2_TANK[0]:resources {
			if resource:name = "LIQUIDFUEL" {
				global S2_FUEL_AMOUNT to resource:amount.
				global S2_FUEL_CAPACITY to resource:capacity.
			}
			else if resource:name = "OXIDIZER" {
				global S2_OX_AMOUNT to resource:amount.
				global S2_OX_CAPACITY to resource:capacity.
			}
		}
	}
	else {

	}
}

function GET_ALTITUDE {
	parameter stageName.
	if stageName = "FIRST STAGE" {
		global S1_ALT to S1_CPU[0]:ship:altitude.
	}
	else if stageName = "SECOND STAGE" {
		global S2_ALT to S2_CPU[0]:ship:altitude.
	}
	else {

	}
}

function GET_SPEED {
	parameter stageName.
	if stageName = "FIRST STAGE" {
		global S1_SPEED to S1_CPU[0]:ship:airspeed.
	}
	else if stageName = "SECOND STAGE" {
		global S2_SPEED to S2_CPU[0]:ship:airspeed.
	}
	else {

	}
}