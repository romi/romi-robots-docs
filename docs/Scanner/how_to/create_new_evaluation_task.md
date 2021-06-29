How-to create a new ROMI evaluation task
========================================

In order to evaluate the reconstruction and quantification tasks **accuracy**, we offer the possibility to also create *evaluation tasks*.
The idea is to use a digital twin to generates the expected outcome of a task and use it as ground truth to challenge the reconstruction task.

To do so, you will have to create two tasks:

- **ground truth task**: it should generate the expected outcome of the evaluated task from the digital twin;
- **evaluation task**: it will compare the output of the evaluated task against the ground truth.

For example, the `Voxels` task has a `VoxelGroundTruth` task and a `VoxelEvaluation` task.


## Ground truth task
Ground truth tasks should be defined in `plant-3d-vision/plant3dvision/tasks/ground_truth.py`.
It should inherit from `RomiTask` and define a `run` method exporting the ground truth later use as reference in the evaluation task.

!!! warning
    Do not forget to reference the task in `romitask/romitask/modules.py`.

## Evaluation task
Evaluation tasks should be defined in `plant-3d-vision/plant3dvision/tasks/evaluation.py`.
The evaluation task that you will write should inherit from `EvaluationTask` that defines:

* the `requires` method to use an `upstream_task` and `ground_truth`;
* the `output` method to create the corresponding evaluation dataset
* the `evaluate` method that you should override;
* the `run` method that call `evaluate` and save the results as a JSON file.


!!! warning
    Do not forget to reference the task in `romitask/romitask/modules.py`.
