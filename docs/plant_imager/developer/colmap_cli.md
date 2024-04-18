# COLMAP CLI


## Feature extraction
Perform **feature extraction** for a set of images.

```shell
colmap feature_extractor -h
```
=== "Colmap3.8"

    ```
    COLMAP 3.8 (Commit 31df46c on 2022-03-05 with CUDA)
    
    Options can either be specified via command-line or by defining
    them in a .ini project file passed to `--project_path`.
    
      -h [ --help ] 
      --random_seed arg (=0)
      --log_to_stderr arg (=0)
      --log_level arg (=2)
      --project_path arg
      --database_path arg
      --image_path arg
      --camera_mode arg (=-1)
      --image_list_path arg
      --descriptor_normalization arg (=l1_root)
                                            {'l1_root', 'l2'}
      --ImageReader.mask_path arg
      --ImageReader.camera_model arg (=SIMPLE_RADIAL)
      --ImageReader.single_camera arg (=0)
      --ImageReader.single_camera_per_folder arg (=0)
      --ImageReader.single_camera_per_image arg (=0)
      --ImageReader.existing_camera_id arg (=-1)
      --ImageReader.camera_params arg
      --ImageReader.default_focal_length_factor arg (=1.2)
      --ImageReader.camera_mask_path arg
      --SiftExtraction.num_threads arg (=-1)
      --SiftExtraction.use_gpu arg (=1)
      --SiftExtraction.gpu_index arg (=-1)
      --SiftExtraction.max_image_size arg (=3200)
      --SiftExtraction.max_num_features arg (=8192)
      --SiftExtraction.first_octave arg (=-1)
      --SiftExtraction.num_octaves arg (=4)
      --SiftExtraction.octave_resolution arg (=3)
      --SiftExtraction.peak_threshold arg (=0.0066666666666666671)
      --SiftExtraction.edge_threshold arg (=10)
      --SiftExtraction.estimate_affine_shape arg (=0)
      --SiftExtraction.max_num_orientations arg (=2)
      --SiftExtraction.upright arg (=0)
      --SiftExtraction.domain_size_pooling arg (=0)
      --SiftExtraction.dsp_min_scale arg (=0.16666666666666666)
      --SiftExtraction.dsp_max_scale arg (=3)
      --SiftExtraction.dsp_num_scales arg (=10)
    ```

=== "Colmap3.9"

    ```
    COLMAP 3.9 (Commit a7b50e4d on 2023-10-22 with CUDA)

    Options can either be specified via command-line or by defining
    them in a .ini project file passed to `--project_path`.
    
      -h [ --help ] 
      --random_seed arg (=0)
      --log_to_stderr arg (=0)
      --log_level arg (=2)
      --project_path arg
      --database_path arg
      --image_path arg
      --camera_mode arg (=-1)
      --image_list_path arg
      --descriptor_normalization arg (=l1_root)
                                            {'l1_root', 'l2'}
      --ImageReader.mask_path arg
      --ImageReader.camera_model arg (=SIMPLE_RADIAL)
      --ImageReader.single_camera arg (=0)
      --ImageReader.single_camera_per_folder arg (=0)
      --ImageReader.single_camera_per_image arg (=0)
      --ImageReader.existing_camera_id arg (=-1)
      --ImageReader.camera_params arg
      --ImageReader.default_focal_length_factor arg (=1.2)
      --ImageReader.camera_mask_path arg
      --SiftExtraction.num_threads arg (=-1)
      --SiftExtraction.use_gpu arg (=1)
      --SiftExtraction.gpu_index arg (=-1)
      --SiftExtraction.max_image_size arg (=3200)
      --SiftExtraction.max_num_features arg (=8192)
      --SiftExtraction.first_octave arg (=-1)
      --SiftExtraction.num_octaves arg (=4)
      --SiftExtraction.octave_resolution arg (=3)
      --SiftExtraction.peak_threshold arg (=0.0066666666666666671)
      --SiftExtraction.edge_threshold arg (=10)
      --SiftExtraction.estimate_affine_shape arg (=0)
      --SiftExtraction.max_num_orientations arg (=2)
      --SiftExtraction.upright arg (=0)
      --SiftExtraction.domain_size_pooling arg (=0)
      --SiftExtraction.dsp_min_scale arg (=0.16666666666666666)
      --SiftExtraction.dsp_max_scale arg (=3)
      --SiftExtraction.dsp_num_scales arg (=10)
    ```

## Matchers
Perform **feature matching** after performing feature extraction.

### Exhaustive matcher
If the number of images in your dataset is relatively low (up to several hundreds), this matching mode should be fast enough and leads to the best reconstruction results.
Here, every image is matched against every other image, while the block size determines how many images are loaded from disk into memory at the same time.

