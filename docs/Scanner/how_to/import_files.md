How-to import files in ROMI database
====================================

## Importing external images as a dataset
In order to be able to use external images, *i.e.* images that were not acquired with the software & hardaware developed by ROMI, we provides tools to import them as a *scan dataset* in the ROMI databse.
 
One example could be a set of pictures (of a plant) acquired with your phone that you would like to reconstruct and maybe analyse with our softwares.

To do so, you may use the `romi_import_folder` or `romi_import_file` executables from `romidata`.

For example, you have a set of 10 RGB pictures named `img_00*.jpg` in a folder `my_plant/` that you would like to import as `outdoor_plant_1` in a romi database located under `/data/romi/db`.

First you have to move the pictures to an `ìmages` sub-directory & create a `metadata.json` describing the object under study:
```bash
cd my_plant
mkdir images
mv *.jpg images/.
touch metadata.json
```
An example of a `metadata.json`:
```json
{
    "object": {
        "age": "N/A",
        "culture": "N/A",
        "environment": "outdoor",
        "experiment_id": "romi demo outdoor plant",
        "object": "plant",
        "plant_id": "Chirsuta_1",
        "sample": "whole plant",
        "species": "Cardamine hirsuta",
        "stock": "WT",
        "treatment": "none"
    }
}
```

To summarize you now should have the following folder structure:
```
my_plant/
├── images/
│   ├── img_001.jpg
│   ├── [...]
│   └── img_010.jpg
└── metadata.json
```

Then you can performs the 'import to the database' operation with `romi_import_folder`:
```bash
romi_import_folder my_plant/ìmages/ /data/romi/db/outdoor_plant_1 --metadata my_plant/metadata.json
```

That's it! Your manual acquisition is ready to be used by the `romi_run_task` tool for reconstruction.