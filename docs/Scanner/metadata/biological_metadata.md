Biological Metadata
===================
Biological metadata are informative of the biological object and its growth conditions.

## Definitions

Here is a list of biological metadata and their definition:

* **species**: the species of the biological object analysed, _eg_: "Arabidopsis thaliana";
* **seed stock**: an identifier of the seed stock used, _eg_: "Col-0", "186.AV.L1", ...;
* **plant id**: an identifier for the plant, _eg_: "GT1";
* **growth environment**: , _eg_: "Lyon - Indoor";
* **growth conditions**: growth condition used, _eg_: "LD", "SD", "LD+SD";
* **treatment**: specific treatment applied, if any, _eg_: "Auxin 1mM";
* **DAG**: Days After Germination or age of the plant in days, _eg_: 40;
* **sample**: part of the plant used, if any, _eg_: "main stem"; 
* **experiment id**: an identifier for the experiment, _eg_: "dry plant";
* **dataset id**: the Omero dataset identifier for the biological datase, _eg_: 12;


## Configuration

!!!todo
    How is it defined in a TOML configuration file ?


## Database location
Located in `metadata/metadata.json` and found under the `object` top level section, it contains biologically relevant information such as the studied species, its age and growth conditions.
This information are not restricted in their format but should contain a minimal set of entries.

!!! todo
    Defines the minimal set of entries! Use the MIAPPE standard?


## JSON example
Example of a `metadata/metadata.json` file for biological metadata:
```json
    "object": {
        "age": "62d",
        "culture": "LD",
        "environment": "Lyon indoor",
        "experiment_id": "living plant",
        "object": "plant",
        "plant_id": "Col0_26_10_2018_B",
        "sample": "main stem",
        "species": "Arabidopsis thaliana",
        "stock": "186AV.L1",
        "treatment": "none"
    }
```
