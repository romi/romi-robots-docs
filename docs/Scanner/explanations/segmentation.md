Segmentation of images 
===

The segmentation of an image consists in assigning a label to each of its pixels. For the 3d reconstruction of a plant, we need at least the segmentation of the images into 2 classes: *plant* and *backround*. For a reconstruction with semantic labeling of the point cloud, we will need a semantic segmentation of the images giving one label for each organ type (e.g. {*leaf*, *stem*,*pedicel*, *flower*, *fruit*}). Figures shows describe the binary and multi-class segmentations for a virtual plant.

<figure>
<img src="/assets/images/segmentation/segmentation_ex.png" alt="Binary and multi-class segmentation examples" width="600" />
<figcaption>Example image of virtual arabidopsis (left) with binary (middle) and multi-class segmentation (right).</figcaption>
</figure>


## Binary segmentation

The binary segmentation of an image into *plant* and *background* is performed with the following command:

```bash
romi_run_task Masks scan_id --config myconfig.toml 
``` 
with upstream task being *ImagesFilesetExists* when processing the raw RGB images or *Undistorded* when processing images corrected using the intrinsic parameters of the camera. The task takes this set of images as an input and produce either binary mask or real valued maps depending on parameters. 

There are 3 methods available to compute indices for binary segmentation: Excess Green Index, Linear SVM or Vesselness. For each method, we provide an example configuration file in the *Index computation* section.

### Index computation


#### Linear support vector machine (SVM)

A linear combination of R, G and B is used to compute the index for pixel $(i,j)$:

$$
S_{ij}=w_0 R_{ij} + w_1 G_{ij} +w_2 B_{ij} 
$$

where $w$ is the *parameter* vector specified in the configuration file. A simple vector, like $w=(0,1,0)$ may be used. 

Alternatively you can train an SVM to learn those weights and the threshold to be provided in the configuration file. For this, we consider you have a sample image and a ground truth binary mask. A ground may be produced using a manual annotation tool like [LabelMe](https://github.com/wkentaro/labelme). 

Using for example a list of 1000 randomly selected pixels as $X_{train}$ and their corresponding labels as $Y_{train}$, a linear SVM is trained using
```python
from sklearn import svm

X_train, Y_train = ...
clf = svm.SVC(kernel='linear')
clf.fit(X_train, y_train)
```
the weights can then be retrieved as *clf.coef_* and the threshold as *-clf.intercept_*


##### Configuration file

```toml
[Masks]
upstream_task = "ImagesFilesetExists" # other option "Undistorted"
type = "linear"
parameters = "[0,1,0]"
threshold = 0.5
#Optional arguments
dilation = 0
query = "{\"channel\":\"rgb\"}" #This is optional, necessary when the *ImageFileset* contains multiple channels (typically when it is produced from a virtual scan)
```


#### Excess green

This segmentation method is assuming the plant is green and the background is not. It has no parameter but it may be less robust than the linear SVM.

We compute the normalized RGB values $x \in {r,g,b}$ for each pixel $(i,j)$:

$$
x_{ij} = \frac{X_{ij}}{R_{ij}+G_{ij}+B_{ij}} 
$$

where $X \in {R, G, B}$ is the red, green or blue image

Then, the green excess index is computed as:

$$
\operatorname{ExG}=2g-r-b
$$


##### Configuration file

```toml
[Masks]
upstream_task = "ImagesFilesetExists" # other option "Undistorted"
type = "excess_green"
dilation = 0
binarize = true
threshold = 0.2
query = "{\"channel\":\"rgb\"}" #This is optional, necessary when the *ImageFileset* contains multiple channels (typically when it is produced from a virtual scan)
```

### Inversion

For an index I, if you want to use $1-I$ for creating the mask, set *invert* to *True*. 


##Multi-class segmentation

The *Segmentation2D* task performs the semantic segmentation of images using a deep neural network (DNN). The command to run this task is:

```bash
romi_run_task Segmentation2D scan_id my_config.toml
```
This will produce a series of binary masks, one for each class on which the network was trained.

<figure>
<img src="/assets/images/segmentation/unet.png" alt="U-net architecture" width="600" />
<figcaption>Generic encoder/decoder architecture for semantic segmentation (U-net).</figcaption>
</figure>

The architecture of the network is inspired from the U-net [ref], with a ResNet encoder [ref]. It constists in encoding and decoding pathways with skip connections between the 2.

####Configuration File

```toml
[Segmentation2D]
upstream_task = "ImageFilesetExists" #Alternatively Undistorted
model_fileset = "ModelFileset"
model_id = "Resnet_896_896_epoch50"  # no default value
query = "{\"channel\":\"rgb\"}"  # default is an empty dict '{}'
Sx = 896 
Sy = 896
labels = "[]"  # default is empty list to use all trained labels from model
inverted_labels = "[\"background\"]"
threshold = 0.01
```


### DNN model

The neural architecture weights are obtained through training on an annotated dataset (see How to train a DNN for semantic segmentation). Those weights should be stored in the database (at `<database>/models/models`) and the name of the weights file should be provided as the *model_id* parameter in the configuration. You can use our model trained on virtual arabidopsis [here](https://media.romi-project.eu/data/Resnetdataset_gl_png_896_896_epoch50.pt)

## Binarization

A binary mask $m$ is produced from the index or from the output of the DNN, *I*, by applying a threshold $\theta$ on I for each pixel $(i,j)$:

\begin{equation}
  m_{ij} =
    \begin{cases}
      255 & \text{if $I_{ij}>\theta$}\\
      0   & \text{otherwise}
    \end{cases}       
\end{equation}


## Dilation

If the integer *dilation* parameter is non-zero a morphological dilation is apllied to the image using the function [*binary_dilation*](https://scikit-image.org/docs/dev/api/skimage.morphology.html#skimage.morphology.binary_dilation) from the *skimage.morphology* module. 

The *dilation* parameter sets the number of times *binary_dilation* is iteratively applied. For a faithful reconstruction this parameter should be set to $0$ but in practice you may want to have a coarser point cloud. This is true when your segmentation is not perfect, dilation will fill the holes or when the reconstructed mesh is broken because the pôint cloud is too thin.
