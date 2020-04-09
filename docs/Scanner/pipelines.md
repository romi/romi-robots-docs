
!!! warning 
    This is a work in progress... the original author has no idea what he is doing!

## Legend:

{% dot legend.svg
digraph dfd2{
    params [label="Input parameters" shape=note];
    task [label="{<f0> Task name|<f1> module |<f2> description.\n}" shape=Mrecord];
    task_output [label="Task output (EXT)" shape=folder];
}
%}
- _Note shaped_ boxes are `RomiConfig`, they are TOML files that contains parameters for each task.
- _Round shaped_ boxes are `RomiTasks` with their name on the first level, then the module names (`--module` option in `romi_run_task`) and a quick description of the tasks at hand.
- _Folder shaped_ boxes are `RomiTarget`, they indicate files input/output and the file extension is given between parenthesis.


## Real plant datasets

{% dot real_plant_pipeline.svg
digraph dfd2{
    node[shape=record width=3]
    subgraph level0{
        input [label="Scanner parameters (TOML)" shape=note];
    }
    subgraph cluster_level1{
        label ="Real plants";
        scan_task [label="{<f0> Scan|<f1> romiscanner.scan|<f2> Scan a plant (requires romi scanner).\n}" shape=Mrecord];
        scan_out1 [label="Multiple RGB images (PNG|JPEG)" shape=folder];
        scan_out2 [label="Approximate camera poses from CNC (JSON)" shape=folder];
        scan_out3 [label="Metadata (JSON)" shape=folder];
    }
    input -> scan_task
    scan_task -> scan_out1
    scan_task -> scan_out2
    scan_task -> scan_out3
}
%}


## Virtual plant datasets

{% dot virtual_plant_pipeline.svg
digraph dfd2{
    node[shape=record width=3]
    subgraph level0{
        input [label="LPY parameters (TOML)" shape=note];
    }
    subgraph cluster_level1{
        label ="Virtual plant generator";
        virtualplant_task [label="{<f0> VirtualPlant|<f1> romiscanner.lpy|<f2> LPY 3D plant generator.\n}" shape=Mrecord];
        virtualplant_out1 [label="3D Plant (OBJ)" shape=folder];
        virtualplant_out2 [label="Angles & internodes (JSON)" shape=folder];
        virtualscan_task [label="{<f0> VirtualScan|<f1> romiscanner.scan|<f2> Generate photorealistic images of a virtual plant.\n}" shape=Mrecord];
        virtualscan_out1 [label="Multiple RGB images (PNG|JPEG)" shape=folder];
        virtualscan_out2 [label="Camera poses (JSON)" shape=folder];
    }
    input -> virtualplant_task
    virtualplant_task -> virtualplant_out1
    virtualplant_task -> virtualplant_out2
    virtualplant_out1 -> virtualscan_task
    virtualscan_task -> virtualscan_out1
    virtualscan_task -> virtualscan_out2
}
%}

## Plant Reconstruction from RGB images

