# Known strengths and limitations

The way we designed the _Plant Imager_ and the software has strengths but also impose some limitations.
We try to cover them in the following section.

## Open loop design

### The problem
The motors we use function in an _open loop_ manner, that is: we send and series of instructions to the motors, telling them how many steps we want and in which direction to performs them... and hopes for the best.

Indeed, contrary to the _feedback loop_ design, there is no way of knowing if those instruction were followed accurately.
This _open loop_ design might seem unfortunate or inadequate but this is actually a lot cheaper.

As there is a user standing next to the _Plant Imager_ you might expect her/him to notice any mistake made by the robot.
This is simply not true and not a good approach to tackling the problem.

### The proof
To prove this point, I have performed a series of 5 repetitions of the very same acquisitions, without changing a thing between each of them.
To my knowledge, everything went fine, but this is what I got when I cycled through the pictures taken at the same position (the first one):

![plant_imager_v2_repeatability.gif](plant_imager_v2_repeatability.gif)

As you can see, most of the images looks exactly the same, and if it was not for the frame indicator on the top right we would not notice, but the repeat `Sangoku_40_1` has a small offset compared to the others.

You may try to stay positive and say that one out of five is not that bad.
Unfortunately, this is not true as this is just one position and the sampling for this position only is not enough to draw this conclusion.
Also, we do not would like to build a reliable machine, users will not be too happy with that success rate.

### The solution
As the accuracy of the camera positions is not perfect, we have to resort to _Structure from Motion_ algorithm to compensate for those imperfections.


## Calibration procedure

We developed an intrinsic calibration procedure to compensate for lens aberrations.
We use OpenCV and a ChArUco broard to accurately estimate and correct them.