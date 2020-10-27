API of the nodes
================

The control software of the Romi Rover consists of number of nodes
that communicate among each other. A number of *topics* are
defined. These topics are a bit like an API.

Besides the topics, the nodes also use different types of
communication patterns. In most cases, the interaction with a node is
similar to a remote procedure call. The client sends a JSON request
over a messagelink (a websocket) to the node. The node replies with a
JSON response message. In some cases, a simple HTTP request and
response is used instead of a messagelink. In other cases, the node
only braodcasts out JSON formatted events over a websocket. The types
of communications are listed below.

| Type    | Description |
| ------- | ----------- |
| service | Uses the HTML request-response pattern |
| controller | Uses RPC over WebSocket |
| streamer | Transmits a continuous data flow over HTML |
| messagehub | Communicates over a WebSocket |
| datahub | Broadcasts messages over UDP |

Different nodes can implement the same topic. For example, the nodes
*video4linux*, *picamera*, *fake_camera* all implement the `camera`
topic. However, only one of these nodes should be active at one time.

A nodes can also implement several topics. For example, the motor
controller implements both the `motorcontroller` and `encoders`
topics.

This document does not go into the details of messagelinks or how to
do an HTTP request. Here we simply document all the available topics,
the type of communication, and their messages they expect.

In rcom, a communication end-point is identified by the combination of
topic and type. So a streamer with the topic `camera` is distinct from
the service with the same topic.

The following table lists all the topics and the types that have been
defined by Romi Rover. In the sections below you will find more
details on each.

| API           | Description           | Type  |
| ------------- | --------------------- | ----- |
| [__camera__](#camera) | Provides RGB images | service and streamer |
| [__camera_recorder__](#camera_recorder) | Records a sequence of images to disk | controller |
| [__cnc__](#cnc) | Controls a XYZ motion device | controller |
| [__configuration__](#configuration) | Exports the configuration file | service |
| [__control_panel__](#control_panel) | Controls the display and power relays | controller |
| [__encoders__](#encoders) | Broadcasts the encoder values of the wheels | datahub |
| [__fsdb__](#fsdb) | Broadcasts events about newly created files | messagehub |
| [__gimbal__](#gimbal) | Controls the camera mount | controller |
| [__motorcontroller__](#motor_controller) | Controls the wheel motors | controller |
| [__navigation__](#navigation) | Controls the displacement of the rover | controller |
| [__pose__](#pose) | Broadcasts the position and orientation of the rover | datahub |
| [__proxy__](#proxy) | A web proxy to all the nodes and a web server for static pages | service & messagehub |
| [__script_engine__](#script_engine) | Executes scripts | service |
| [__tool_carrier__](#tool_carrier) | Handles the mechanical weeding tool carrier | controller |


## camera

The existing implementations are: `video4linux`, `realsense`, `picamera`, and `fake_camera`.

The camera combines two communication end-points interfaces. It has a
service that provides single JPEG images. It also has a streamer
interface that broadcasts a continuous stream of JPEG images encoded
as a multipart response (the corresponding mimetype is
"multipart/x-mixed-replace").

The two handled URIs are: 

* `/camera.jpg`: Use this URI to retrieve the latest RGB image from the camera service.

* `/stream.html`: This URI to get a continuous, video-over-html stream from the camera streamer.


## camera_recorder

The camera_recorder is a controller that connects to a camera. Upon
request, it will start recording the images of the camera to disk. It
accepts to commands: start and stop.


### start

Start recording the images to disk.

Example:

```
{"command": "start"}
```

### stop

Stop the recording.

Example:

```
{"command": "stop"}
```


## configuration

The `configuration` service allows nodes to obtain the settings of the
rover. A simple HTML request with the name of the settings will return
its associated value as a JSON-formatted object.

Suppose the configuration file contains the following:

```json
{
    "menu": {
        "starters": ["velouté de champignons", "tomato & mozarella"],
        "mains": ["eggplant lasagna", "meatloaf with mashed potatoes"],
        "deserts": ["chocolate mousse", "panna cotta", "crème brulée"],
    }
}
```

Then an HTTP request to the URI `/menu/starters` will return
`["velouté de champignons", "tomato & mozarella"]` in the body of the
response.

Implementation note: You can use the function `client_get` in the `rcom` API to obtain the value directly as a `json_object_t`:

```c
json_object_t list = client_get("configuration", "menu/starters");
```

## control_panel

The control_panel is the controller that interfaces with the physical
control panel of the rover. It currently handles to commands: shutdown
and display.


### shutdown

Goes through the following steps: Asks the control panel to cut the
power circuit (cuts the motors but not the controllers), then
initiates the shutdown of the on-board computer, and requests the
control panel to cut the power of the logical circuit (with a 5
seconds delay).

Example:

```
{"command": "shutdown"}
```

### display

Asks the control panel to display a message. The length of the message
is currently limited to 16 characters. The message may not be
displayed immediately, or may be skipped, if too many messages are
sent.

Example:

```
{"command": "display", "message": "No network"}
```


## cnc

Existing implementations: `grbl`, `oquam`, and `fake_cnc`.


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

## encoders


## fsdb

## gimbal

## motor_controller

## navigation

## pose

## proxy

## script_engine

## tool_carrier





