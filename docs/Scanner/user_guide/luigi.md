Luigi in the ROMI Plant Scanner project
===

Hereafter we explain how we used the `luigi` Python package in the ROMI Plant Scanner project.
If you are not familiar with `luigi`, let's just say that it is useful to create long-running batch processes where you want to chain many tasks with dependencies and requirements.

In the context of the ROMI Plant Scanner project, we faced the challenge of creating complex pipelines, especially for the *3D reconstruction & analysis* of a plant structure after its *acquisition* in the form of a series of RGB images.
Several complex and fairly distinct algorithm are required to achieve our goals, and we thus decided to break down this chain of tasks to achieve greater modularity and robustness.

Using `luigi` led us to abstract several concepts like `Task`, `Target` & `Parameter`:

* a **task** is limited to a single algorithmic operation with input(s), output(s) & parameter(s);
* a **target** is a (set of) file(s) that can be the input required by a task or (one of) its output(s);
* a **parameter** is a value controlling the algorithm;

## Parameters & configuration

As we run `luigi` using the command-line tool, and the constructed workflow can be made of many tasks each with several parameters, we use TOML configuration files to define them.
In addition to the TOML configuration file, the `romi_run_task` script requires the definition of two values:

* the name of the ROMI task to run;
* the name of the `Scan` dataset on which to run the ROMI task;

As we will see later, each "computational task" has an upstream task. Using these *tasks dependencies* luigi will create the required workflow.
**Hence you do not have to know or defines the required workflow to run a task, just call it and luigi will do the rest for you!**

## Target subclass

In order to check for a task requirement(s) or handle its output(s) `luigi` implement the `Target` class.
As we use our own Python database implementation `FSDB` from `plantdb`, and it implements the concept of a set of files as a `Fileset` class, we subclassed the `luigi.Target` class as `TargetFileset`.
It is thus used to get/create files from the `FSDB` database by our `luigi.Task` subclasses.

For example, the raw RGB images set obtained after a `Scan` task is the `'images'` `Fileset`.

## Task subclasses

This is where the computation is done with the `run()` method and targets are controlled with the `requires()` & `output()` methods.

!!! note
    ROMI tasks do not use a `Scan` dataset identifier as it is assumed that they only work on one `Scan` at a time.
