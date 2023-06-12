# Power

## Power

The power circuit has a main switch that avoids battery discharging during transportation or storing.
Battery voltage is fed directly, a DC/DC voltage converter provides low voltage to the logic electronics subsystem.
The battery voltage is feeding the camera module allowing high voltage motors.
Both battery terminals are directly exposed to the charger station allowing the charge process during rest periods.

![](/assets/images/farmersDashboard/Power_Diagram.png)

### Power distribution PCB

![](/assets/images/farmersDashboard/cablebot_power_components.png)

## DC/DC switching regulator

![](/assets/images/farmersDashboard/dc-dc.png){: style="width:100px"}

To provide low voltage (5v) the **[OKI-78SR-5/1.5-W36E-C](https://www.mouser.es/datasheet/2/281/oki-78sr-e-1115659.pdf)** DC/DC switching regulator is used.
It can provide 1.5A @ 5v and can stand inputs as high as 36v input.
With this regulator we feed all the electronics contained in the carrier unit the camera module electronics use the same component to provide low voltage to its own electronics.

### Battery module

![](/assets/images/farmersDashboard/despiece_battery_module.png)

