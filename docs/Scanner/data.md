This page describe how to use the romi package `data-storage` accessible [here](https://github.com/romi/data-storage).

A shared example datasets is accessible [here](https://db.romi-project.eu/models/test_db.tar.gz).

## Getting started

### Installation

!!! warning
    If you intend to contribute to the development of `data-storage` or want to be able to edit the code and test your changes, you should choose _editable mode_.

#### Non-editable mode
Install from github using `pip`:
```
pip install git+ssh://git@github.com/romi/data-storage.git#dev
```
!!! note
    This uses `ssh` and thus requires to be registered as part of the project and to deploy ssh keys.

#### Editable mode
Clone from github and install using `pip`:
```
git clone https://github.com/romi/data-storage.git
cd data-storage
pip install -e .
```

### Basic working example

Assume you have a list of images you want to create a database, and add some images to a scan in this database.

#### 1 - Initialize database
First create the folder for the database and add the ``romidb`` marker to it:
```python
from os.path import join
from tempfile import mkdtemp
mydb = mkdtemp(prefix='romidb_')
open(join(mydb, 'romidb'), 'w').close()
```

Npw you can initialize a ROMI `FSDB` database object:
```python
from romidata.fsdb import FSDB
db = FSDB(mydb)
db.connect() # Locks the database and allows access
```


#### 2 - Create a new datasets
To create a new datasets, here named `myscan_001`, do:
```python
scan = db.create_scan("myscan_001")
```
To add _scan metadata_ (_eg._ camera settings, biological metadata, hardware metadata...), do:
```python
scan.set_metadata({"scanner": {"harware": 'test'}})
```
This will results in several changes in the local database:

1. Add a `myscan_001` sub-folder in the database root folder;
2. Add a `metadata` sub-folder in `myscan_001` and a `metadata.json` gathering the given _scan metadata_.


#### 3 - Add images as new fileset

0. OPTIONAL - create a list of RGB images
If you do not have a scan datasets available, either download a shared datasets [here](https://db.romi-project.eu/models/test_db.tar.gz) or generate a list of images as follows:
```python
import numpy as np
# Generate random noise images
n_images = 99
imgs = []
for i in range(n_images):
    img = 256 * np.random.rand(256, 256, 3)
    img = np.array(img, dtype=np.uint8)
    imgs.append(img)
```

1. Create a new `fileset`:
```python
fileset = scan.create_fileset("images")
```

2. Add the images to the fileset:
Load the file list (or skip if you generated random images):
```python
from os import listdir
imgs = listdir("</path/to/my/scan/images>")
```
Then loop the images list and add them to the `fileset`, optionally attach some metadata to each image:
```python
from romidata import io
for i, img in enumerate(imgs):
    file = fileset.create_file("%i"%i)
    io.write_image(file, img)
    file.set_metadata("key", "%i"%i)
```

This will results in several changes in the local database:

1. Reference the image by its file name by adding an entry in `files.json`;
2. Write a `scan_img_1.jpeg` image in the `images` sub-folder of the scan `"myscan"`.
3. Add an `images` sub-folder in the `metadata` sub-folder, and JSON files with the image `id` as name to store the _image metadata_.


#### 4 - Access image files in a fileset
To access the image files in a fileset (in a datasets, itself in an existing and accessible database), procced as follows:

```python
from romidata.fsdb import FSDB
db = FSDB(mydb)
db.connect() # Locks the database and allows access

scan = db.get_scan("myscan")
fileset = scan.get_fileset("images")
for f in fileset.get_files():
    im = io.read_image(f) # reads image data
    print(f.get_metadata("key")) # i


db.disconnect()
```

### Examples

```python
from romidata.fsdb import FSDB
from romidata import io
import numpy as np

# Generate random noise images
n_images = 100
imgs = []
for i in range(n_images):
    img = 256*np.random.rand(256, 256, 3)
    img = np.array(img, dtype=np.uint8)
    imgs.append(img)

from os import listdir
from os.path import join
from tempfile import mkdtemp
# Create a temporary DB folder:
mydb = mkdtemp(prefix='romidb_')
# Create the `romidb` file in previously created temporary DB folder:
open(join(mydb, 'romidb'), 'w').close()
listdir(mydb)

# Connect to the DB:
db = FSDB(mydb)
db.connect() # Locks the database and allows access

# Add a scan datasets to the DB:
scan = db.create_scan("myscan_001")
listdir(mydb)
# Add metadata to a scan datasets:
scan.set_metadata({"scanner": {"harware": 'test'}})
listdir(join(mydb, "myscan_001"))
listdir(join(mydb, "myscan_001", "metadata"))

fileset = scan.create_fileset("images")
listdir(join(mydb, "myscan_001"))

for i, img in enumerate(imgs):
    file = fileset.create_file("%i"%i)
    io.write_image(file, img)
    file.set_metadata("key", "%i"%i) # Add some metadata

# read files in the fileset:
scan = db.get_scan("myscan")
fileset = scan.get_fileset("images")
for f in fileset.get_files():
    im = io.read_image(f) # reads image data
    print(f.get_metadata("key")) # i

db.disconnect()
```


## Folders structure

### Database root folder
A _root database_ folder is defined, _eg._ `mydb`.
Inside this folder we need to defines (add) the ``romidb`` marker so it may be used by `fsdb`.
We may also find the `lock` file used to limit the access to the database to only one user. 

Note that this part is manual, you have to create these manually:
```bash
mkdir mydb
touch mydb/romidb
```

Once you have created this root folder and file, you can initialize a ROMI `FSDB` database object:
```python
from romidata.fsdb import FSDB
db = FSDB("mydb")
db.connect()
```
The method `FSDB.connect()` locks the database with a `lock` file at root directory and allows access.
You may remove the `lock` file if you are sure no one else is using the database. 

Within this _root database_ folder you will find other folders corresponding to _datasets_.

### Datasets folders
At the next level, we find the _datasets_ folder(s), _eg._ named `myscan_001`.
Their names must be uniques and you create them as follow:
```python
scan = db.create_scan("myscan_001")
```
If you add _scan metadata_ (_eg._ camera settings, biological metadata, hardware metadata...) with `scan.set_metadata()`, you get another folder `metadata` with a `metadata.json` file.

We now have the following tree structure:
```
mydb/
├── myscan_001/
│   ├── metadata/
│   │   └── metadata.json
└── romidb
```


### Images folders
Inside `myscan_001/`, we find the datasets or _fileset_ in `romidb` terminology.
In the case of the "plant scanner", this is a list of RGB image files acquired by a camera moving around the plant.
To store the datasets, we thus name the created _fileset_ "images":
```python
fileset = scan.create_fileset("images")
```
Inside this `images/` folder will reside the images added to the database.
At the same time you added images with **REF_TO_TUTO**, you created an entry in a JSON file referencing the files.
If you added metadata along with the files (_eg._ camera poses, jpeg metadata...) it should be referenced in `metadata/images/` _eg._ `metadata/images/<scan_img_01>.json`.
```
mydb/
├── myscan_001/
│   ├── files.json
│   ├── images/
│   │   ├── scan_img_01.jpg
│   │   ├── scan_img_02.jpg
│   │   ├── [...]
│   │   └── scan_img_99.jpg
│   ├── metadata/
│   │   ├── images
│   │   │   ├── scan_img_01.json
│   │   │   ├── scan_img_02.json
│   │   ├── [...]
│   │   │   └── scan_img_99.json
│   │   └── metadata.json
└── romidb
```

### Example
```
mydb/
├── myscan_001/
│   ├── AnglesAndInternodes_1_0_2_0_0_1_dd8d67653a
│   │   └── AnglesAndInternodes.json
│   ├── Colmap_True____feature_extrac_3bbfcb1413
│   │   ├── cameras.json
│   │   ├── images.json
│   │   ├── points3d.json
│   │   └── sparse.ply
│   ├── CurveSkeleton_out__TriangleMesh_6a92751c20
│   │   └── CurveSkeleton.json
│   ├── files.json
│   ├── images
│   │   ├── pict20190201_110110_0.jpg
│   │   ├── [...]
│   │   └── pict20190201_111209_0.jpg
│   ├── Masks_True_5_out_9adb9db801
│   │   ├── pict20190201_110110_0.jpg
│   │   ├── [...]
│   │   └── pict20190201_111209_0.jpg
│   ├── measures.csv
│   ├── metadata
│   │   ├── AnglesAndInternodes_1_0_2_0_0_1_dd8d67653a.json
│   │   ├── Colmap_True____feature_extrac_3bbfcb1413.json
│   │   ├── CurveSkeleton_out__TriangleMesh_6a92751c20.json
│   │   ├── images
│   │   │   ├── pict20190201_110110_0.json
│   │   ├── [...]
│   │   │   └── pict20190201_111209_0.json
│   │   ├── images.json
│   │   ├── Masks_True_5_out_9adb9db801
│   │   │   ├── pict20190201_110110_0.json
│   │   ├── [...]
│   │   │   └── pict20190201_111209_0.json
│   │   ├── Masks_True_5_out_e90d1804eb.json
│   │   ├── metadata.json
│   │   ├── PointCloud_1_0_1_0_False_9ab5a15d9b
│   │   │   └── PointCloud.json
│   │   ├── PointCloud_1_0_1_0_False_9ab5a15d9b.json
│   │   ├── PointCloud__200_0_1_0_False_4ce2e46446.json
│   │   ├── TreeGraph_out__CurveSkeleton_5dca9a2821.json
│   │   ├── TriangleMesh_out__PointCloud_80dc94ac81.json
│   │   ├── Undistorted_out_____fb3e3fa0ff
│   │   │   ├── pict20190201_110110_0.json
│   │   ├── [...]
│   │   │   └── pict20190201_111209_0.json
│   │   ├── Undistorted_out_____fb3e3fa0ff.json
│   │   ├── Voxels_False____False_567dc7f48b
│   │   │   └── Voxels.json
│   │   ├── Voxels_False____False_567dc7f48b.json
│   │   ├── Voxels_False____True_af037e876e.json
│   │   └── Voxels_False____True_cd9a5ff06b.json
│   ├── pipeline.toml
│   ├── PointCloud_1_0_1_0_False_9ab5a15d9b
│   │   └── PointCloud.ply
│   ├── TreeGraph_out__CurveSkeleton_5dca9a2821
│   │   └── TreeGraph.p
│   ├── TriangleMesh_out__PointCloud_80dc94ac81
│   │   └── TriangleMesh.ply
│   └── Voxels_False____False_567dc7f48b
│       └── Voxels.npz
├── colmap_log.txt
├── lock
└── romidb
```