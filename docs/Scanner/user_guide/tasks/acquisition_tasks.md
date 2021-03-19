Acquisition-related tasks
===

## Scan task
This task class is used to acquire a set of RGB images from a real plant to study using the *Plant imager* hardware.
It produces a `Fileset` named `'images'` (designated as raw scan) that may go with a metadata dictionary if provided as parameter.

## VirtualScan task
This task class is used to acquire a set of RGB images from a mesh computer model (OBJ file) representing a plant using blender.
It produces a `Fileset` named `'images'` that may be accompnied by a metadata dictionary if provided as parameter.

## VirtualPlant task
This task class is used to generate a mesh computer model (OBJ file) representing a plant using a programmable plant model generator called LPY.
It produces ??? (**TODO**)

## CalibrationScan task
This task class is used to ??? (**TODO**)
