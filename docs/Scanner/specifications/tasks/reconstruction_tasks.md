Reconstruction related tasks
===

## Undistorted

This task class is used to "undistort" images obtained by a camera that may not have a perfect lens.
It produces a `Fileset` of rgb images saved under the task id.

## Colmap

This task class is used to estimate *camera poses* from a set of RGB images.
By default, it is downstream *ImagesFilesetExists* (raw scan) An alternative upstream task choice could be the *Undistorted*.
It produces ??? (**TODO**)

!!! danger "Clarification required!"
    * don't we use the positions (x, y, z, pan) from the CNC & gimball ?
    * why do we compute the sparse reconstruction (point-cloud) ?

## Masks

This task class is used to create a binary mask of each (real or virtual) *plant RGB image*.
By default, it is downstream the *Undistorted* task. An alternative upstream task choice could be the *Undistorted*.

The following methods are available to compute masks:

* linear
* excess_green
* vesselness
* invert

!!! danger "Clarification required!"
* document mask algorithms!

It produces a `Fileset` of binary images saved under the task id.

## Voxels

This task class is used to compute a *volume* (ref?) from *back-projection* of the binary (Masks task) or labelled (Segmentation2D task) masks.
By default, it is downstream the _Masks_ & _Colmap_ tasks.

The following methods are available to compute back-projection:

* carving
* averaging

!!! danger "Clarification required!"
    * what is a *volume* ?! the difference with "point-cloud" is not too clear... * document back-projection algorithms!

It produces a 3D array saved as NPZ (compressed numpy array).
This array may be binary if downstream of the _Masks_ task, or a labelled array if downstream the _Segmentation2D_ task.

## PointCloud

This task class is used to transform the binary volumetric data, from the Voxels tasks into an `open3d` 3D point-cloud.
By default, it is downstream the *Voxels* task.

It uses an *Exact Euclidean distance transform* method (ref?).

It produces a PLY file.

## TriangleMesh

This task class is used to transform a 3D point-cloud into an `open3d` 3D triangulated mesh.
By default, it is downstream the *PointCloud* task.

It uses the `poisson_mesh` method from the CGAL library described [here](https://doc.cgal.org/latest/Poisson_surface_reconstruction_3/index.html).

It produces a PLY file.

## CurveSkeleton

This task class is used to compute a *skeleton* (ref?) from a 3D triangulated mesh.
By default, it is downstream the *PointCloud* task.

It uses the `skeletonize_mesh` method from the CGAL library described [here](https://doc.cgal.org/latest/Surface_mesh_skeletonization/index.html).

It produces a PLY file.

## TreeGraph

This task class is used to generate a *tree graph structure* (ref?) from a *skeleton*.
By default, it is downstream the *CurveSkeleton* task.

It uses `networkx` Python package to compute a *minimum spanning tree* with ??? (**TODO**)

It produces a JSON file ??? (**TODO**)

## AnglesAndInternodes

This task class is used to compute angles and internodes between successive organs along the main stem.
By default, it is downstream the *TreeGraph* task.

It produces a JSON file ??? (**TODO**)

## Segmentation2D

This task class is used to

## SegmentedPointCloud

This task class is used to transform the multiclass volumetric data, from the Segmentation2D tasks into an `open3d` labelled 3D point-cloud.
By default, it is downstream the *Segmentation2D* task.

It produces a PLY file.

## ClusteredMesh

This task class is used to transform a labelled 3D point-cloud into an `open3d` 3D triangulated mesh.
By default, it is downstream the *SegmentedPointCloud* task.

It produces a PLY file.
