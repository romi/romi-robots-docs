Data storage
============

# Getting started

## Installation

Install from github using pip:

romidata:
```
pip install git+ssh://git@github.com/romi/data-storage.git#dev
```


## Basic working example

Assume you have a list of images you want to create a database,
and add some images to a scan in this database.

First create the folder for the database and add the ``romidb`` marker to it:

```
mkdir mydb
touch mydb/romidb
```

Then in you python code:

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


db = FSDB("mydb")
db.connect() # Locks the database and allows access
scan = db.create_scan("myscan")
fileset = scan.create_fileset("images")

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