{% dot plant_reconstruct_pipeline.svg
digraph dfd2{
    node[shape=record width=3]
    subgraph level0{
        input [label="Multiple RGB images (PNG|JPEG)" shape=folder];
        colmap_task [label="{<f0> Colmap|<f1> romiscan.tasks.colmap|<f2> Camera poses estimation.\n}" shape=Mrecord];
        colmap_out_1 [label="Camera poses (JSON)" shape=folder];
        colmap_out_2 [label="PointCloud (PLY)" shape=folder];
        {rank=same; colmap_out_1, colmap_out_2}
    }
    subgraph cluster_level1{
        label="Algorithmic Pipeline";
        mask_task [label="{<f0> Mask|<f1> romiscan.tasks.proc2d|<f2> 'Plant pixels' detection.\n}" shape=Mrecord];
        mask_out [label="Binary masks (PNG)" shape=folder];
        voxel_task [label="{<f0> Voxel|<f1> romiscan.tasks.cl|<f2> Space carving?\n}" shape=Mrecord];
        voxel_out [label="Binary Voxel (NPZ)" shape=folder];
        pointcloud_task [label="{<f0> PointCloud|<f1> romiscan.tasks.proc3d|<f2> PointCloud from a set of Masks.\n}" shape=Mrecord];
        pointcloud_out [label="Plant pointcloud (PLY)" shape=folder];
        triangle_mesh_task [label="{<f0> TriangleMesh|<f1> romiscan.tasks.proc3d|<f2> Generate a Mesh from a PointCloud.\n}" shape=Mrecord];
        triangle_mesh_out [label="Mesh (PLY)" shape=folder];
        skeleton_task [label="{<f0> Skeletonization|<f1> romiscan.tasks.proc3d|<f2> Mesh skeletonization.\n}" shape=Mrecord];
        skeleton_out [label=" ? (JSON)" shape=folder];
        tree_graph_task [label="{<f0> TreeGraph|<f1> romiscan.tasks.arabidopsis|<f2> Plant skeleton to TreeGraph structure.\n}" shape=Mrecord];
        tree_graph_out [label=" TreeGraph (JSON)" shape=folder];
    }
    subgraph cluster_level2{
        label="Machine Learning Pipeline";
        segmentation_task [label="{<f0> Segmentation2D|<f1> romiscan.tasks.proc2d|<f2> 'Plant pixels' detection with labels.\n}" shape=Mrecord];
        segmentation_out [label="Masks (PNG)" shape=folder];
        mvoxel_task [label="{<f0> Voxels|<f1> romiscan.tasks.cl|<f2> Space carving?\n}" shape=Mrecord];
        mvoxel_out [label="Binary Voxel (NPZ)" shape=folder];
        lpointcloud_task [label="{<f0> PointCloud|<f1> romiscan.tasks.proc3d|<f2> Space carving?\n}" shape=Mrecord];
        lpointcloud_out [label="Plant pointcloud (PLY)" shape=folder];
        clutered_mesh_task [label="{<f0> ClusteredMesh|<f1> romiscan.tasks.proc3d|<f2> Generate a Mesh from a PointCloud.\n}" shape=Mrecord];
        clutered_mesh_out [label="Mesh (PLY)" shape=folder];
    }
    input -> colmap_task
    # algorithmic pipeline
    input -> mask_task
    colmap_out_1 -> voxel_task
    mask_out -> voxel_task
    voxel_out -> pointcloud_task
    pointcloud_out -> triangle_mesh_task
    triangle_mesh_out -> skeleton_task
    skeleton_out -> tree_graph_task
    # ML pipeline:
    input -> segmentation_task
    colmap_out_1 -> segmentation_task
    segmentation_out -> mvoxel_task
    mvoxel_out -> lpointcloud_task
    lpointcloud_out -> clutered_mesh_task
colmap_task -> colmap_out_1
colmap_task -> colmap_out_2
# algorithmic pipeline
mask_task -> mask_out
voxel_task -> voxel_out
pointcloud_task -> pointcloud_out
triangle_mesh_task -> triangle_mesh_out
skeleton_task -> skeleton_out
tree_graph_task -> tree_graph_out
# ML pipeline:
segmentation_task -> segmentation_out
mvoxel_task -> mvoxel_out
lpointcloud_task -> lpointcloud_out
clutered_mesh_task -> clutered_mesh_out
}
%}

## 3D Plant Phenotyping

{% dot plant_pheno_pipeline.svg
digraph dfd2{
    node[shape=record width=3]
    subgraph level0{
        config_input [label="Parameters (TOML)" shape=note]
        algo_input [label="TreeGraph (JSON)" shape=folder];
        ml_input [label="ClusteredMesh (PLY)" shape=folder];
    }
    subgraph cluster_level1{
        label ="Plant Phenotyping";
        angles_and_internodes_task [label="{<f0> AnglesAndInternodes|<f1> romiscan.tasks.arabidopsis|<f2> Compute organs angles and internodes.\n}" shape=Mrecord];
        angles_and_internodes_out [label="Measures (JSON)" shape=folder];
    }
config_input -> angles_and_internodes_task
algo_input -> angles_and_internodes_task
ml_input -> angles_and_internodes_task
angles_and_internodes_task -> angles_and_internodes_out
}
%}


