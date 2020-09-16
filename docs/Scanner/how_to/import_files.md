How-to import files in ROMI database
====================================

## Importing external images as a dataset
In order to be able to use external images, *i.e.* images that were not acquired with the software & hardaware developed by ROMI, we provides tools to import them as a *scan dataset* in the ROMI databse.
 
One example could be a set of pictures (of a plant) acquired with your phone that you would like to reconstruct and maybe analyse with our softwares.

To do so, you may use the `romi_import_folder` or `romi_import_file` executables from `romidata`.

For example, if you have a set of 10 RGB pictures named `img_00*.jpg` in a folder `~/images/my_plant/` that you would like to import as `outdoor_plant_1` in a database located under `/data/romi/db`:
```bash
romi_import_folder ~/images/my_plant/ /data/romi/db/outdoor_plant_1
```

You may also provides a JSON file containing metadata (such as the plant species, its GPS location, ...) by adding `--metadata my_plan.json` to the previous command.