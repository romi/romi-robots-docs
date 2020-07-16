## The scan list page

When first opening the app, you will be greeted with a home
page displaying every available scans. 
A scan is defined as a folder containing acquisition of plant data (e.g. 2D RGB images, manual measures) and a set of 3D reconstructions and analysis (e.g. point cloud, mesh, automated measures,...)
From this page, you can search for specific keywords, order the scans by their name, date, etc.
In addition, scans can be filtered according to what data is actually available for each scan.

!!! note
    If you're a developer, you can download the metadata 
    and archives associated with each scan as well.

## The viewer

Clicking the *Open* green button next to a scan (far right of the row corresponding to a scan) to open the actual viewer and explore available data.

### The 3D reconstruction and the 3D-view panel

The largest panel on the left displays the 3D view, allowing to observe the 
reconstructed plant and navigate around with basic mouse commands (right/left click and scroll). Check the question mark (?) help icon on the bottom right corner of this panel for more description of mouse control.
Several icons appear on the top band of the 3D-view panel: they can simply be activated by clicking, hovering over provide information about their function.

Feel free to experiment with the different features and tools of the 3D view.

### The graphs

The right side consists of a measurement panels, typically displaying graphs of data related to the plant (either measurements provided as metadata or computed during the analysis).
Help tooltips explain what those graphs correspond to.
By default, phyllotaxis graphs (see below) are displayed.
The green "plus" (+) icon allow uploading more measurement panels if available. On each graph, the top right corner cross button closes the panel.

### Phyllotaxis graphs
Phyllotaxis graphs are sequences of either divergence angles (in degree) or internode length (in mm) measured between two consecutive lateral organs of the main stem, starting from the base to the shoot tip.
Hovering a graph highlights a particular interval and display the order index of the two organs lateral organs bounding this interval.
Interval hovering is synchronized between the two phyllotaxis graphs (divergence angles and internodes) if they are active. Synchronization also happen with the 3D-view panel if 'organ highlight' option is active: only the corresponding pair of organ remain visible. Changing organ colors for this pair in the 3D-view panel will also synchronized the colors in the graphs.
Clicking on a interval in the graph allow to maintain the selection active.
Download buttons at the top of each graph allow to get the data in CSV or TSV format.

### The photo carousel and camera mode

The entire bottom of the page is a line called the 'carousel': it contains images contained in the scan folder.
Click on any of the images in the carousel and the 3D-view panel will switch into the camera mode: the available 3D reconstructions will be superposed on the image, allowing to check the accuracy of the 3D reconstruction.
The image of the carousel currently displayed in the 3D-View panel is boxed. Dragging this box left/rightwards changes the active image and the 3D-view is synchronized immediatly, allowing to dynamically navigate along the original camera path of acquisition. 
If the scan folder contain several images that have been made avialable for the visualizer, the source of images can be changed. The carousel will be populated by this new source and images can be displayed into the 3D viewer by activating the camera mode.

## Reporting bugs

If you encounter some kind of unwanted behavior, or have a feature suggestion, 
head over to the [GitHub repository](https://github.com/romi/3d-plantviewer) and
write an issue!
