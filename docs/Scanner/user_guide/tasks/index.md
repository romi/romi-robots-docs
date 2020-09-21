Task definitions
====

As we have seen previously, we are using the luigi paradigm and have defined a series of **tasks** to create flexible and modular pipelines.

This section is more a general overview, For more details see the reference documentation (**TODO**)!

## Base task class
`RomiTask` is the base abstract class for the ROMI Plant Scanner project and subclass `luigi.Task`.

It implements the following methods:

* `requires()`, by default an upstream task is required;
* `output()`, by default the output of a task is a `Fileset` with the task's name as an identifier;
* `input_file()`, helper method to get the output of the upstream task;
* `output_file()`, helper method to create the output of the current task;

