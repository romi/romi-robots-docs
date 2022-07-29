<style>.embed-container { position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden; max-width: 100%; } .embed-container iframe, .embed-container object, .embed-container embed { position: absolute; top: 0; left: 0; width: 100%; height: 100%; }</style><div class='embed-container'><iframe src='https://www.youtube.com/embed//_5Zw77hQ8Sc' frameborder='0' allowfullscreen></iframe></div>

---

The Farmers Dashboard is a farming tool that provides daily automated insights about your crop. It helps with mapping of crop beds, the location and identification of individual plants, and the extraction of their growth curves from the collected data.  

The dashboard benefits polycrop farmers and researchers. It opens up technology and practices common to industrial scale agriculture, making them accessible and useful to ecological and sustainable farmers. It relies on an automated system, data acquisition, a set of tools for [image analytics](pipeline.md), and finally, an online platform for spatial management and data visualization.

![](/assets/images/farmersDashboard/Cablebot_cover.jpg)

The data can be provided by different types of devices a Cablebot, a drone or a Rover according to the configuration of each farm. Multiple iterations were needed to achieve a powerful yet robust and low cost solution.

The Cablebot can be fixed above a crop bed using a tension cable, we can use the manual remote to correctly position the camera in order to capture all of the crops. Once set up, the cable bot will move multiple times a day across the crop bed, taking high definition images and sending them to the Romi server. The images are assembled into a unique portrait of your crop bed. After the plants are detected, a catalog of individual plants is created. By comparing them with historical data, we can obtain plant growth curves. All of the information is then combined into a weed map, which is made available on the Farmers Dashboard website. The current system is a fully automated imaging device, able to collect data on a high variety of crops.

![](/assets/images/farmersDashboard/farmers_dashboard_overview.png)

Because of the legal restrictions on the use of drones and because of the rapid evolution of the drone market, the ROMI project has decided to direct its effort to a hardware solution that complements the existing tools (commercial drones, the Rover): the Cablebot. The Cablebot is adapted for use in greenhouses and polytunnels. These installations take up more than 10% of microfarms and are ill-suited for the use of drones. This reorientation increases the impact of ROMI since we can handle a wider variety of contexts than planned. The use of drones is still an option. Existing drones can still be used in combination with the Farmer’s Dashboard. 

Nature-based solutions are becoming more and more relevant to increasing cities’ resilience and climate change adaptation. In particular green infrastructure is an emergent trend followed by new buildings worldwide. With it, there’s an emergent market of solutions to support the growth of plants in facades, rooftops and other architectural sites. One relevant task is the monitoring of those gardens, in particular in large buildings and areas with difficult access, like facades. However, the regulations affecting urban areas limit drones and other flying equipment. For that reason, the Cable Bot solution can offer a robust and autonomous solution for permanent or temporary monitoring of rooftops or even vertical gardens. Moreover, the simplicity of the installation allows the system to be set up at lower costs and even for a temporary purpose, like monitoring the plats consolidation phase for new gardens. Finally, remote monitoring of the results via the [Farmers Dashboard](app.md) simplifies the overall operation by offering precise insights and remote control capabilities.

To maximize the reuse of hardware components, the Cablebot consists of the following modules:

1. A [mobile carrier](bot.md) that can move along the cable.
2. A [camera module](camera.md) thats easily attached on the mobile carrier.
3. A fixed [charging station](station.md).

!!! info
	For convenience, when we use the term cablebot, we sometimes refer to the mobile carrier mentioned above, and sometimes to the three modules used as a whole. In general, the meaning should be clear from the context.

