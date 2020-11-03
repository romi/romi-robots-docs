# Power

The power circuit has a main switch that avoids battery discharging during transportation or storing. Battery voltage is feeded directly in to the motor and measured trough a voltage divider, a DC/DC voltage converter provides low voltage to the logic electronics subsystem. Both voltages are exposed to the camera module allowing high voltage motors and avoiding the need of duplicated converters. Both battery terminals are directly exposed to the charger station allowing the carge process during rest periods.

![](/assets/images/farmersDashboard/cablebot-power.png)

## DC/DC switching regulator

![](/assets/images/farmersDashboard/dc-dc.png){: style="width:100px"}

To provide low voltage (5v) the **[OKI-78SR-5/1.5-W36E-C](https://www.mouser.es/datasheet/2/281/oki-78sr-e-1115659.pdf)** DC/DC switching regulator is used. It can provide 1.5A @ 5v and can stand inputs as high as 36v input. With this regulator we feed all the electronics contained in the carrier unit and  if needed provide power to the camera module.

