# Colmap

## Build the docker image

```shell
docker build -t="roboticsmicrofarms/colmap:3.7" docker/colmap/.
```

## Test the container

### Get a test dataset

```shell
cd /tmp
wget https://db.romi-project.eu/models/test_db.tar.gz
tar -xf test_db.tar.gz
```

### Start a container

```shell
docker run -it --gpus all \
  -v /tmp/integration_tests/2019-02-01_10-56-33/:/tmp/ \
  roboticsmicrofarms/colmap:3.7
```

### Extract images poses

```python
import os
import json

posefile = open(f"/tmp/poses.txt", mode='w')
# - Try to get the pose from each file metadata:
for i, file in enumerate(sorted(os.listdir("/tmp/metadata/images"))):
    with open(f"/tmp/metadata/images/{file}", mode='r') as f:
        jdict = json.load(f)
    # print(jdict)
    try:
        p = jdict['approximate_pose']
    except:
        p = jdict['pose']
    s = '%s %d %d %d\n' % (file.split('.')[0] + ".jpg", p[0], p[1], p[2])
    posefile.write(s)

posefile.close()
```

### Test colmap tools

```shell
DATASET_PATH=/tmp

colmap feature_extractor \
    --database_path $DATASET_PATH/database.db \
    --image_path $DATASET_PATH/images

colmap exhaustive_matcher \
    --database_path $DATASET_PATH/database.db

mkdir $DATASET_PATH/sparse

colmap mapper \
    --database_path $DATASET_PATH/database.db \
    --image_path $DATASET_PATH/images \
    --output_path $DATASET_PATH/sparse

colmap model_aligner \
    --ref_images_path $DATASET_PATH/poses.txt \
    --input_path $DATASET_PATH/sparse/0 \
    --output_path $DATASET_PATH/sparse/0 \
    --ref_is_gps 0 \
    --robust_alignment_max_error 10

colmap model_converter \
    --input_path $DATASET_PATH/sparse/0 \
    --output_path $DATASET_PATH/sparse/0/sparse.ply \
    --output_type PLY

mkdir $DATASET_PATH/dense

colmap image_undistorter \
    --image_path $DATASET_PATH/images \
    --input_path $DATASET_PATH/sparse/0 \
    --output_path $DATASET_PATH/dense \
    --output_type COLMAP \
    --max_image_size 2000

colmap patch_match_stereo \
    --workspace_path $DATASET_PATH/dense \
    --workspace_format COLMAP \
    --PatchMatchStereo.geom_consistency true

colmap stereo_fusion \
    --workspace_path $DATASET_PATH/dense \
    --workspace_format COLMAP \
    --input_type geometric \
    --output_path $DATASET_PATH/dense/fused.ply
```
