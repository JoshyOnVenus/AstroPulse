clearvecdraws().
clearscreen.
set Kp to 0.055.
set Ki to 0.06.
set Kd to 0.1.
set PID to pidloop(Kp,Ki,Kd,0,1).
set PID:setpoint to 50.
set throt to 0.
lock throttle to throt.

set point to latlng(-0.0502119, -74.489998).

set PID2 to pidloop(Kp,Ki,Kd,0,90).
set PID2:setpoint to 90.

stage.
rcs on.
sas on.

until false {
	//Draw Vectors
	set vd to vecdraw(v(0,0,0), vxcl(v(0,0,0), body:geopositionof(velocity:surface):position), green, "", 1.0, true, 0.2).
	set vd2 to vecdraw(v(0,0,0), vxcl(v(0,0,0), point:position), blue, "", 1.0, true, 0.2).
	set vd3 to vecdraw(v(0,0,0), vxcl(v(0,0,0), body:geopositionof(facing:vector):position), purple, "", 1.0, true, 0.2).
	
	
	set throt to PID:update(time:seconds, altitude-(body:geopositionof(velocity:surface)):terrainheight).
	PID2:update(time:seconds, ship:velocity:surface:mag).
	print "Distance To Target: " + point:distance at(0,3).
	print "Throttle: " + throttle at(0,4).
	print "Altitude: " + (altitude-ship:geoposition:terrainheight) at(0,6).
	print "Altitude Error: " + ((altitude-ship:geoposition:terrainheight)-PID:setpoint) at(0,7).
	print "Facing Altitude: " + (altitude - body:geopositionof(facing:vector * 5):terrainheight) at(0,8).
	print PID2 at(0,9).
	print body:geopositionof(velocity:surface):position at (0,14).
}