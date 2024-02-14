//Boot de SA
core:part:getModule("kOSProcessor"):doEvent("Open Terminal").
copyPath("0:/SA/Lib/lib.ks", core:volume:name + ":/lib.ks").
if core:volume:name = "1"{
    switch to 1.
    runPath("1:/lib.ks").
    copyPath("0:/SA/FC.ks", "1:/FC.ks").
    switch to 1.
    runPath("1:/FC.ks").  
}
if core:volume:name = "S"{
    copyPath("0:/SA/Lib/lib.ks", "S:/lib.ks").
    switch to S.
    runPath("S:/lib.ks").
    copyPath("0:/SA/Modes/CTs.ks", "S:/CTs.ks").
    switch to S.
    runPath("S:/CTs.ks").
}