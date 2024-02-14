@lazyglobal off.
runoncepath("0:/partlist.ks").
runoncepath("0:/groundFunctions.ks").
DEFINE_PARTS().

global fairings_attached to true.
global S1_ENGINE_ON to false.
global S2_ENGINE_ON to false.

// function GND_LAUNCH_BASE_RELEASE {
//     for part in GND_BASE {
//         part:getmodule("LaunchClamp"):doaction("release clamp", true).
// 		print "Launch Base Released".
//     }
// }

function PF_DEPLOY {
    for part in S2_FAIRING {
        if part:modules:contains("ModuleDecouple") {
            local m is part:getmodule("ModuleDecouple").
            for a in m:allactionnames() {
                if a:contains("Decouple") {
                    m:doaction(a, true).
                    set fairings_attached to false.
					print "Fairing Deployed".
                }
            }
        } else if part:modules:contains("ProceduralFairingDecoupler") {
            local m is part:getmodule("ProceduralFairingDecoupler").
            for a in m:allactionnames() {
                if a:contains("Jettison Fairing") {
                    m:doaction(a, true).
                    set fairings_attached to false.
					print "Fairing Deployed".
                }
            }
        }
    }
} 

function ENGINE_CONTROL {
	parameter stageName, action.

	if stageName = "FIRST STAGE" {
		if action = "Start" {
			for ENGINE in S1_ENGINE {
				ENGINE:getmodule("ModuleEnginesFX"):doaction("Activate Engine", true).
				print "Stage 1 - Engine Started".
			}
			set S1_ENGINE_ON to true.
		}
		else if action = "Shutdown" {
			for ENGINE in S1_ENGINE {
				ENGINE:getmodule("ModuleEnginesFX"):doaction("Shutdown Engine", true).
				print "Stage 1 - Engine Shutdown".
			}
			set S1_ENGINE_ON to false.
		}
	}
	else if stageName = "SECOND STAGE" {
		if action = "Start" {
			for ENGINE in S2_ENGINE {
				ENGINE:getmodule("ModuleEnginesFX"):doaction("Activate Engine", true).
				print "Stage 2 - Engine Started".
			}
			set S2_ENGINE_ON to true.
		}
		else if action = "Shutdown" {
			for ENGINE in S2_ENGINE {
				ENGINE:getmodule("ModuleEnginesFX"):doaction("Activate Engine", true).
				print "Stage 2 - Engine Shutdown".
			}
		}
	}
}

function RESOURCE {
	parameter resourceName, stageName.
}