# Configure the ROMI devices

We now need to configure the devices.

## Configure the ROMI camera(s)

1. Power the _Plant Imager controller_ (RPi 4)
2. Power the _X-Carve_, this should also power the _romi-camera(s)_ (RPi Z W)
3. Plug the USB of the _X-Controller_ to the _Plant Imager controller_ (RPi 4)
4. In a terminal (RPi 4):
    ```shell
    cd ~romi-rover-build-and-test/
    ./build/bin/rcdiscover tests-hardware/20-plant-imager/config.json
    ./build/bin/rcom-registry
    ```

!!! note
    The _Plant Imager controller_ should start the AP at boot.
    The _romi-camera(s)_ should automatically connect to the AP.

## Configure the Plant Imager controller
We have to define the `config.json` to use with _Oquam_.


## Tune the camera optics

```shell
cd ~romi-rover-build-and-test/
firefox applications/romi-monitor/camera.html & #check the camera topic name and the registry IP
cd ~plant-imager/
python3 /preview/preview.py --registry IP-of-the-registry
romi_run_task --config config/hardware_scan_v3.toml Scan ~/romi_db/dir-name/
```