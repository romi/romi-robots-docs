User case scenarios for the plant scanner
=========================================
(or the biologists wish list!)

Last edited on 7 Nov 2018.

We here describe the scenario followed by a biologist experimenter to acquire and reconstruct the plant architecture using the phenotyping station or 3D scanner.

## Minimal scenario: command line interface (CLI)

We here define a minimal scenario using simple CLI to develop and test the workflow.

1. the experimenter prepares the plant if needed;
2. the plant is placed (upright) at the centre of the phenotyping station;
3. the experimenter checks the JSON file defining biological metadata
4. the experimenter starts a "circular scan" using a CLI:
    1. images are acquired and saved locally (computer controlling the 3D scanner);
    2. they are later organised using the Database API;
    3. the reconstruction is automatically started after the previous step;

## Final scenario: graphical user interface (GUI)

This is the final scenario we want to set up.

1. the experimenter prepares the plant if needed;
2. the plant is placed (upright) at the centre of the phenotyping station;
3. the experimenter login to the GUI, if not done already;
4. under the "metadata" tab, the experimenter defines the **biological metadata** related to its plan and should be able to check the used **hardware metadata**:
    1. he or she defines the **biological metadata** using predefined fields and values (should be possible to add more);
    2. he or she validates by clicking a "save" button;
5. under the "acquisition" tab, the experimenter defines the acquisition method and settings (the type of scan, number of images, ...) and initiate the acquisition:
    1. he or she defines the acquisition settings using predefined fields and values (should be possible to add more);
    2. he or she starts this step by clicking an "acquire" button;
6. under the "reconstruction" tab, the experimenter can access a list of datasets (he owns or accessible to him) and initiate reconstruction(s):
    1. he or she can select one dataset (or more?),
    2. he or she selects a 3D reconstruction method,
    3. he or she defines its settings,
    4. he or she starts this step by clicking a "reconstruct" button;
7. under the "quantification" tab, the experimenter can access a list of 3D structures (he owns or accessible to him) and initiate quantification(s):
    1. he or she can select one 3D structure (or more?),
    2. he or she selects a quantification method,
    3. he or she defines its settings,
    4. he or she starts this step by clicking a "quantify" button;

We would probably need an "OMERO" tab to:

1. select/change the "group" to which the dataset should be sent to;
2. change the URL and port (change the used OMERO database);
3. change the user logged to the OMERO database;