## Evaluation

### Mask task evaluation

{% dot voxel_eval.svg
digraph dfd2{
    node[shape=record width=3]
    subgraph level0{
        config_input [label="Parameters (TOML)" shape=note];
        lpy_input [label="LPY parameters (TOML)" shape=note];
    }
    subgraph cluster_level1{
        label ="Virtual plant generator";
        #style=filled; fillcolor=cornflowerblue;
        virtualplant_task [label="{<f0> VirtualPlant|<f1> romiscanner.lpy|<f2> LPY 3D plant generator.\n}" shape=Mrecord];
        virtualplant_out1 [label="3D Plant (OBJ)" shape=folder];
        virtualplant_out2 [label="Angles & internodes (JSON)" shape=folder];
        virtualscan_task [label="{<f0> VirtualScan|<f1> romiscanner.scan|<f2> Generate photorealistic images of a virtual plant.\n}" shape=Mrecord];
        virtualscan_out1 [label="Multiple RGB images (PNG|JPEG)" shape=folder];
        virtualscan_out2 [label="Camera poses (JSON)" shape=folder];
        virtualscan_out3 [label="Ground truth segmentation (JSON)" shape=folder style="dashed"];
    }
    lpy_input -> virtualplant_task
    virtualplant_task -> {virtualplant_out1 virtualplant_out2}
    virtualplant_out1 -> virtualscan_task
    virtualscan_task -> {virtualscan_out1 virtualscan_out2 virtualscan_out3}
    subgraph cluster_level2{
        label="Algorithmic Pipeline";
        mask_task [label="{<f0> Mask|<f1> romiscan.tasks.proc2d|<f2> 'Plant pixels' detection.\n}" shape=Mrecord];
        mask_out [label="Binary masks (PNG)" shape=folder];
    }
    config_input -> mask_task
    mask_task -> mask_out
    subgraph cluster_level3{
        label="Evaluation";
        #style=filled; fillcolor=aquamarine;
        seg2deval_task [label="{<f0> Segmentation2DEvaluation|<f1> romiscan.tasks.evaluation|<f2> Get ground truth voxel from virtual plant.\n}" shape=Mrecord];
        seg2deval_out [label="Evaluate masks detection (JSON)" shape=folder];
    }
    mask_out -> seg2deval_task
    virtualscan_out3 -> seg2deval_task
    seg2deval_task -> seg2deval_out
}
%}

### Voxel task evaluation

{% dot voxel_eval.svg
digraph dfd2{
    node[shape=record width=3]
    subgraph level0{
        config_input [label="Parameters (TOML)" shape=note];
        lpy_input [label="LPY parameters (TOML)" shape=note];
    }
    #
    # Virtual plant generator
    subgraph cluster_level1{
        label ="Virtual plant generator";
        #style=filled; fillcolor=cornflowerblue;
        virtualplant_task [label="{<f0> VirtualPlant|<f1> romiscanner.lpy|<f2> LPY 3D plant generator.\n}" shape=Mrecord];
        virtualplant_out1 [label="3D Plant (OBJ)" shape=folder];
        virtualplant_out2 [label="Angles & internodes (JSON)" shape=folder];
    }
    lpy_input -> virtualplant_task
    virtualplant_task -> {virtualplant_out1 virtualplant_out2}
    #
    # Algorithmic Pipeline
    subgraph cluster_level2{
        label="Algorithmic Pipeline";
        mask_task [label="{<f0> Mask|<f1> romiscan.tasks.proc2d|<f2> 'Plant pixels' detection.\n}" shape=Mrecord];
        mask_out [label="Binary masks (PNG)" shape=folder];
        voxel_task [label="{<f0> Voxel|<f1> romiscan.tasks.cl|<f2> Space carving?\n}" shape=Mrecord];
        voxel_out [label="Binary Voxel (NPZ)" shape=folder];
    }
    config_input -> mask_task
    mask_task -> mask_out
    mask_out -> voxel_task
    voxel_task -> voxel_out
    #
    # Evaluation
    subgraph cluster_level3{
        label="Evaluation";
        voxelgroundtruth_task [label="{<f0> VoxelGroundTruth|<f1> romiscan.tasks.evaluation|<f2> Get ground truth voxel from virtual plant.\n}" shape=Mrecord];
        voxelgroundtruth_out [label="Binary Voxel (NPZ)" shape=folder];
        voxeleval_task [label="{<f0> VoxelsEvaluation|<f1> romiscan.tasks.evaluation|<f2> Evaluate voxel detection based on ground truth.\n}" shape=Mrecord];
        voxeleval_out [label="Voxel evaluation (JSON)" shape=folder];
    }
    virtualplant_out1 -> voxelgroundtruth_task
    voxelgroundtruth_task -> voxelgroundtruth_out
    voxelgroundtruth_out -> voxeleval_task
    voxel_out -> voxeleval_task
    voxeleval_task -> voxeleval_out
}
%}