```shell
colmap exhaustive_matcher -h
```

=== "Colmap3.8"

    ```
    COLMAP 3.8 (Commit 31df46c on 2022-03-05 with CUDA)
    
    Options can either be specified via command-line or by defining
    them in a .ini project file passed to `--project_path`.
    
      -h [ --help ] 
      --random_seed arg (=0)
      --log_to_stderr arg (=0)
      --log_level arg (=2)
      --project_path arg
      --database_path arg
      --SiftMatching.num_threads arg (=-1)
      --SiftMatching.use_gpu arg (=1)
      --SiftMatching.gpu_index arg (=-1)
      --SiftMatching.max_ratio arg (=0.80000000000000004)
      --SiftMatching.max_distance arg (=0.69999999999999996)
      --SiftMatching.cross_check arg (=1)
      --SiftMatching.max_error arg (=4)
      --SiftMatching.max_num_matches arg (=32768)
      --SiftMatching.confidence arg (=0.999)
      --SiftMatching.max_num_trials arg (=10000)
      --SiftMatching.min_inlier_ratio arg (=0.25)
      --SiftMatching.min_num_inliers arg (=15)
      --SiftMatching.multiple_models arg (=0)
      --SiftMatching.guided_matching arg (=0)
      --SiftMatching.planar_scene arg (=0)
      --ExhaustiveMatching.block_size arg (=50)
    ```

=== "Colmap3.9"

    ```
    COLMAP 3.9 (Commit a7b50e4d on 2023-10-22 with CUDA)
    
    Options can either be specified via command-line or by defining
    them in a .ini project file passed to `--project_path`.
    
      -h [ --help ] 
      --random_seed arg (=0)
      --log_to_stderr arg (=0)
      --log_level arg (=2)
      --project_path arg
      --database_path arg
      --SiftMatching.num_threads arg (=-1)
      --SiftMatching.use_gpu arg (=1)
      --SiftMatching.gpu_index arg (=-1)
      --SiftMatching.max_ratio arg (=0.80000000000000004)
      --SiftMatching.max_distance arg (=0.69999999999999996)
      --SiftMatching.cross_check arg (=1)
      --SiftMatching.guided_matching arg (=0)
      --SiftMatching.max_num_matches arg (=32768)
      --TwoViewGeometry.min_num_inliers arg (=15)
      --TwoViewGeometry.multiple_models arg (=0)
      --TwoViewGeometry.compute_relative_pose arg (=0)
      --TwoViewGeometry.max_error arg (=4)
      --TwoViewGeometry.confidence arg (=0.999)
      --TwoViewGeometry.max_num_trials arg (=10000)
      --TwoViewGeometry.min_inlier_ratio arg (=0.25)
      --ExhaustiveMatching.block_size arg (=50)
    ```

