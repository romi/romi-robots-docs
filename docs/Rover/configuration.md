# Romi Rover configuration

The Romi Rover control software uses the following input files (see
also the  [Software](../software) documentation:

* The configuration file: Most of the settings of the rover can be modified in this file.

* The script file: This file lists all the commands of the rover that
  are actionnable by the user, and what these commands should do.


The configuration and script files are discussed in detail below.

# Configuration file

The rover control software is starting using the `romi-rover`
command. This command takes the path to the main configuration as an
argument. Example configutation files can be found in the
`romi-rover/config` directory.

The configuration data is formated in JSON and is a dictionnary of
top-level section names and the values for that section. It's overall structure is:

```json
{
    "imager": "...",
    "navigation": {
    },
    "oquam": {
    },
    "ports": {
    },
    "user-interface": {
    },
    "weeder": {
    }
}
```

The `navigation` section contains the parameters related to the
navigation, from the low-level settings of the motor drivers to the
settings for the autonomous navigation. The `oquam` section contains
all the parameters related to the CNC. The `ports` section lists all
of the serial ports and their usage. The `user-interface` is used to
configure such things as the controller to rover speed
mapping. Finally, in the `weeder` section you can change the settings
related to the weeding algorithm. We will discuss each of these
sections below.

## Dimensions

As much as possible, the configuration and script files uses meter for
distances, seconds for time, m/s for speeds, m/s² for acceleration.

We deviate from the scientific standard for angles, for which we use
degrees instead of radians.


## The navigation section

An example of a complete navigation section is shown below:

```json
{
    "navigation": {
        "rover": {
            "wheel-diameter": 0.47,
            "wheelbase": 1.45,
            "wheeltrack": 1.35,
            "maximum-speed": 3,
            "maximum-acceleration": 0.5
        },
        "brush-motor-driver": {
            "encoder-directions": {
                "left": -1,
                "right": 1
            },
            "encoder-steps": 16000,
            "maximum-signal-amplitude": 500,
            "pid": {
                "ki": [ 3, 100 ],
                "kp": [ 100, 100 ]
            }
        },
        "track-follower": "python"
    }
}
```

The `rover` section sets some of the physical parameters of the rover:

| Name                 | Description  |
| -------------------- | --------------------------- |
| wheel-diameter       | The diameter of the motorized wheel, in meter (m) |
| wheelbase            | The distance between the axes of the front wheel and the back wheel (m) |
| wheeltrack           | The distance between the back wheels (front wheels), measured from the middle of the left wheel to the middle of the right wheel (m) |
| maximum-speed        | The maximum allowed speed (m/s) |
| maximum-acceleration | The maximum allowed acceleration (m/s²) |

The `brush-motor-driver` object has a number of settings for the
firmware that controls the motors:.


| Name                     | Description  |
| ------------------------ | --------------------------- |
| encoder-directions       | This value is an array of two values, the first concerns the left wheel, the second concerns the right wheel. The values are either 1 or -1. In case the value is 1, the encoder values decrement when the wheel is turning forwards. In case the value is 1, the encoder values increment when the wheel is turning forwards.   |
| encoder-steps            | The number of encoder steps for a full turn of the wheel. This should take into account the number of steps of the encoder itself, plus the number of turns of the gearbox. |
| maximum-signal-amplitude | The maximum signal that the driver can send to the motor driver. Should be a value > 0 and <= 500;  |
| pid                      | These are the values for the PI controller - a [PID Controller without the 'D'](https://en.wikipedia.org/wiki/PID_controller) - used by the driver. Two values are needed: the constants Kp and Ki. They are not specified as floating-point values but as a couple [numerator, denominator]. So [3, 100] means 3/100th. |


Finally, the `track-follower` settings defines which algorithm should
be used for the track following used for autonomous navigation. Three
options are available at the time of writing:


| Name     | Description  |
| -------- | --------------------------- |
| odometry | Use the encoders on the wheels. |
| manual   | Expect manual input from the controller. |
| python   | This is the line following algorithm currently being tested that follows a line of crops. The name will likely change when the algorithms is integrated in the main software. |

## The Oquam section

```json
{
    "oquam": {
        "cnc-range": [[0, 1.0], [0, 0.75], [-0.4, 0]],
        "path-maximum-deviation": 0.01,
        "path-slice-duration": 0.02,
        "stepper-settings": {
            "steps-per-revolution": [200, 200, 200],
            "microsteps": [8, 8, 1],
            "gears-ratio": [1, 1, 1],
            "displacement-per-revolution": [0.04, 0.04, -0.0015],
            "maximum-rpm": [300, 300, 300],
            "maximum-acceleration": [0.3, 0.3, 0.03]
        }
    }
}
```


| Name                     | Description  |
| ------------------------ | --------------------------- |
| cnc-range                | The dimensions of the three axes of the CNC. The values must be provided as an array of three couples, for the x, y, and z axis. Each couple specifies the minimum and maximum position in meters.  |
| path-maximum-deviation   | This value, in meters, sets the maximum allowed deviation from the ideal path when the CNC is requested to trace a polygonal path. By allowing a small deviation, the CNC can maintain a given speed while assuring that the maximum accelerations (and thus forces) are respected. It allows for smoother path travelings. |
| path-slice-duration      | A long path is sliced into small segments of constant speed. This variable sets the default duration of these segments. |

The `stepper-settings` provide the information on the stepper motors
that are used. The following six pieces of information are required:

| Name                        | Description  |
| --------------------------- | --------------------------- |
| steps-per-revolution        | The number os steps per revolution of the stepper motors, for the x, y, and z axis.  |
| microsteps                  | If micro-stepping was enabled, the number of micro-steps for the x, y, and z axis (a value of 1 indicates no micro-stepping).  |
| gears-ratio                 | If the stepper motors use gears, provide the gear ratio. 1 means no gearbox is used. A value of N means that N revolutions of the stepper motor are required for 1 revolution of the output axis, or that the driver has to send N times more steps to the stepper motor for the output axis to complete a revolution. |
| displacement-per-revolution | This value specifies by how much the CNC moves, in meter, for one revolution of the output axis of the motor + gearbox combination. This value is related to the size of the pulley that pulls on the belt. |
| maximum-rpm                 | The maximum speed of the stepper motors. The datasheets of the stepper motor generaly indicate this value in revolutions per minute (rpm). |
| maximum-acceleration        | The maximum allowed acceleration, in m/s², for each of the axes. |


## The ports section

This dictionnary lists which firmware drivers are available on what
system ports. The rover uses mostly serial connections. The joystick
uses a different device, however. The `rcdiscover` utility can be used
to generate this list:

```bash
$ ./bin/rcdiscover path/to/config.json
```

The list has entries as follows:

```json
{
    "ports": {
        "oquam": {
            "port": "/dev/ttyACM5",
            "type": "serial"
        }
    }
}
```

First comes the name of the firmware that is accessible through this
port. It tells the type of the port ('serial' or 'input-device'), and
the device's path in the 'port' field).

## The user-interface section

The user interface config contains the settings for the speed
controller. There are two drive modes: fast and accurate. Each have
their own settings:

```json
{
    "user-interface": {
        "speed-controller": {
            "accurate": {
                "speed-multiplier": 0.2,
                "direction-multiplier": 0.05,
                "use-speed-curve": true,
                "speed-curve-exponent": 1,
                "use-direction-curve": true,
                "direction-curve-exponent": 1
            },
            "fast": {
                "speed-multiplier": 0.3,
                "direction-multiplier": 0.15,
                "use-speed-curve": true,
                "speed-curve-exponent": 1,
                "use-direction-curve": true,
                "direction-curve-exponent": 1
            }
        }
    }
}
```

The speed controller sets the the speed of the left and right wheel
and thus the radius of the turn that rover will follow.

The two input values from the controller that set the speed and
direction are mapped onto the range [-1, 1]. These normalized values
are then used to determine the relative speed of the left and right
wheel. The absolute speed of the rover is the product of the relative
speed and the absolute speed given in the rover settings discussed
above.

The relative speed of the left wheel is:

```c++
speed_left = (speed_multiplier * speed + direction_multiplier * direction);
```

where `speed` and `direction` are the normalized inputs from the
controller. 

| Name                     | Description  |
| ------------------------ | --------------------------- |
| speed-multiplier         | This number, with a value between 0 and 1, determines the maximum relative speed when the the speed trigger is completely pressed by the user.  |
| direction-multiplier     | The number defines the maximum speed difference, and thus the maximum turning angle, between the left and right wheel. |

In addition, it is possible to use an exponential curve to map the
speed and direction values. This may give a more smooth behaviour when
the rover starts from stand-still to higher speeds. A speed of zero
still maps to zero, and a speed of one still maps to one, but in
between the mapping follows a curve instead of a straight line. The
curve is as follows:

```c++
x = ((exp(exponent * x) - 1.0) / (exp(exponent) - 1.0));
```

| Name                     | Description  |
| ------------------------ | --------------------------- |
| use-speed-curve          | true of false: should the speed controller use the exponential curve to map the speed value?  |
| speed-curve-exponent     | The exponent of the speed curve. |
| use-direction-curve      | true of false: should the speed controller use the exponential curve to map the direction value?  |
| direction-curve-exponent | The exponent of the direction curve. |


## The weeder section


The weeder sections contains the settings for the weeder tool. These
are as follows:

```json
{
    "weeder": {
        "diameter-tool": 0.04,
        "imagecropper": {
            "workspace": [
                306,
                210,
                985,
                745
            ]
        },
        "speed": 0.8,
        "z0": -0.22
    }
}
```

| Name                     | Description  |
| ------------------------ | --------------------------- |
| diameter-tool            | The size of the weeding tool head, in meter. |
| imagecropper.workspace   | The crop size and position the camera image to obtain the image of the workspace only. |
| speed                    | The relative speed of the weeding tool, between 0 and 1.0. This speed is multiplied by the maximum speed of the CNC to obtain the final speed of the weeding tool. |
| z0                       | The position of the weeding tool when weeding. |



# Script file

The script file consists of a JSON array of script objects:


```json
[
    {
        "id": "script1",
        "title": "The First Script",
        "script": [
            //...
        ]
    },
    //...
]
```

The script objects have the following fields:

| Name          | Value   | Required | Description  |
| ------------- | ------- | -------- | ------------ |
| id            | String  | Required | The internal name of the script |
| title         | String  | Required | The name to be shown to end-users |
| script        | Array   | Required | The list of actions to be taken |

The script itself is an array that lists all the actions to be taken,
one after the other. For example:

```json
[
    {
        "id": "script1",
        "title": "The First Script",
        "script": [
            {"action": "start_recording"},
            {"action": "move", "distance": 8, "speed": 400},
            {"action": "stop_recording"},
            {"action": "move", "distance": -8, "speed": -400}
        ]
    },
    //...
]
```

Each action object has an `action` field. The list of available actions are:

| Name            | Description  |
| --------------- | ------------ |
| start_recording | Start recording the images of the top camera |
| stop_recording  | Stop recording the images of the top camera |
| move            | Move a given distance (at a given speed) |
| hoe             | Start weeding |
| homing          | Go to the home position (for rovers with a limit switch only) |


The `move` action takes the following parameters:

| Name          | Value   | Required | Description  |
| ------------- | ------- | -------- | ------------ |
| distance      | Number (in meters)  | Required | The distance to be travelled |
| speed         | Number (-1000 < speed < 1000) | Optional | The speed |

The `moveat` action takes a `speed` value, as in the `move` command above.