### PointCloud task evaluation

{% dot pointcloud_eval.svg
digraph dfd2{
    node[shape=record width=3]
    subgraph level0{
        config_input [label="Parameters (TOML)" shape=note];
        lpy_input [label="LPY parameters (TOML)" shape=note];
    }
    #
    # Virtual plant generator
    subgraph cluster_level1{
        label ="Virtual plant generator";
        virtualplant_task [label="{<f0> VirtualPlant|<f1> romiscanner.lpy|<f2> LPY 3D plant generator.\n}" shape=Mrecord];
        virtualplant_out1 [label="3D Plant (OBJ)" shape=folder];
        virtualplant_out2 [label="Angles & internodes (JSON)" shape=folder];
    }
    lpy_input -> virtualplant_task
    virtualplant_task -> {virtualplant_out1 virtualplant_out2}
    #
    # Algorithmic Pipeline
    subgraph cluster_level2{
        label="Algorithmic Pipeline";
        mask_task [label="{<f0> Mask|<f1> romiscan.tasks.proc2d|<f2> 'Plant pixels' detection.\n}" shape=Mrecord];
        mask_out [label="Binary masks (PNG)" shape=folder];
        voxel_task [label="{<f0> Voxel|<f1> romiscan.tasks.cl|<f2> Space carving?\n}" shape=Mrecord];
        voxel_out [label="Binary Voxel (NPZ)" shape=folder];
        pointcloud_task [label="{<f0> PointCloud|<f1> romiscan.tasks.proc3d|<f2> PointCloud from a set of Masks.\n}" shape=Mrecord];
        pointcloud_out [label="Plant pointcloud (PLY)" shape=folder];
    }
    config_input -> mask_task
    mask_task -> mask_out
    mask_out -> voxel_task
    voxel_task -> voxel_out
    voxel_out -> pointcloud_task
    pointcloud_task -> pointcloud_out
    #
    # Evaluation
    subgraph cluster_level3{
        label="Evaluation";
        pointcloudgroundtruth_task [label="{<f0> PointCloudGroundTruth|<f1> romiscan.tasks.evaluation|<f2> Get ground truth point cloud from virtual plant.\n}" shape=Mrecord];
        pointcloudgroundtruth_out [label="PointCloud (PLY)" shape=folder];
        pointcloudeval_task [label="{<f0> PointCloudEvaluation|<f1> romiscan.tasks.evaluation|<f2> Evaluate point cloud detection based on ground truth.\n}" shape=Mrecord];
        pointcloudeval_out [label="PointCloud evaluation (JSON)" shape=folder];
    }
    virtualplant_out1 -> pointcloudgroundtruth_task
    pointcloudgroundtruth_task -> pointcloudgroundtruth_out
    pointcloudgroundtruth_out -> pointcloudeval_task
    pointcloud_out -> pointcloudeval_task
    pointcloudeval_task ->pointcloudeval_out
}
%}
