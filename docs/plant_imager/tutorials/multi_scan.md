# Performs multiples scans of the same object while changing an acquisition parameter

When performing tests and evaluations, you would like to acquire the same object multiple times with while changing one parameter to assess its importance of find the optimal one.
Normally this would require multiple calls to the `romi_run_task` CLI with a specific configuration file and a specific dataset name.

In our experience, this is prone to errors!

So we developed a CLI for this case named `multi_scan`. Hereafter we will provide a usage example.

## CLI overview
```
usage: multi_scan [-h] [--type {int,str,float}] [--task TASK] [--config CONFIG] [--module MODULE]
                  [--log-level {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                  database_path dataset_fmt param value [value ...]

Performs multiple calls to a ROMI task changing the value of a single parameter.

positional arguments:
  database_path         Path to the database (directory) to populate with the acquisitions.
  dataset_fmt           Generic name to give to the datasets, should contain a `{}` to indicate the
                        parameter position.
  param                 Name of the parameter to change from the loaded `config`.
  value                 Value(s) of the parameter to use.

optional arguments:
  -h, --help            show this help message and exit
  --type {int,str,float}
                        To specify the type of the parameter value(s), defaults to 'int'.

ROMI arguments:
  --task TASK           Name of the task to perform, `Scan` by default.
  --config CONFIG       Pipeline configuration file or directory (JSON or TOML). If a file, read the
                        configuration from it. If a directory, read & concatenate all configuration
                        files in it
  --module MODULE       Library and module of the task. Use it if not available or different than
                        defined in `romitask.modules.MODULES`.
  --log-level {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Level of message logging, defaults to 'INFO'.
```

## Test the effect of the number of images on reconstruction
To test the effect of the number of images on the quality of the reconstructed 3D point-cloud, you want to acquire the same object multiple times while changing the number of views.

You can do that simply with:
```shell
multi_scan '/data/romi_db/test_nb_views/' 'my_plant_A_{}' ScanPath.kwargs.n_points 10 20 30 36 40 60 72 --config '/data/configs/scan.toml'
```

This assumes:

* `/data/romi_db/test_nb_views/` to be the location of your database
* `my_plant_A_{}` to be the name of the dataset to create, the `{}` indicate where to add the number of views as character
* `ScanPath.kwargs.n_points` is the `section.parameter` to modify
* `10 20 30 36 40 60 72` to be the list of number of view to acquire
* `/data/configs/scan.toml` to be the default scanning config to use


This will call the `romi_run_task` command with the appropriate arguments.

This should generate the following file structure:
```
/data/romi_db/test_nb_views/
├── my_plant_A_10/
│         ├── files.json
│         ├── images/
│         ├── metadata/
│         └── scan.toml
├── my_plant_A_20/
│         ├── files.json
│         ├── images/
│         ├── metadata/
│         └── scan.toml
├── my_plant_A_30/
│         ├── files.json
│         ├── images/
│         ├── metadata/
│         └── scan.toml
├── my_plant_A_36/
│         ├── files.json
│         ├── images/
│         ├── metadata/
│         └── scan.toml
├── my_plant_A_40/
│         ├── files.json
│         ├── images/
│         ├── metadata/
│         └── scan.toml
├── my_plant_A_60/
│         ├── files.json
│         ├── images/
│         ├── metadata/
│         └── scan.toml
├── my_plant_A_72/
│         ├── files.json
│         ├── images/
│         ├── metadata/
│         └── scan.toml
└── romidb
```