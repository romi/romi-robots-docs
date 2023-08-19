# General explanations & concepts

Hereafter, we introduce the general philosophy of the project, provide some high level explanations and give key concepts to understand the work we have done around the _Plant Imager_.

## Aim of the _Plant Imager_ project

Manual phenotyping, apart from bringing you closer to nature, is quite fastidious and time-consuming, and we should be better off leaving this kind of tasks to machines designed to accomplish this task.

The endgame of the _Plant Imager_ project is thus to be able to serve as a phenotyping platform, not only for _Arabidopsis thaliana_, but for -potentially- any plant that can be grown in lab conditions (meaning not trees for example).

## General idea

We sought at solving the _automatic phenotyping_ problem as follows:

1. take pictures of a plant with a robot
2. use photogrammetry algorithms to reconstruct a 3D model of the plant
3. use algorithms to extract the phenotype of the plant 


## Research oriented user story

1. The user put a plant inside the _Plant Imager_ and perform an **acquisition**, that return a set of RGB images.
2. These images are automatically uploaded to a **database**.
3. The user use a **pre-defined workflow** to reconstruct the plant and quantify its traits.
4. The user can access the acquisitions, reconstructions & quantitative data by connecting to a **visualization** server.

Ideally:

1. There is a GUI to guide the user for the acquisition process and to gather the maximum amount of metadata like authorship, plant information and so on.
2. The database is accessible remotely.
3. The reconstruction might be run on a distant server, again via a GUI.
4. The visualization server is accessible remotely.

## General philosophy

Our state of mind is that of **Open Science**, meaning to produce technology and knowledge accessible to and reproducible by everyone.

To that respect, we imposed ourselves the following "constrains":

- use an open-source programming language, libraries and algorithms (or at least free of charges)
- use affordable and "off the shelves" hardware and equipments
- publish and promote our work, so it may be reused by the community

## How it worked so far...

As for most technological development strategy, we decided to "start simple" and try to "complexify over time".

We thus chose a simple plant model to reconstruct, like _Arabidopsis thaliana_, as it has small leaves that are mostly located at the base of the plant.
This was to avoid the "occlusion problem", where large leaves would occlude the rest from the camera.

Also, we started with one RGB camera, even tough we tested several (including a depth-sensing camera), and a simple circular path around the plant to take pictures of it.

We have hand-picked and aggregated state-of-the-art technologies that met our requirements.
Some notable examples are:

- Raspberry Pi and Arduino boards to build our robot
- the `luigi` library as a workflow manager
- `Colmap` as a _Structure from Motion_ solver

We developed the missing pieces of software and designed a few algorithm along the way.

We now have a modular and flexible software design that you may learn about in the next section.