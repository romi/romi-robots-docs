
!!! warning 
    Input(s), output(s) and Tasks (with description).


## Generation of virtual plant datasets

{% dot virtual_plant_pipeline.svg
digraph dfd2{
    node[shape=record]
    subgraph level0{
    input [label="LPY parameters" shape=box];
    }
    subgraph cluster_level1{
        label ="Virtual plant generator";
        virtualplant_task [label="{<f0> VirtualPlant|<f1> romiscanner.lpy|<f2> LPY 3D plant generator.\n}" shape=Mrecord];
        virtualplant_task_out [label="3D Plant (OBJ)" shape=folder];

        virtualscan_task [label="{<f0> VirtualScan|<f1> romiscanner.scan|<f2> Generate photorealistic images of a virtual plant.\n}" shape=Mrecord];
        virtualscan_task_out [label="Multiple RGB images (PNG|JPEG)" shape=folder];
    }
    input -> virtualplant_task
    virtualplant_task -> virtualplant_task_out
    virtualplant_task_out -> virtualscan_task
    virtualscan_task -> virtualscan_task_out
}
%}

## Plant Reconstruction from RGB images
First level are tasks names, then the module names and a description.
Folder shaped boxes indicate files input/output.

{% dot plant_reconstruct_pipeline.svg
digraph dfd2{
    node[shape=record]
    
    subgraph level0{
    input [label="Multiple RGB images (PNG|JPEG)" shape=folder];

    colmap_task [label="{<f0> Colmap|<f1> romiscan.tasks.colmap|<f2> Camera poses estimation.\n}" shape=Mrecord];
    colmap_out_1 [label="Poses (JSON)" shape=folder];
    colmap_out_2 [label="PointCloud (PLY)" shape=folder];
    {rank=same; colmap_out_1, colmap_out_2}
    }

    subgraph cluster_level1{
        label="Algorithmic Pipeline";
        mask_task [label="{<f0> Mask|<f1> romiscan.tasks.proc2d|<f2> 'Plant pixels' detection.\n}" shape=Mrecord];
        mask_task_out [label="Binary masks (PNG)" shape=folder];

        voxel_task [label="{<f0> Voxel|<f1> romiscan.tasks.cl|<f2> Space carving?\n}" shape=Mrecord];
        voxel_task_out [label="Binary Voxel (NPZ)" shape=folder];

        pointcloud_task [label="{<f0> PointCloud|<f1> romiscan.tasks.proc3d|<f2> PointCloud from a set of Masks.\n}" shape=Mrecord];
        pointcloud_task_out [label="Plant pointcloud (PLY)" shape=folder];

        triangle_mesh_task [label="{<f0> TriangleMesh|<f1> romiscan.tasks.proc3d|<f2> Generate a Mesh from a PointCloud.\n}" shape=Mrecord];
        triangle_mesh_task_out [label="Mesh (PLY)" shape=folder];

        skeleton_task [label="{<f0> Skeletonization|<f1> romiscan.tasks.proc3d|<f2> Mesh skeletonization.\n}" shape=Mrecord];
        skeleton_task_out [label=" ? (JSON)" shape=folder];

        tree_graph_task [label="{<f0> TreeGraph|<f1> romiscan.tasks.arabidopsis|<f2> Plant skeleton to TreeGraph structure.\n}" shape=Mrecord];
        tree_graph_task_out [label=" TreeGraph (JSON)" shape=folder];
    }
    subgraph cluster_level2{
        label="Machine Learning Pipeline";
        segmentation_task [label="{<f0> Segmentation2D|<f1> romiscan.tasks.proc2d|<f2> 'Plant pixels' detection with labels.\n}" shape=Mrecord];
        segmentation_out [label="Masks (PNG)" shape=folder];

        mvoxel_task [label="{<f0> Voxels|<f1> romiscan.tasks.cl|<f2> Space carving?\n}" shape=Mrecord];
        mvoxel_task_out [label="Binary Voxel (NPZ)" shape=folder];

        lpointcloud_task [label="{<f0> PointCloud|<f1> romiscan.tasks.proc3d|<f2> Space carving?\n}" shape=Mrecord];
        lpointcloud_task_out [label="Plant pointcloud (PLY)" shape=folder];

        clutered_mesh_task [label="{<f0> ClusteredMesh|<f1> romiscan.tasks.proc3d|<f2> Generate a Mesh from a PointCloud.\n}" shape=Mrecord];
        clutered_mesh_task_out [label="Mesh (PLY)" shape=folder];
    }
    input -> colmap_task
    # algorithmic pipeline
    input -> mask_task
    colmap_out_1 -> voxel_task
    mask_task_out -> voxel_task
    voxel_task_out -> pointcloud_task
    pointcloud_task_out -> triangle_mesh_task
    triangle_mesh_task_out -> skeleton_task
    skeleton_task_out -> tree_graph_task
    # ML pipeline:
    input -> segmentation_task
    colmap_out_1 -> segmentation_task
    segmentation_out -> mvoxel_task
    mvoxel_task_out -> lpointcloud_task
    lpointcloud_task_out -> clutered_mesh_task
colmap_task -> colmap_out_1
colmap_task -> colmap_out_2
# algorithmic pipeline
mask_task -> mask_task_out
voxel_task -> voxel_task_out
pointcloud_task -> pointcloud_task_out
triangle_mesh_task -> triangle_mesh_task_out
skeleton_task -> skeleton_task_out
tree_graph_task -> tree_graph_task_out
# ML pipeline:
segmentation_task -> segmentation_out
mvoxel_task -> mvoxel_task_out
lpointcloud_task -> lpointcloud_task_out
clutered_mesh_task -> clutered_mesh_task_out
}
%}

## 3D Plant Phenotyping

{% dot plant_pheno_pipeline.svg
digraph dfd2{
    node[shape=record]
    
    subgraph level0{
    algo_input [label="TreeGraph (JSON)" shape=folder];
    ml_input [label="ClusteredMesh (PLY)" shape=folder];
    }

    subgraph cluster_level1{
        label ="Plant Phenotyping";
        angles_and_internodes_task [label="{<f0> AnglesAndInternodes|<f1> romiscan.tasks.arabidopsis|<f2> Compute organs angles and internodes.\n}" shape=Mrecord];
        angles_and_internodes_out [label="Measures (JSON)" shape=folder];
    }

algo_input -> angles_and_internodes_task
ml_input -> angles_and_internodes_task
angles_and_internodes_task -> angles_and_internodes_out
}
%}
