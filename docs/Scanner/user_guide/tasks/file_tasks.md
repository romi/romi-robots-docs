File-related tasks
===

## FilesetExists
This task takes a `Fileset` identifier as a parameter and makes sure it is found in the `Scan` instance it is working on.
No upstream task definition is required and it returns the `Fileset`.

## ImagesFilesetExists

This is a specific case of the `FilesetExists` class for `'images'` `Fileset`, *i.e.* the set of RGB images obtained after the `Scan` task.

## ModelFileset

This is a specific case of the `FilesetExists` class for `'models'` `Fileset`, *i.e.* the training file obtained from machine learning.

## FileByFileTask

This is an abstract class used to apply a `RomiTask` on each file of a `Fileset`.

## Clean task
This task class is used to clean a `Scan` dataset by removing all `Fileset`s except the `'images'` `Fileset`, *i.e.* the set of RGB images obtained after the `Scan` task.
