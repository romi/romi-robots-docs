Install ROMI software for the plants scanner
============================================

To follows this guide you should have a `conda` or a Python `venv`, see [here](create_env.md).

For the sake of clarity the environment will be called `plant_scanner`.


## Install ROMI packages with `pip`:

Activate your `plant_scanner` environment!
```bash
conda activate plant_scanner
```

!!! note
    Since this is still under development, the packages are installed in "editable mode" with the `-e` option.

### Install `romiscanner` sources:
To pilot the hardware you have to install the `romiscanner`package:
```bash
python3 -m pip install -e git+https://github.com/romi/romiscanner.git@dev
```

### Install `romiscan` sources:
To start "acquisition jobs", you have to install the `romiscan` package:
```bash
python3 -m pip install -e git+https://github.com/romi/romiscan.git@dev
```

### Install `romidata` sources:
Since we will need an active database to export the acquisitions, you have to install the `romidata` package:
```bash
python3 -m pip install -e git+https://github.com/romi/romidata.git@dev
```

## Example database
To quickly create an example DB you can use:
```bash
wget https://db.romi-project.eu/models/test_db.tar.gz
tar -xf test_db.tar.gz
```
This will create a `integration_tests` folder with a ready to use test database. 

You should now be ready to performs "plant acquisitions" following the [dedicated](../tutorials/reconstruct_scan.md) user guide.


## Troubleshooting

### Serial access denied
Look [here](troubleshooting.md#serial-access-denied) if you can not communicate with the scanner using usb.