### Sequential matcher
This mode is useful if the **images are acquired in sequential order**, e.g., by a video camera.
In this case, consecutive frames have visual overlap and there is no need to match all image pairs exhaustively.
Instead, consecutively captured images are matched against each other.
This matching mode has built-in loop detection based on a vocabulary tree, where every N-th image (`loop_detection_period`) is matched against its visually most similar images (`loop_detection_num_images`).
Note that image file names must be ordered sequentially (e.g., `image0001.jpg`, `image0002.jpg`, etc.).
The order in the database is not relevant, since the images are explicitly ordered according to their file names.
Note that loop detection requires a pre-trained vocabulary tree, that can be downloaded from [https://demuc.de/colmap/](https://demuc.de/colmap/).

```shell
colmap sequential_matcher -h
```

=== "Colmap3.8"

    ```
    COLMAP 3.8 (Commit 31df46c on 2022-03-05 with CUDA)
    
    Options can either be specified via command-line or by defining
    them in a .ini project file passed to `--project_path`.
    
      -h [ --help ] 
      --random_seed arg (=0)
      --log_to_stderr arg (=0)
      --log_level arg (=2)
      --project_path arg
      --database_path arg
      --SiftMatching.num_threads arg (=-1)
      --SiftMatching.use_gpu arg (=1)
      --SiftMatching.gpu_index arg (=-1)
      --SiftMatching.max_ratio arg (=0.80000000000000004)
      --SiftMatching.max_distance arg (=0.69999999999999996)
      --SiftMatching.cross_check arg (=1)
      --SiftMatching.max_error arg (=4)
      --SiftMatching.max_num_matches arg (=32768)
      --SiftMatching.confidence arg (=0.999)
      --SiftMatching.max_num_trials arg (=10000)
      --SiftMatching.min_inlier_ratio arg (=0.25)
      --SiftMatching.min_num_inliers arg (=15)
      --SiftMatching.multiple_models arg (=0)
      --SiftMatching.guided_matching arg (=0)
      --SiftMatching.planar_scene arg (=0)
      --SequentialMatching.overlap arg (=10)
      --SequentialMatching.quadratic_overlap arg (=1)
      --SequentialMatching.loop_detection arg (=0)
      --SequentialMatching.loop_detection_period arg (=10)
      --SequentialMatching.loop_detection_num_images arg (=50)
      --SequentialMatching.loop_detection_num_nearest_neighbors arg (=1)
      --SequentialMatching.loop_detection_num_checks arg (=256)
      --SequentialMatching.loop_detection_num_images_after_verification arg (=0)
      --SequentialMatching.loop_detection_max_num_features arg (=-1)
      --SequentialMatching.vocab_tree_path arg
    ```

=== "Colmap3.9"

    ```
    COLMAP 3.9 (Commit a7b50e4d on 2023-10-22 with CUDA)
    
    Options can either be specified via command-line or by defining
    them in a .ini project file passed to `--project_path`.
    
      -h [ --help ] 
      --random_seed arg (=0)
      --log_to_stderr arg (=0)
      --log_level arg (=2)
      --project_path arg
      --database_path arg
      --SiftMatching.num_threads arg (=-1)
      --SiftMatching.use_gpu arg (=1)
      --SiftMatching.gpu_index arg (=-1)
      --SiftMatching.max_ratio arg (=0.80000000000000004)
      --SiftMatching.max_distance arg (=0.69999999999999996)
      --SiftMatching.cross_check arg (=1)
      --SiftMatching.guided_matching arg (=0)
      --SiftMatching.max_num_matches arg (=32768)
      --TwoViewGeometry.min_num_inliers arg (=15)
      --TwoViewGeometry.multiple_models arg (=0)
      --TwoViewGeometry.compute_relative_pose arg (=0)
      --TwoViewGeometry.max_error arg (=4)
      --TwoViewGeometry.confidence arg (=0.999)
      --TwoViewGeometry.max_num_trials arg (=10000)
      --TwoViewGeometry.min_inlier_ratio arg (=0.25)
      --SequentialMatching.overlap arg (=10)
      --SequentialMatching.quadratic_overlap arg (=1)
      --SequentialMatching.loop_detection arg (=0)
      --SequentialMatching.loop_detection_period arg (=10)
      --SequentialMatching.loop_detection_num_images arg (=50)
      --SequentialMatching.loop_detection_num_nearest_neighbors arg (=1)
      --SequentialMatching.loop_detection_num_checks arg (=256)
      --SequentialMatching.loop_detection_num_images_after_verification arg (=0)
      --SequentialMatching.loop_detection_max_num_features arg (=-1)
      --SequentialMatching.vocab_tree_path arg
    ```

### Spatial matcher
This matching mode **matches every image against its spatial nearest neighbors**.
Spatial locations can be manually set in the database management.
By default, COLMAP also extracts GPS information from EXIF and uses it for spatial nearest neighbor search.
If accurate prior location information is available, this is the recommended matching mode.

```shell
colmap spatial_matcher -h
```

=== "Colmap3.8"

    ```
    COLMAP 3.8 (Commit 31df46c on 2022-03-05 with CUDA)
    
    Options can either be specified via command-line or by defining
    them in a .ini project file passed to `--project_path`.
    
      -h [ --help ] 
      --random_seed arg (=0)
      --log_to_stderr arg (=0)
      --log_level arg (=2)
      --project_path arg
      --database_path arg
      --SiftMatching.num_threads arg (=-1)
      --SiftMatching.use_gpu arg (=1)
      --SiftMatching.gpu_index arg (=-1)
      --SiftMatching.max_ratio arg (=0.80000000000000004)
      --SiftMatching.max_distance arg (=0.69999999999999996)
      --SiftMatching.cross_check arg (=1)
      --SiftMatching.max_error arg (=4)
      --SiftMatching.max_num_matches arg (=32768)
      --SiftMatching.confidence arg (=0.999)
      --SiftMatching.max_num_trials arg (=10000)
      --SiftMatching.min_inlier_ratio arg (=0.25)
      --SiftMatching.min_num_inliers arg (=15)
      --SiftMatching.multiple_models arg (=0)
      --SiftMatching.guided_matching arg (=0)
      --SiftMatching.planar_scene arg (=0)
      --SpatialMatching.is_gps arg (=1)
      --SpatialMatching.ignore_z arg (=1)
      --SpatialMatching.max_num_neighbors arg (=50)
      --SpatialMatching.max_distance arg (=100)
    ```

=== "Colmap3.9"

    ```
    COLMAP 3.9 (Commit a7b50e4d on 2023-10-22 with CUDA)
    
    Options can either be specified via command-line or by defining
    them in a .ini project file passed to `--project_path`.
    
      -h [ --help ] 
      --random_seed arg (=0)
      --log_to_stderr arg (=0)
      --log_level arg (=2)
      --project_path arg
      --database_path arg
      --SiftMatching.num_threads arg (=-1)
      --SiftMatching.use_gpu arg (=1)
      --SiftMatching.gpu_index arg (=-1)
      --SiftMatching.max_ratio arg (=0.80000000000000004)
      --SiftMatching.max_distance arg (=0.69999999999999996)
      --SiftMatching.cross_check arg (=1)
      --SiftMatching.guided_matching arg (=0)
      --SiftMatching.max_num_matches arg (=32768)
      --TwoViewGeometry.min_num_inliers arg (=15)
      --TwoViewGeometry.multiple_models arg (=0)
      --TwoViewGeometry.compute_relative_pose arg (=0)
      --TwoViewGeometry.max_error arg (=4)
      --TwoViewGeometry.confidence arg (=0.999)
      --TwoViewGeometry.max_num_trials arg (=10000)
      --TwoViewGeometry.min_inlier_ratio arg (=0.25)
      --SpatialMatching.is_gps arg (=1)
      --SpatialMatching.ignore_z arg (=1)
      --SpatialMatching.max_num_neighbors arg (=50)
      --SpatialMatching.max_distance arg (=100)
    ```

## Mapper
**Sparse 3D reconstruction / mapping of the dataset using SfM** after performing feature extraction and matching.
```shell
colmap mapper -h
```

=== "Colmap3.8"
    
    ```
    COLMAP 3.8 (Commit 31df46c on 2022-03-05 with CUDA)
    
    Options can either be specified via command-line or by defining
    them in a .ini project file passed to `--project_path`.
    
      -h [ --help ] 
      --random_seed arg (=0)
      --log_to_stderr arg (=0)
      --log_level arg (=2)
      --project_path arg
      --database_path arg
      --image_path arg
      --input_path arg
      --output_path arg
      --image_list_path arg
      --Mapper.min_num_matches arg (=15)
      --Mapper.ignore_watermarks arg (=0)
      --Mapper.multiple_models arg (=1)
      --Mapper.max_num_models arg (=50)
      --Mapper.max_model_overlap arg (=20)
      --Mapper.min_model_size arg (=10)
      --Mapper.init_image_id1 arg (=-1)
      --Mapper.init_image_id2 arg (=-1)
      --Mapper.init_num_trials arg (=200)
      --Mapper.extract_colors arg (=1)
      --Mapper.num_threads arg (=-1)
      --Mapper.min_focal_length_ratio arg (=0.10000000000000001)
      --Mapper.max_focal_length_ratio arg (=10)
      --Mapper.max_extra_param arg (=1)
      --Mapper.ba_refine_focal_length arg (=1)
      --Mapper.ba_refine_principal_point arg (=0)
      --Mapper.ba_refine_extra_params arg (=1)
      --Mapper.ba_min_num_residuals_for_multi_threading arg (=50000)
      --Mapper.ba_local_num_images arg (=6)
      --Mapper.ba_local_function_tolerance arg (=0)
      --Mapper.ba_local_max_num_iterations arg (=25)
      --Mapper.ba_global_use_pba arg (=0)
      --Mapper.ba_global_pba_gpu_index arg (=-1)
      --Mapper.ba_global_images_ratio arg (=1.1000000000000001)
      --Mapper.ba_global_points_ratio arg (=1.1000000000000001)
      --Mapper.ba_global_images_freq arg (=500)
      --Mapper.ba_global_points_freq arg (=250000)
      --Mapper.ba_global_function_tolerance arg (=0)
      --Mapper.ba_global_max_num_iterations arg (=50)
      --Mapper.ba_global_max_refinements arg (=5)
      --Mapper.ba_global_max_refinement_change arg (=0.00050000000000000001)
      --Mapper.ba_local_max_refinements arg (=2)
      --Mapper.ba_local_max_refinement_change arg (=0.001)
      --Mapper.snapshot_path arg
      --Mapper.snapshot_images_freq arg (=0)
      --Mapper.fix_existing_images arg (=0)
      --Mapper.init_min_num_inliers arg (=100)
      --Mapper.init_max_error arg (=4)
      --Mapper.init_max_forward_motion arg (=0.94999999999999996)
      --Mapper.init_min_tri_angle arg (=16)
      --Mapper.init_max_reg_trials arg (=2)
      --Mapper.abs_pose_max_error arg (=12)
      --Mapper.abs_pose_min_num_inliers arg (=30)
      --Mapper.abs_pose_min_inlier_ratio arg (=0.25)
      --Mapper.filter_max_reproj_error arg (=4)
      --Mapper.filter_min_tri_angle arg (=1.5)
      --Mapper.max_reg_trials arg (=3)
      --Mapper.local_ba_min_tri_angle arg (=6)
      --Mapper.tri_max_transitivity arg (=1)
      --Mapper.tri_create_max_angle_error arg (=2)
      --Mapper.tri_continue_max_angle_error arg (=2)
      --Mapper.tri_merge_max_reproj_error arg (=4)
      --Mapper.tri_complete_max_reproj_error arg (=4)
      --Mapper.tri_complete_max_transitivity arg (=5)
      --Mapper.tri_re_max_angle_error arg (=5)
      --Mapper.tri_re_min_ratio arg (=0.20000000000000001)
      --Mapper.tri_re_max_trials arg (=1)
      --Mapper.tri_min_angle arg (=1.5)
      --Mapper.tri_ignore_two_view_tracks arg (=1)
    ```

=== "Colmap3.9"

    ```
    COLMAP 3.9 (Commit a7b50e4d on 2023-10-22 with CUDA)
    
    Options can either be specified via command-line or by defining
    them in a .ini project file passed to `--project_path`.
    
      -h [ --help ] 
      --random_seed arg (=0)
      --log_to_stderr arg (=0)
      --log_level arg (=2)
      --project_path arg
      --database_path arg
      --image_path arg
      --input_path arg
      --output_path arg
      --image_list_path arg
      --Mapper.min_num_matches arg (=15)
      --Mapper.ignore_watermarks arg (=0)
      --Mapper.multiple_models arg (=1)
      --Mapper.max_num_models arg (=50)
      --Mapper.max_model_overlap arg (=20)
      --Mapper.min_model_size arg (=10)
      --Mapper.init_image_id1 arg (=-1)
      --Mapper.init_image_id2 arg (=-1)
      --Mapper.init_num_trials arg (=200)
      --Mapper.extract_colors arg (=1)
      --Mapper.num_threads arg (=-1)
      --Mapper.min_focal_length_ratio arg (=0.10000000000000001)
      --Mapper.max_focal_length_ratio arg (=10)
      --Mapper.max_extra_param arg (=1)
      --Mapper.ba_refine_focal_length arg (=1)
      --Mapper.ba_refine_principal_point arg (=0)
      --Mapper.ba_refine_extra_params arg (=1)
      --Mapper.ba_min_num_residuals_for_multi_threading arg (=50000)
      --Mapper.ba_local_num_images arg (=6)
      --Mapper.ba_local_function_tolerance arg (=0)
      --Mapper.ba_local_max_num_iterations arg (=25)
      --Mapper.ba_global_images_ratio arg (=1.1000000000000001)
      --Mapper.ba_global_points_ratio arg (=1.1000000000000001)
      --Mapper.ba_global_images_freq arg (=500)
      --Mapper.ba_global_points_freq arg (=250000)
      --Mapper.ba_global_function_tolerance arg (=0)
      --Mapper.ba_global_max_num_iterations arg (=50)
      --Mapper.ba_global_max_refinements arg (=5)
      --Mapper.ba_global_max_refinement_change arg (=0.00050000000000000001)
      --Mapper.ba_local_max_refinements arg (=2)
      --Mapper.ba_local_max_refinement_change arg (=0.001)
      --Mapper.snapshot_path arg
      --Mapper.snapshot_images_freq arg (=0)
      --Mapper.fix_existing_images arg (=0)
      --Mapper.init_min_num_inliers arg (=100)
      --Mapper.init_max_error arg (=4)
      --Mapper.init_max_forward_motion arg (=0.94999999999999996)
      --Mapper.init_min_tri_angle arg (=16)
      --Mapper.init_max_reg_trials arg (=2)
      --Mapper.abs_pose_max_error arg (=12)
      --Mapper.abs_pose_min_num_inliers arg (=30)
      --Mapper.abs_pose_min_inlier_ratio arg (=0.25)
      --Mapper.filter_max_reproj_error arg (=4)
      --Mapper.filter_min_tri_angle arg (=1.5)
      --Mapper.max_reg_trials arg (=3)
      --Mapper.local_ba_min_tri_angle arg (=6)
      --Mapper.tri_max_transitivity arg (=1)
      --Mapper.tri_create_max_angle_error arg (=2)
      --Mapper.tri_continue_max_angle_error arg (=2)
      --Mapper.tri_merge_max_reproj_error arg (=4)
      --Mapper.tri_complete_max_reproj_error arg (=4)
      --Mapper.tri_complete_max_transitivity arg (=5)
      --Mapper.tri_re_max_angle_error arg (=5)
      --Mapper.tri_re_min_ratio arg (=0.20000000000000001)
      --Mapper.tri_re_max_trials arg (=1)
      --Mapper.tri_min_angle arg (=1.5)
      --Mapper.tri_ignore_two_view_tracks arg (=1)
    ```


## Point triangulator
```shell
colmap point_triangulator -h
```

=== "Colmap3.8"

    ```
    COLMAP 3.8 (Commit 31df46c on 2022-03-05 with CUDA)
    
    Options can either be specified via command-line or by defining
    them in a .ini project file passed to `--project_path`.
    
      -h [ --help ] 
      --random_seed arg (=0)
      --log_to_stderr arg (=0)
      --log_level arg (=2)
      --project_path arg
      --database_path arg
      --image_path arg
      --input_path arg
      --output_path arg
      --clear_points arg (=0)               Whether to clear all existing points 
                                            and observations
      --Mapper.min_num_matches arg (=15)
      --Mapper.ignore_watermarks arg (=0)
      --Mapper.multiple_models arg (=1)
      --Mapper.max_num_models arg (=50)
      --Mapper.max_model_overlap arg (=20)
      --Mapper.min_model_size arg (=10)
      --Mapper.init_image_id1 arg (=-1)
      --Mapper.init_image_id2 arg (=-1)
      --Mapper.init_num_trials arg (=200)
      --Mapper.extract_colors arg (=1)
      --Mapper.num_threads arg (=-1)
      --Mapper.min_focal_length_ratio arg (=0.10000000000000001)
      --Mapper.max_focal_length_ratio arg (=10)
      --Mapper.max_extra_param arg (=1)
      --Mapper.ba_refine_focal_length arg (=1)
      --Mapper.ba_refine_principal_point arg (=0)
      --Mapper.ba_refine_extra_params arg (=1)
      --Mapper.ba_min_num_residuals_for_multi_threading arg (=50000)
      --Mapper.ba_local_num_images arg (=6)
      --Mapper.ba_local_function_tolerance arg (=0)
      --Mapper.ba_local_max_num_iterations arg (=25)
      --Mapper.ba_global_use_pba arg (=0)
      --Mapper.ba_global_pba_gpu_index arg (=-1)
      --Mapper.ba_global_images_ratio arg (=1.1000000000000001)
      --Mapper.ba_global_points_ratio arg (=1.1000000000000001)
      --Mapper.ba_global_images_freq arg (=500)
      --Mapper.ba_global_points_freq arg (=250000)
      --Mapper.ba_global_function_tolerance arg (=0)
      --Mapper.ba_global_max_num_iterations arg (=50)
      --Mapper.ba_global_max_refinements arg (=5)
      --Mapper.ba_global_max_refinement_change arg (=0.00050000000000000001)
      --Mapper.ba_local_max_refinements arg (=2)
      --Mapper.ba_local_max_refinement_change arg (=0.001)
      --Mapper.snapshot_path arg
      --Mapper.snapshot_images_freq arg (=0)
      --Mapper.fix_existing_images arg (=0)
      --Mapper.init_min_num_inliers arg (=100)
      --Mapper.init_max_error arg (=4)
      --Mapper.init_max_forward_motion arg (=0.94999999999999996)
      --Mapper.init_min_tri_angle arg (=16)
      --Mapper.init_max_reg_trials arg (=2)
      --Mapper.abs_pose_max_error arg (=12)
      --Mapper.abs_pose_min_num_inliers arg (=30)
      --Mapper.abs_pose_min_inlier_ratio arg (=0.25)
      --Mapper.filter_max_reproj_error arg (=4)
      --Mapper.filter_min_tri_angle arg (=1.5)
      --Mapper.max_reg_trials arg (=3)
      --Mapper.local_ba_min_tri_angle arg (=6)
      --Mapper.tri_max_transitivity arg (=1)
      --Mapper.tri_create_max_angle_error arg (=2)
      --Mapper.tri_continue_max_angle_error arg (=2)
      --Mapper.tri_merge_max_reproj_error arg (=4)
      --Mapper.tri_complete_max_reproj_error arg (=4)
      --Mapper.tri_complete_max_transitivity arg (=5)
      --Mapper.tri_re_max_angle_error arg (=5)
      --Mapper.tri_re_min_ratio arg (=0.20000000000000001)
      --Mapper.tri_re_max_trials arg (=1)
      --Mapper.tri_min_angle arg (=1.5)
      --Mapper.tri_ignore_two_view_tracks arg (=1)
    ```

=== "Colmap3.9"

    ```
    COLMAP 3.9 (Commit a7b50e4d on 2023-10-22 with CUDA)
    
    Options can either be specified via command-line or by defining
    them in a .ini project file passed to `--project_path`.
    
      -h [ --help ] 
      --random_seed arg (=0)
      --log_to_stderr arg (=0)
      --log_level arg (=2)
      --project_path arg
      --database_path arg
      --image_path arg
      --input_path arg
      --output_path arg
      --clear_points arg (=0)               Whether to clear all existing points 
                                            and observations
      --refine_intrinsics arg (=0)          Whether to refine the intrinsics of the
                                            cameras (fixing the principal point)
      --Mapper.min_num_matches arg (=15)
      --Mapper.ignore_watermarks arg (=0)
      --Mapper.multiple_models arg (=1)
      --Mapper.max_num_models arg (=50)
      --Mapper.max_model_overlap arg (=20)
      --Mapper.min_model_size arg (=10)
      --Mapper.init_image_id1 arg (=-1)
      --Mapper.init_image_id2 arg (=-1)
      --Mapper.init_num_trials arg (=200)
      --Mapper.extract_colors arg (=1)
      --Mapper.num_threads arg (=-1)
      --Mapper.min_focal_length_ratio arg (=0.10000000000000001)
      --Mapper.max_focal_length_ratio arg (=10)
      --Mapper.max_extra_param arg (=1)
      --Mapper.ba_refine_focal_length arg (=1)
      --Mapper.ba_refine_principal_point arg (=0)
      --Mapper.ba_refine_extra_params arg (=1)
      --Mapper.ba_min_num_residuals_for_multi_threading arg (=50000)
      --Mapper.ba_local_num_images arg (=6)
      --Mapper.ba_local_function_tolerance arg (=0)
      --Mapper.ba_local_max_num_iterations arg (=25)
      --Mapper.ba_global_images_ratio arg (=1.1000000000000001)
      --Mapper.ba_global_points_ratio arg (=1.1000000000000001)
      --Mapper.ba_global_images_freq arg (=500)
      --Mapper.ba_global_points_freq arg (=250000)
      --Mapper.ba_global_function_tolerance arg (=0)
      --Mapper.ba_global_max_num_iterations arg (=50)
      --Mapper.ba_global_max_refinements arg (=5)
      --Mapper.ba_global_max_refinement_change arg (=0.00050000000000000001)
      --Mapper.ba_local_max_refinements arg (=2)
      --Mapper.ba_local_max_refinement_change arg (=0.001)
      --Mapper.snapshot_path arg
      --Mapper.snapshot_images_freq arg (=0)
      --Mapper.fix_existing_images arg (=0)
      --Mapper.init_min_num_inliers arg (=100)
      --Mapper.init_max_error arg (=4)
      --Mapper.init_max_forward_motion arg (=0.94999999999999996)
      --Mapper.init_min_tri_angle arg (=16)
      --Mapper.init_max_reg_trials arg (=2)
      --Mapper.abs_pose_max_error arg (=12)
      --Mapper.abs_pose_min_num_inliers arg (=30)
      --Mapper.abs_pose_min_inlier_ratio arg (=0.25)
      --Mapper.filter_max_reproj_error arg (=4)
      --Mapper.filter_min_tri_angle arg (=1.5)
      --Mapper.max_reg_trials arg (=3)
      --Mapper.local_ba_min_tri_angle arg (=6)
      --Mapper.tri_max_transitivity arg (=1)
      --Mapper.tri_create_max_angle_error arg (=2)
      --Mapper.tri_continue_max_angle_error arg (=2)
      --Mapper.tri_merge_max_reproj_error arg (=4)
      --Mapper.tri_complete_max_reproj_error arg (=4)
      --Mapper.tri_complete_max_transitivity arg (=5)
      --Mapper.tri_re_max_angle_error arg (=5)
      --Mapper.tri_re_min_ratio arg (=0.20000000000000001)
      --Mapper.tri_re_max_trials arg (=1)
      --Mapper.tri_min_angle arg (=1.5)
      --Mapper.tri_ignore_two_view_tracks arg (=1)
    ```


## Model alignment
Align/geo-register model to coordinate system of given camera centers.

```shell
colmap model_aligner -h
```

=== "Colmap3.8"

    ```
    COLMAP 3.8 (Commit 31df46c on 2022-03-05 with CUDA)
    
    Options can either be specified via command-line or by defining
    them in a .ini project file passed to `--project_path`.
    
      -h [ --help ] 
      --random_seed arg (=0)
      --log_to_stderr arg (=0)
      --log_level arg (=2)
      --project_path arg
      --input_path arg
      --output_path arg
      --database_path arg
      --ref_images_path arg
      --ref_is_gps arg (=1)
      --merge_image_and_ref_origins arg (=0)
      --transform_path arg
      --alignment_type arg (=custom)        {plane, ecef, enu, enu-plane, 
                                            enu-plane-unscaled, custom}
      --min_common_images arg (=3)
      --estimate_scale arg (=1)
      --robust_alignment arg (=1)
      --robust_alignment_max_error arg (=0)
    ```

=== "Colmap3.9"

    ```
    COLMAP 3.9 (Commit a7b50e4d on 2023-10-22 with CUDA)
    
    Options can either be specified via command-line or by defining
    them in a .ini project file passed to `--project_path`.
    
      -h [ --help ] 
      --random_seed arg (=0)
      --log_to_stderr arg (=0)
      --log_level arg (=2)
      --project_path arg
      --input_path arg
      --output_path arg
      --database_path arg
      --ref_images_path arg
      --ref_is_gps arg (=1)
      --merge_image_and_ref_origins arg (=0)
      --transform_path arg
      --alignment_type arg (=custom)        {plane, ecef, enu, enu-plane, 
                                            enu-plane-unscaled, custom}
      --min_common_images arg (=3)
      --alignment_max_error arg (=0)
    ```


## Bundle adjustment
Run **global bundle adjustment on a reconstructed scene**, _e.g._ when a refinement of the intrinsics is needed or after running the `image_registrator`.

```shell
colmap bundle_adjuster -h
```

=== "Colmap3.8"

    ```
    COLMAP 3.8 (Commit 31df46c on 2022-03-05 with CUDA)
    
    Options can either be specified via command-line or by defining
    them in a .ini project file passed to `--project_path`.
    
      -h [ --help ] 
      --random_seed arg (=0)
      --log_to_stderr arg (=0)
      --log_level arg (=2)
      --project_path arg
      --input_path arg
      --output_path arg
      --BundleAdjustment.max_num_iterations arg (=100)
      --BundleAdjustment.max_linear_solver_iterations arg (=200)
      --BundleAdjustment.function_tolerance arg (=0)
      --BundleAdjustment.gradient_tolerance arg (=0)
      --BundleAdjustment.parameter_tolerance arg (=0)
      --BundleAdjustment.refine_focal_length arg (=1)
      --BundleAdjustment.refine_principal_point arg (=0)
      --BundleAdjustment.refine_extra_params arg (=1)
      --BundleAdjustment.refine_extrinsics arg (=1)
    ```

=== "Colmap3.9"

    ```
    COLMAP 3.9 (Commit a7b50e4d on 2023-10-22 with CUDA)
    
    Options can either be specified via command-line or by defining
    them in a .ini project file passed to `--project_path`.
    
      -h [ --help ] 
      --random_seed arg (=0)
      --log_to_stderr arg (=0)
      --log_level arg (=2)
      --project_path arg
      --input_path arg
      --output_path arg
      --BundleAdjustment.max_num_iterations arg (=100)
      --BundleAdjustment.max_linear_solver_iterations arg (=200)
      --BundleAdjustment.function_tolerance arg (=0)
      --BundleAdjustment.gradient_tolerance arg (=0)
      --BundleAdjustment.parameter_tolerance arg (=0)
      --BundleAdjustment.refine_focal_length arg (=1)
      --BundleAdjustment.refine_principal_point arg (=0)
      --BundleAdjustment.refine_extra_params arg (=1)
      --BundleAdjustment.refine_extrinsics arg (=1)
    ```


## Model analyzer
Print statistics about reconstructions.

```shell
colmap model_analyzer -h
```

=== "Colmap3.8"

    ```
    COLMAP 3.8 (Commit 31df46c on 2022-03-05 with CUDA)
    
    Options can either be specified via command-line or by defining
    them in a .ini project file passed to `--project_path`.
    
      -h [ --help ] 
      --random_seed arg (=0)
      --log_to_stderr arg (=0)
      --log_level arg (=2)
      --project_path arg
      --path arg
    ```

=== "Colmap3.9"

    ```
    COLMAP 3.9 (Commit a7b50e4d on 2023-10-22 with CUDA)
    
    Options can either be specified via command-line or by defining
    them in a .ini project file passed to `--project_path`.
    
      -h [ --help ] 
      --random_seed arg (=0)
      --log_to_stderr arg (=0)
      --log_level arg (=2)
      --project_path arg
      --path arg
      --verbose arg (=0)
    ```