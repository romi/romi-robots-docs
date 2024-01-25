# Docker for colmap

!!! warning
    This documentation talk about a docker image with the tag 3.7 when the actual colmap version in `roboticsmicrofarms/colmap:3.7` is colmap3.8.
    Clarification is required!!!

As we want the possibility to choose the Python version we use, for example 3.8, and the provided docker image are based on **Ubuntu 18.04** that ship Python 3.6 & 3.7, we need to create our own `Dockerfile`.

This has been done in `docker/colmap/Dockerfile` with:

  - Python 3.8
  - Colmap 3.7

## Build the docker image

To build the docker image, use the `Dockerfile` in `docker/colmap/`:

```shell
image_name="roboticsmicrofarms/colmap"
image_version="3.7"
docker build -t="$image_name:$image_version" docker/colmap/.
docker tag "$image_name:$image_version" "$image_name:latest"
```

## Test the container

Let's test the image we just created!

### Start a container

You can start by creating a running container with:

```shell
docker run -it --gpus all \
  -v /tmp/integration_tests/2019-02-01_10-56-33/:/tmp/ \
  roboticsmicrofarms/colmap:3.7
```

Try to call the colmap executable to get the version number with:

```shell
colmap -v
```

As we also installed Python, try to call it after activating the `venv` with:
```shell
. /venv/bin/activate
python -V
```

### Get a test dataset

To further test the built image, let's try to use colmap on a typical set of data.
If you do not have your own dataset, we provide a test dataset that you can download (to the temporary folder) as follows:

```shell
cd /tmp
wget https://db.romi-project.eu/models/test_db.tar.gz
tar -xf test_db.tar.gz
```

### Extract images poses

We use the "poses" (camera locations) provided in the images' metadata (JSON file associated to each images) by the plant-imager to create a `poses.txt` file containing each image coordinates:
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
    except KeyError:
        p = jdict['pose']  # backward compatibility, should work for provided test dataset
    s = '%s %d %d %d\n' % (file.split('.')[0] + ".jpg", p[0], p[1], p[2])
    posefile.write(s)

posefile.close()
```

### Test colmap tools

You can test that the colmap tools are working properly by calling them as follows:


=== "Colmap3.8"

    With docker image `roboticsmicrofarms/colmap:3.7` (COLMAP 3.8 -- Commit 31df46c on 2022-03-05 with CUDA):
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

=== "Colmap3.9"

    With docker image `colmap/colmap:20231022.10` (COLMAP 3.9 -- Commit a7b50e4d on 2023-10-22 with CUDA):
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


### Test geometric pipeline

If you have `plant-3d-vision` installed on your machine, you can further test the colmap image with the reconstruction pipelines using our test scripts and datasets.

#### Test it on real data

```shell
export COLMAP_EXE="roboticsmicrofarms/colmap"
./tests/check_geom_pipe.sh --tmp
```

#### Test it on virtual data

```shell
export COLMAP_EXE="roboticsmicrofarms/colmap"
./tests/check_geom_pipe.sh --tmp --virtual
```

#### Test it on your (real) data

```shell
export COLMAP_EXE="roboticsmicrofarms/colmap"
./tests/check_geom_pipe.sh --tmp --database /path/to/my/dataset
```


## Upload the built image
Once you have checked the obtained image leads to functional containers, you can upload the image to docker hub!

Start by login in to docker hub with:
```shell
docker login
```

Then you can upload with:
```shell
docker push "$image_name"
```