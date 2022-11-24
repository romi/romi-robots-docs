# Wiring of the X-Controller

<figure>
<img src="../../../assets/images/x_controller.jpg" style="height:350px" />
  <figcaption>X-Controller.</figcaption>
</figure>

## BOM

To assemble the X-Controller, you will need to buy one:

* US buy [here](https://www.inventables.com/technologies/x-carve/choose)
* EU buy [here](https://robosavvy.co.uk/inventables-xcarve-1000mm-in-stock.html)


## Assembly

If you ordered the X-Controller, follow the official assembly instructions [here](https://inventables.gitbook.io/x-carve-assembly/x-controller).

!!! note
    This is what we used in our first and third version of the plant imager hardware.

!!! warning
    We replaced the default `Grbl` firmware by `Oquam`, our own implementation. See [here](flashing_oquam.md) for the instructions on how to flash this firmware to the X-Controller.


## Change micro-stepping
By default, the X-Controller board is set to 8x microstepping for X & Y axes and to 2x microstepping for the Z axis.

DIP switches:
- 8x microstepping with switches 1, 3, and 4 in the 'ON' position.
- 2x microstepping with only switches 2 and 4 'ON'.

You can use these values later in the _Oquam_ `config.json` (see the related [section](registry_setup.md#configure-the-plant-imager-controller)), but this will limit the precision of the axes.

We would thus strongly recommend to **change them to 16x microstepping** by setting the DIP switches 1, 2 & 4 in the 'ON' position and 3 to 'OFF'.


## Troubleshooting

### Parts

If you burn the X-Controller main board, you can buy a new one [here](https://www.inventables.com/technologies/x-controller-main-board).