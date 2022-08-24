# COLMAP CLI

## Feature extraction
```shell
colmap feature_extractor -h
```
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

## Exhaustive matcher
```shell
colmap exhaustive_matcher -h
```
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

## Mapper
```shell
colmap mapper -h
```
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

## Model alignment

This step is used to "geo-reference" the reconstructed model.

```shell
colmap model_aligner -h
```
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