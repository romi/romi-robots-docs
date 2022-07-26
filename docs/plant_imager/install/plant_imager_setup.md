Install ROMI software for the plant imager
============================================

To follows this guide you should have a `conda` or a Python `venv`, see [here](create_env.md).

For the sake of clarity the environment will be called `plant_imager`.

## Install ROMI packages with `pip`:

Activate your `plant_imager` environment!

```shell
conda activate plant_imager
```

!!! note
    Since this is still under development, the packages are installed in "editable mode" with the `-e` option.

### Install `plant-imager` sources:

To pilot the hardware you have to install the `plant-imager`package:

```shell
python3 -m pip install -e git+https://github.com/romi/plant-imager.git@dev
```

### Install `plant-3d-vision` sources:

To start "acquisition jobs", you have to install the `plant-3d-vision` package:

```shell
python3 -m pip install -e git+https://github.com/romi/plant3dvision.git@dev
```

### Install `plantdb` sources:

Since we will need an active database to export the acquisitions, you have to install the `plantdb` package:

```shell
python3 -m pip install -e git+https://github.com/romi/plantdb.git@dev
```

## Example database

To quickly create an example DB you can use:

```shell
wget https://db.romi-project.eu/models/test_db.tar.gz
tar -xf test_db.tar.gz
```

This will create a `integration_tests` folder with a ready to use test database.

You should now be ready to perform "plant acquisitions" following the [dedicated](../tutorials/reconstruct_scan.md) user guide.

## Troubleshooting

### Serial access denied

Look [here](../build_v2/troubleshooting.md#serial-access-denied) if you can not communicate with the scanner using usb.
