Developer Documentation
=======================



# JSON WebSocket API of the Romi Rover nodes


## CNC node

There are currently two implementations of the CNC API: `grbl`, `oquam`, and `fake_cnc`.

The CNC has a JSON-over-WebSocket controller interface that accepts
the commands documented below.  

### moveto

Move to a specified absolute position in meters.

Example:

```
{"command": "moveto", "x": 0.4, "y": 0.4}
{"command": "moveto", "z": -0.1}
```


### homing

Move to the home position, if the CNC has limit switches.

Example:

```
{"command": "homing"}
```


### travel

The `travel` command serves to make the CNC travel a given path, defined by a list of points in absolute coordinates in meter.

Example:

```
{"command": "travel", "path": [[0,0,0], [0.5,0,0], [0.5,0.5,0], [0,0.5,0], [0,0,0]]}
```

### spindle

Starts or stops the spindle. A speed can be specified with a value between 0 (stopped) and 1 (maximum speed).

Example:

```
{"command": "spindle", "speed": 1}
```



## Motor controller node




## Camera node

The existing implementations are: `video4linux`, `realsense`, `picamera`, and `fake_camera`.

Streamer: /stream.html

Service: /camera.jpg

