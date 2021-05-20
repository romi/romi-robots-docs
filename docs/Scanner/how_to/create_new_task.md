How-to create a new ROMI task
=============================

We hereafter details how you can make your own algorithms available to the ROMI reconstruction and analysis pipeline by creating a task and registering it as an available module.

For the sake of clarity and to illustrate how-to create a ROMI task from scratch, in this guide we will assume you want to add something quite different from what is already there.

!!! Important
    ROMI task usually have a **semantic meaning** and for example, the task `AnglesAndInternodes` may takes several type of object in input (mesh, pointcloud & skeletons) but always output the JSON file with the obtained measures.
    So, to decide if you have to create a new task or add your algorithm to an existing task, following this rule should help: **at a given step of the pipeline, if the output change, this is a NEW task!**


## Add you algorithm to `romiscan`
You first have to add a file (or append to an existing one), *e.g.* named `algo.py`, under the `romiscan/romiscan` directory.

Let's assume the previously added file has a main function called `my_algo` like this:

```python
def my_algo(data, *params, **kwargs):
    # Do something to data with given parameters to return transformed data `out_data`
    return out_data, error
```

It has:

 - **data input(s)** (*e.g.* images, point clouds, meshes, ...) that will often be the output of a previous task in the pipeline
 - **parameter(s)**, specific to the algorithm you want to add
 - **output(s)**, the transformed dataset that will often be the input of a following task in the pipeline


## Create a ROMI task

### Dependency to `luigi`
We use `luigi` to manage the pipeline execution and handle requirements & tasks dependencies. 
To create a task you will thus have to create a new Python class `MyTask` inheriting from the `RomiTask` class and creates a few methods and at least a `run` method used by `luigi`.

### Dependency to `romidata`
To manage the files, inputs and outputs, we use the `romidata` package implementing a local file system database written in pure python.
It provides classes and methods that simplifies and normalize the creation and use of the tasks outputs and inputs.  


### New `RomiTask` template
You will create a new python file `my_task.py` in the 'task' submodule: `romiscan/romiscan/tasks/my_task.py`
```python
#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Briefly describe your module here.
"""

import luigi

from romidata import RomiTask
from romidata import io
from romiscan.log import logger  # Use this as logging method

# Now import your main method:
from romiscan.algo import my_algo


def MyTask(RomiTask):
    """My algorithm is the best!
    
    Attributes
    ----------
    upstream_task : luigi.TaskParameter
        Upstream task that will provides the data to your algorithm, here `SegmentedPointCloud`.
    param1 : luigi.FloatParameter
        An example float parameter parsed from the TOML config file.
        Set to `2.0` by default.
    param2 : luigi.IntParameter
        An example float parameter parsed from the TOML config file.
        Set to `5` by default.
    log : luigi.BoolParameter
        An example boolean parameter.

    """
    # No need to write an `__init__` section, declare your class attributes as task parameters:
    upstream_task = luigi.TaskParameter(default=SegmentedPointCloud)
    param1 = luigi.FloatParameter(default=2.0)
    param2 = luigi.IntParameter(default=5)
    log = luigi.BoolParameter(default=False)

    def requires(self):
        """Used by luigi to check you task dependencies."""
        # By default a RomiTask requires a luigi.TaskParameter called `upstream_task`.
        # So no need to declare this method if you don't requires more than one upstream task!
        # Else you can override with something like (should be of type `luigi.TaskParameter`!):
        #return [self.upstream_task1(), self.upstream_task1()]
        pass

    def run(self):
        """Called by luigi, it will run your algorithm.
        
        Usually consist of 3 steps:
        1. Get the input(s) data from the previous task, eg. images or point clouds
        2. Run you algorithm on input data
        3. Save the result(s) of your method, eg. as a JSON file

        Notes
        -----
        The parameters for your algorithms have been declared at class instantiation!
        """
        # -1- Get the input(s) data from the previous task
        # To access the single file output of the upstream task use:
        uptask_input_file = self.input_file()
        # Read it with the proper reader, here a point-cloud reader (SegmentedPointCloud):
        in_data = io.read_point_cloud(uptask_input_file)

        # -2- Run you algorithm on input data
        out_data, error = my_algo(in_data)
        # Use example for boolean parameter & logger with 'info' level
        if self.log:
            logger.info("My task ran perfectly!")

        # -3- Write a single output (eg. a JSON file)...
        # Create the output `File` object
        task_output_file = self.output_file()
        # Write a JSON file with your method results
        io.write_json(task_output_file, out_data)
        # Add metadata to your file, eg. some error measure you don't want to include in the main output file:
        task_output_file.set_metadata("my_error", error)
```

The corresponding TOML configuration file (`my_pipeline.toml`) controlling your task behaviour would look like this:
```toml
[MyTask]
upstream_task='SegmentedPointCloud'
param1=6.0
param2=3
log=true
```

!!! Note
    You may need to add methods to read and write data, this should be done in the `romidata` library using the `romidata/romidata/io.py` file!


### Multiple I/O for a task
Your method (or the upstream task) may produce a set of object you want to save as separates files.
In such case, use `Filset` objects.

For example to output multiple JSON files:
```python
list_of_jsonifyable = [...]
task_output_fs = self.output().get()
for i, json_data in enumerate(list_of_jsonifyable):
    f = task_output_fs.create_file(f"my_json_{i}")  # no extension!
    io.write_json(f, json_data)
    # Add some metadata to this `File` object
    f.set_metadata("foo", f"bar{i}")
```


## Register your task
Add it to `romiscan/modules.py` by referring to the task class name & its python module location:
```python
MODULES = {
    # ...
    "MyTask": "romiscan.tasks.my_algo",
    # ...
}
```


## Use your newly created task
You should now be able to use your newly created task `MyTask` with `romi_run_task`:
```shell
romi_run_task MyTask /path/to/dataset --config /path/to/my_pipeline.toml
```

!!! Warning
    Use of absolute path is highly recommended as you may experience some difficulties from `luigi` otherwise!