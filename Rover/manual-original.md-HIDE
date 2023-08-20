<!-- Copy and paste the converted output. -->


<p style="color: red; font-weight: bold">>>>>>  gd2md-html alert:  ERRORs: 0; WARNINGs: 1; ALERTS: 28.</p>
<ul style="color: red; font-weight: bold"><li>See top comment block for details on ERRORs and WARNINGs. <li>In the converted Markdown or HTML, search for inline alerts that start with >>>>>  gd2md-html alert:  for specific instances that need correction.</ul>

<p style="color: red; font-weight: bold">Links to alert messages:</p><a href="#gdcalert1">alert1</a>
<a href="#gdcalert2">alert2</a>
<a href="#gdcalert3">alert3</a>
<a href="#gdcalert4">alert4</a>
<a href="#gdcalert5">alert5</a>
<a href="#gdcalert6">alert6</a>
<a href="#gdcalert7">alert7</a>
<a href="#gdcalert8">alert8</a>
<a href="#gdcalert9">alert9</a>
<a href="#gdcalert10">alert10</a>
<a href="#gdcalert11">alert11</a>
<a href="#gdcalert12">alert12</a>
<a href="#gdcalert13">alert13</a>
<a href="#gdcalert14">alert14</a>
<a href="#gdcalert15">alert15</a>
<a href="#gdcalert16">alert16</a>
<a href="#gdcalert17">alert17</a>
<a href="#gdcalert18">alert18</a>
<a href="#gdcalert19">alert19</a>
<a href="#gdcalert20">alert20</a>
<a href="#gdcalert21">alert21</a>
<a href="#gdcalert22">alert22</a>
<a href="#gdcalert23">alert23</a>
<a href="#gdcalert24">alert24</a>
<a href="#gdcalert25">alert25</a>
<a href="#gdcalert26">alert26</a>
<a href="#gdcalert27">alert27</a>
<a href="#gdcalert28">alert28</a>

<p style="color: red; font-weight: bold">>>>>> PLEASE check and correct alert issues and delete this message and the inline alerts.<hr></p>




<p id="gdcalert1" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image1.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert2">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image1.png "image_tooltip")


Romi Rover


# **User Manual**



<p id="gdcalert2" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image2.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert3">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image2.png "image_tooltip")


**Draft - September 2020** 

© Sony Computer Science Laboratories - CC BY-SA 4.0 License

ROMI has received funding from the European Union's Horizon 2020 research and innovation programme under grant agreement No 773875.

 \


This manual describes the usage of a fully assembled and ready to use rover. The information on how to build your own rover can be found in a separate document. Visit the ROMI web site at [https://docs.romi-project.eu](https://docs.romi-project.eu) for more information.


# Short description


```
The ROMI Rover is a farming tool that assists vegetable farmers in maintaining the vegetable beds free from weeds. It does this by regularly hoeing the surface of the soil and thus preventing small weeds from taking roots. It can do this task mostly autonomously and requires only minor changes to the organization of the farm. It is designed for vegetable beds between 70 cm and 120 cm wide (not including the passage ways) and currently handles two types of crops, lettuce and carrots. The lettuce can be planted out in any layout, most likely in a quincunx pattern. In this configuration the rover uses a precision rotary hoe to clean the soil both between the rows and the plants. For the carrots, the rover uses classical mechanical tools, such as stirrup hoe, to regularly clean the soil in between the rows. In this configuration, the carrots should be sown in line. 
A weekly passage of the robot should be sufficient to keep the population of weeds under control.
In addition to the weeding, the rover provides the following useful functions. It can draw quincunx patterns or straight lines in empty vegetable beds to speed up seeding and planting out. The embedded camera can be used to collect images of the vegetable beds. It can also be used as a motorized  tray.
The ROMI Rover is targeted at farms that grow lettuce and carrots on a relatively small surface, between 200 m² and 5 ha (Utilized Agricultural Area).
```



# 


# Table of Content


[TOC]



```
Legend
V2 The feature will be implemented in the second prototype (deadline: December 2020)
V2 The feature refers to the second prototype and will be different in the third prototype. 
V3 The feature will be implemented in the third prototype (deadline: May 2021).
V3 The feature refers to the third prototype and exists in a different form in the second prototype. 
```



# 


# Technical specifications


<table>
  <tr>
   <td><strong>Size V3</strong>
<p>
(Width x Length x Height)
   </td>
   <td>Min.: 1.45 m x 1.60 m x 1.46 m 
<p>
Max.: 1.70 m x 1.60 m x 1.46 m
   </td>
  </tr>
  <tr>
   <td><strong>Weight V2</strong>
   </td>
   <td>80 kg (estimate)
   </td>
  </tr>
  <tr>
   <td><strong>Battery life V3</strong>
   </td>
   <td>8 h (TODO: that’s the target)
   </td>
  </tr>
  <tr>
   <td><strong>Charging time</strong>
   </td>
   <td>TODO
   </td>
  </tr>
  <tr>
   <td><strong>Weeding speed</strong>
   </td>
   <td>Precision weeding: 600 m²/day <strong>V3   </strong>(235 m²/day <strong>V2</strong>)
<p>
Classical weeding: 7200 m²/day <strong>V3 </strong>(6400 m²/day <strong>V2</strong>)
   </td>
  </tr>
  <tr>
   <td><strong>Width vegetable beds V3</strong>
   </td>
   <td>Min.: 0.70 m
<p>
Max.: 1.2 m
   </td>
  </tr>
  <tr>
   <td><strong>Handled crops</strong>
   </td>
   <td>Precision weeding: Lettuce
<p>
Classical weeding: Carrots
   </td>
  </tr>
  <tr>
   <td><strong>Turning space at end of bed</strong>
   </td>
   <td>2 m (TODO: verify)
   </td>
  </tr>
</table>



# Functional specifications and requirements

The following configuration is required for the use of the ROMI rover. 


<table>
  <tr>
   <td>
   </td>
   <td><strong>Profile</strong>
   </td>
   <td><strong>Price</strong>
   </td>
   <td><strong>Features/Function</strong>
   </td>
  </tr>
  <tr>
   <td><strong>Bed of vegetables </strong>
   </td>
   <td colspan="3" >Width of the bed: 
<ul>

<li>min 0.7 m 

<li>max 1.2 m <strong> V3</strong>
</li>
</ul>
   </td>
  </tr>
  <tr>
   <td><strong>Handled crops </strong>
   </td>
   <td colspan="3" >
<ol>

<li><strong>Lettuce</strong>: The lettuce can be planted out in any layout, most likely in a quincunx pattern

<li><strong>Carrots</strong>: The carrots should be sown in line.
</li>
</ol>
   </td>
  </tr>
  <tr>
   <td><strong>ROMI rover with a remote control, a battery charger, and a protective cover</strong>
   </td>
   <td>

<p id="gdcalert3" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image3.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert4">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


<img src="images/image3.png" width="" alt="alt_text" title="image_tooltip">
<strong> V3</strong>
<p>


<p id="gdcalert4" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image4.jpg). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert5">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


<img src="images/image4.jpg" width="" alt="alt_text" title="image_tooltip">

<p>


<p id="gdcalert5" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image5.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert6">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


<img src="images/image5.png" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>5000 € (estimate)
   </td>
   <td>
<ul>

<li>Prevents weed development

<li>Draw patterns for seeding and planting out

<li>Takes image scans of the beds
</li>
</ul>
   </td>
  </tr>
  <tr>
   <td><strong>Tools carrier</strong>
   </td>
   <td>Photo
   </td>
   <td>1000 €
<p>
(estimate)
   </td>
   <td>Used with the rover to carry the mechanical weeding tools (optional but needed in most configurations)
   </td>
  </tr>
  <tr>
   <td><strong>Mechanical weeding tools (from Terrateck or other manufacturers)</strong>
   </td>
   <td>

<table>
  <tr>
   <td>

<p id="gdcalert6" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image6.jpg). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert7">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


<img src="images/image6.jpg" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>

<p id="gdcalert7" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image7.jpg). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert8">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


<img src="images/image7.jpg" width="" alt="alt_text" title="image_tooltip">

   </td>
  </tr>
  <tr>
   <td>

<p id="gdcalert8" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image8.jpg). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert9">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


<img src="images/image8.jpg" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>

<p id="gdcalert9" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image9.jpg). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert10">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


<img src="images/image9.jpg" width="" alt="alt_text" title="image_tooltip">

   </td>
  </tr>
</table>


   </td>
   <td>400-1000€ (estimate)

   </td>
   <td>The weeding tools that will be fixed on the tool carrier. Sold by other manufacturers, for example, by [Terrateck](https://www.terrateck.com) ([catalogue](https://www.terrateck.com/en/16-houes-pousse-pousse))

   </td>
  </tr>
  <tr>
   <td>**TOTAL cost of an equipped rover**

   </td>
   <td>
   </td>
   <td>6400 – 7000 €

   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>**Guides**

   </td>
   <td>Photo

   </td>
   <td>Stainless steel tubes (45x1.5): 3 €/m

Tuyau irrigation PE HD 50mm : 4.4 €/m

   </td>
   <td>The guides consist of either stainless metal tubes (preferred) or wooden boards. They facilitate the navigation of the rover along the bed so that it can operate accurately and reliably. 

   </td>
  </tr>
  <tr>
   <td>**A mobile phone**

   </td>
   <td>

<p id="gdcalert10" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image10.jpg). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert11">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image10.jpg "image_tooltip")


   </td>
   <td>Existing phone: 0€

Dedicated phone: 200 €

   </td>
   <td>


*   Used to control the rover
*   To browse the archived images of the online service	
   </td>
  </tr>
  <tr>
   <td>
**WiFi**

   </td>
   <td>

<p id="gdcalert11" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image11.jpg). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert12">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image11.jpg "image_tooltip")


   </td>
   <td>Rover as hotspot: 0 €/month

Existing WiFi: 0 €/month

GSM WiFi router: 120€ (router) + 10 €/month (SIM card)

   </td>
   <td>WiFi connectivity in the field 



*   To connect the mobile phone to the rover (required)
*   To archives the images taken by the rover (optional)
*   To provide remote assistance (optional)
   </td>
  </tr>
  <tr>
   <td>
**Romi Online Service V3**

   </td>
   <td>

<p id="gdcalert12" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image12.jpg). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert13">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image12.jpg "image_tooltip")


   </td>
   <td>1 €/month

   </td>
   <td>Monthly fee for the use of the Romi remote server (optional):



*   To archive and browse the images taken by the rover
*   To receive remote assistance
   </td>
  </tr>
  <tr>
   <td>
**Training**

   </td>
   <td>
   </td>
   <td>70 €/day

   </td>
   <td>Two days of training for the rover (optional)

   </td>
  </tr>
  <tr>
   <td>**Preprogramming according to the configuration of the farm**

   </td>
   <td>
   </td>
   <td>50 €

   </td>
   <td>Assistance to fine-tune the rover’s configuration to the farm (optional)

   </td>
  </tr>
  <tr>
   <td>**Maintenance costs**

   </td>
   <td>
   </td>
   <td>5 €/month/rover

   </td>
   <td>Maintenance contract with the ROMI association (or a local distributor) (optional)

   </td>
  </tr>
</table>


 


## Examples for different farm sizes

<span style="text-decoration:underline;">For an urban farm of 5 000 m2 (lettuces or carrots)</span>



*   83 beds of 50 meters (beds of 80 cm wide, pathway of 40 cm between beds, 3320 m² cultivated)
*   4150 meters of guides (12 450 €…)
*   1 rover with tool carrier and mechanical weeding tools (7000 €)

**Investment costs: 7000 to 7510 + 12450 € + 16 €/months (optional: SIM card, remote maintenance, server archiving)**

<span style="text-decoration:underline;">For a vegetable farm of 2 ha</span>



*   124 beds of 100 meters (beds of 1.1 m wide, pathway of 0.50 m between beds, 13640 m² cultivated)
*   12 400 meters of guides (37.2 k€)

Lettuces (180 000 plants, 54 k€-129 k€ revenu):



*   4 rovers
*   **Investment costs: 20.5 k€ + 37.2 k€ + 10 to 31 €/months (wifi and maintenance)**
*   Alternative solution: Plastic mulching film:** **12 x 226,50 € = 2712 €/year [[REF](https://www.serresvaldeloire.com/films-salade-et-semi-forcage/588-film-paillage-salade.html#/rouleau-140_m_x_1071_m_14_trous)]

Carrots (1.24M plants, 60-130 tonnes, 31k€-130k€ revenue)



*   1 rover
*   **Investment costs: 7000 to 7510 € + 49.6 k€ + 10 to 16 €/months (wifi and maintenance)**

Sur carottes, l’ensemble des opérations de désherbage varie de 120 à plus de 900 heures/ha. [[http://itab.asso.fr/downloads/fiches-lpc/lpc-carotte.pdf](http://itab.asso.fr/downloads/fiches-lpc/lpc-carotte.pdf)] 

Prix [[https://rnm.franceagrimer.fr/prix?CAROTTE&12MOIS](https://rnm.franceagrimer.fr/prix?CAROTTE&12MOIS)] 

<span style="text-decoration:underline;">For a vegetable farm of 5 ha</span>



*   XXX beds
*   XXX meters of guides
*   XXX rovers

**Investment costs: XXX € + €/months (wifi and maintenance)**

It has to be pointed out that in many countries, there are public financial supports for farmers which want to invest in robotics.


# Operation instructions


## **Overview of the components **V3


<table>
  <tr>
   <td>

<p id="gdcalert13" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image13.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert14">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


<img src="images/image13.png" width="" alt="alt_text" title="image_tooltip">

   </td>
  </tr>
  <tr>
   <td>Figure 1: The main components of the rover.
   </td>
  </tr>
</table>


TODO: Motor lock lever, Carrier tool, Carrier tool clamp, Control panel, Protection cover, Top camera, Recharging plug, Motor sockets (power & data), CNC socket (power & data), Tool carrier socket (power & data), Components inside the electronics box.


## **Overview of the rover’s usage**

The basic usage of the rover is to position it on a vegetable bed and let the machine clean the top-soil with a rotating precision hoe. The rover must be taken to the field using the remote control or by simply pushing it. The robot expects the vegetables to be grown in “beds” of 0.7 to 1.2 m wide **V3**. The robot is designed for smaller market farms of less than 5 ha but the size of the farm depends on the number of rovers that you will use, and the amount of crop you want to cover. To assist the rover in navigating along a bed, it is necessary to install rails (tubes or wooden boards) along the bed. Without the rails, the risk exists that the rover deviates from its course and drives into the vegetable bed.

Once the rover is positioned along the rails in the beginning of a bed, it hoes the surface of the soil so that small weeds cannot take roots. It can perform this action all along the length of the bed. Note that the rover cannot remove mature weeds that have already established themselves. It is therefore necessary to start with a vegetable bed that has been cleaned from all weeds. This can be done with various classical techniques to prepare the vegetable beds. Once the beds are clean, the rover can be used to keep them clean.

Two weeding methods are available. First, a precision weeding method in which the top-soil is turned over in between the plants and the rows. Second, a classical weeding method in which standard weeding tools are pulled between the rows of vegetables.

For the precision weeding method, the rover uses a camera to detect the plants that are underneath the rover. It then moves the precision weeding tool over the surface whilst passing closely around the detected vegetables. 

Although the rover is autonomous for weeding a single bed, it is important to stay in proximity of the rover. You must also manually perform the U-turn at the end of the bed and reposition the rover on the rails of the next bed. 


## **Setting up the vegetable beds**

The use of the rover requires relatively flat beds. The precision weeding works best if the surface of the culture beds is flat. Ideally, the alleys between the beds should be flat, too, to facilitate the navigation of the rover. The precision weeding tool can mechanically adjust in height for small deviations in the soil level but there is less risk that the tool will detach from the soil or that it will dig into the soil when care has been taken to level the surface. There is no precise measure of how flat the beds should be but small holes in the ground should be avoided. The presence of stones should also be avoided. Small stones (approx. 1 cm) should not perturb the rover very much.

NOTE: The width of the vegetable beds should be constant so that the width of the rover remains the same for all the beds. 


## **Laying out the rails**

The rails guide the wheels and allow the rover to navigate straight wards. It greatly increases the reliability of the navigation and the precision of the rover. We recommend the use of stainless-steel tubes with a diameter of approximatively 5 cm and thickness of 1.5 mm. 

There are two options to lay out the tubes. 

<span style="text-decoration:underline;">A rail on both sides of the bed</span>: The most intuitive organisation is to place a tube on each side of the bed. The tubes should be positioned on the edge of the bed, one on each side, along the length of the bed. A bed of 10 m long will require 20 m of tubes. Care should be taken to assure that the tubes are parallel. There is no recommended method for fixing the rails in the soil so they remain in place. A simple solution is to drill a hole in the end of the tube and fix the tube in the soil using reinforcing bars (steel wire used to reinforce concrete).   


<table>
  <tr>
   <td>

<p id="gdcalert14" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image14.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert15">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


<img src="images/image14.png" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>

<p id="gdcalert15" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image15.jpg). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert16">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


<img src="images/image15.jpg" width="" alt="alt_text" title="image_tooltip">

   </td>
  </tr>
  <tr>
   <td colspan="2" ><em>Figure 2: Left: The rover with two tube rails on each side of the bed. Right: Two stainless steel tubes fixed to the ground with a “staple” of reinforcement steel wire</em>
   </td>
  </tr>
</table>


<span style="text-decoration:underline;">Two rails every two beds</span>: In the second organisation, two rails are positioned every two beds. The rails are laid in parallel in the same alley in between two beds. The spacing between the two tubes must be such that they fit the width of the front and rear wheel. In effect, the tubes squeeze the two wheels of one lateral side of the rover. The two wheels on the other side of the rover run freely. The tubes should be centred in the middle of the alley such that one pair can be used for two beds, on either side of the rails. Two beds of 10 m long (20 m total) will require 20 m of tubes, or twice less than when using rails on both sides of the bed.


<table>
  <tr>
   <td>

<p id="gdcalert16" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image16.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert17">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


<img src="images/image16.png" width="" alt="alt_text" title="image_tooltip">

   </td>
  </tr>
  <tr>
   <td><em>Figure 3: The rover with a stainless tube on each side of the wheel.</em>
   </td>
  </tr>
</table>



<table>
  <tr>
   <td>

<p id="gdcalert17" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image17.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert18">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


<img src="images/image17.png" width="" alt="alt_text" title="image_tooltip">

   </td>
  </tr>
  <tr>
   <td><em>Figure 4: A comparison of the two options for laying out the rails. Left: two rails be bed. Right: two rails for every two beds.</em>
   </td>
  </tr>
</table>


An alternative option is to use wooden boards instead of steel tubes. This solution is less optimal because the wheels tend to get stuck when they slide against the angular edge of the board. The boards can be stuck partially in the ground with about 5 cm sticking out to guide the wheels.

The use of plastic tubes, for example PVC or polyethylene irrigation tubes, can also be considered.

The width of the rover must be adjusted so that the wheels roll along the outside of the rails (see “**Adjusting the width of the rover”**). There must be no space between the wheels and the tubes.


## **Maximizing the use of rails (TODO)**

To reduce the number of rails to be purchased, it is possible to buy 1/5<sup>th</sup> of the total amount and displace the rails every day. (TODO: How long does it take to place the rails?)


## **Setting up the Wi-Fi access point**

The use of a Wi-Fi access point is optional but strongly recommended. The rover must be connected to a Wi-Fi access point with Internet access for the following functionalities:



*   To automatically upload the images taken by the rover to the Farmer’s Dashboard web application.
*   For remote maintenance.

Both features are optional and can be left out when the rover is used for weeding only. 

However, if you decide to use an access point, it is important that the Wi-Fi signal is strong enough in all the zones where the rover will be used. If not, it may be impossible to connect to the rover’s web interface with a phone or tablet to the rover to send instructions to the rover. It will still be possible to send instructions to the rover using the control panel (see “**Controlling the rover through the control panel**”).

The set-up of the Wi-Fi network is not part of the Romi Rover package. In case of doubt, you should seek advice from a professional about the best solution for your premises. However, below, we briefly discuss several options.

<span style="text-decoration:underline;">Using an existing Wi-Fi router</span>: If the zone where you wish to use the rover is adjacent to existing infrastructure (home, barn) and you have the possibility to install an Internet connection at the premises (ADSL modem over a phone line or any other solution), the Wi-Fi capabilities of the modem can be used to offer Internet access to the rover.

<span style="text-decoration:underline;">Expand the reach of an existing Wi-Fi network</span>: An existing Wi-Fi can be extended to increase its reach using Wi-Fi range extenders. They pick up and retransmit an existing Wi-Fi signal. Most extenders require a standard power supply although some can be powered using an USB battery. Using an Ethernet cable of up to 100 meters long, it is possible to position a secondary access point. Some of the Wi-Fi access points can be powered directly over the Ethernet cable (PoE, Power over Ethernet) removing the need for a power socket. It is also possible to send the network signal over existing electricity cables using a technology called power-line communication (PLC). Finally, there exist also long-range wireless outdoor WiFi extenders that transmit the network between two antennas designed for transmission over distances from a 100 meters to over a kilometer. 

<span style="text-decoration:underline;">Install a GSM Wi-Fi router</span>: If there is a good mobile phone signal strength in the field, a GSM Wi-Fi router is a viable option. A GSM Wi-Fi router connects to the Internet over mobile data link (GPRS, EDGE, 3G, HSDPA, 4G, …) and provides access to other devices over Wi-Fi. Separate routers with good antennas can be purchased at reasonable prices but generally require a power plug. Smaller, USB-powered routers are available also and can be plugged directly into a USB port inside the rover. A mobile phone configured as a hotspot is an alternative solution (although with a smaller range than a dedicated router with good antennas). The downside of this option is that it requires a SIM card and a subscription with a mobile network operator.

<span style="text-decoration:underline;">Using a USB GSM modem</span>: In contrast to the solution above, a USB GSM modem is not a stand-alone router but, when plugged in, the Raspberry Pi will see the modem as an additional network interface. The rover remains the hotspot for the Wi-Fi network and will route any Internet traffic through the GSM data connection. This solution may require additional changes to the network configuration of the Raspberry Pi.


## **Charging the rover**

The rover uses two 12 V Lithium batteries (the internal working voltage is 24 V). Use the supplied Victron Energy Blue Smart IP67 24V 5A Charger to reload the batteries. Plug 230 V side of the charger in a regular power plug. The 24 V side must be plugged into the POWER CHARGER plug on the battery box. The charger has LED indicators to show the status of the charging cycle. It is also possible to follow the status using a mobile phone using a Bluetooth connection. Check the official manual provided by Victron Energy charger for details.  


## **Protection cover**

The rover comes with a PVC protection cover. The cover must always be placed on the rover when the precision weeding is used. If the precision weeding is not used, it can be removed if there is no risk of the CNC becoming wet. The CNC, on its own, is not waterproof. If the CNC is removed, it is possible to use the rover without cover in light rain conditions (TODO: IP level?...)


## Disassembling and reassembling the rover (V3) 

The rover can be disassembled into its main components. This is useful for transport. 

CAUTION: This should be done by two people.

CAUTION: Unplugging the power cables when the rover is on may cause sparks and may damage the rover’s control circuits. 



1. Make sure the rover is powered off.
2. Take off the protective cover.
3. Unplug all the cables on both boxes.
4. Untighten the screws of the arcs and of the top bar and remove them.
5. Remove the pins that fix the CNC to the main frame and remove the CNC. 
6. Untighten the U-brackets of the wheel modules and remove them.

Following the steps above, the main components are now separated: two wheel modules, the main frame, the CNC, the top bars, the arcs, and the protective cover.


## **Adjusting the width of the rover** (V3) 

The wheel-base of the rover can be adjusted to fit the width of the rails and beds. Loosen the four U-brackets (see Figure 1) that fix the wheel modules to the main frame and slide the wheel modules to the desired position. Assure that the position of the modules is symmetric relative to the main frame. 

After a change to the width of the wheel-base, the CNC must be calibrated (see “**Calibrating the CNC**”)


## Adjusting the height of the rover (V3) 

TODO


## Attendance (TODO: regulations?)

IMPORTANT: The rover must be used only in the presence of an operator (TODO). The operator must be within a distance of XXX meters of the rover and must be able to reach the rover quickly in case of an emergency (TODO). The operator must carry the remote control with her at all times when the rover is On in order to be able to recover the navigation control of the rover in all circumstances (TODO: add emergency button on the remote control). The rover should not be used in proximity to people who have not been instructed to use the rover (TODO). 

IMPORTANT: The rover must be used only during the day in good light conditions.


## Storage

The rover should be kept in a covered and not too humid space when not in use.


## Emergency button

The emergency button on the back of the rover can be used to cut the power to the motors and CNC at any time. To cut the power, push the red button. To power up the motors, the button must be reactivated. This can be done by pulling the button out again. 

CAUTION: Before reactivating the button, make sure that the CNC and wheel motors are not moving (TODO: how?…) 


## Engaging/disengaging the motor lock levers (freewheeling mode and drive mode)

The two wheel motors each have a lock lever that allows them to switch between freewheeling mode or motor drive mode. When the lock lever is in the horizontal position the wheels are freewheeling. In freewheeling mode, the robot can be moved simply by pushing it. Turn the lever 90° into the vertical position to switch the drive mode. In the drive mode, the wheels are powered by the motors and to move the rover you must use the remote control or the command interface.  

CAUTION: Only switch to the drive mode when the rover is “off” to assure that the motors are powered off. (TODO: is there no simpler way to power off the motors without shutting down the rover?)


<table>
  <tr>
   <td>

<p id="gdcalert18" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image18.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert19">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


<img src="images/image18.png" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>

<p id="gdcalert19" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image19.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert20">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


<img src="images/image19.png" width="" alt="alt_text" title="image_tooltip">

   </td>
  </tr>
  <tr>
   <td><em>Figure 5:<strong> Lock lever horizontal</strong>: Freewheeling mode </em>
   </td>
   <td><strong><em>Lock lever vertical: Motor drive mode</em></strong>
   </td>
  </tr>
</table>



## The control panel

The control panel provides a means to turn the rover on or off, and to view status messages. 


<table>
  <tr>
   <td>

<p id="gdcalert20" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image20.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert21">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


<img src="images/image20.png" width="" alt="alt_text" title="image_tooltip">

   </td>
  </tr>
  <tr>
   <td><em> Figure 6: The control panel</em>
   </td>
  </tr>
</table>


It has a display and five buttons, including the On/Off button. Please skip to the section “**Controlling the rover through the control panel**” for more information on how to use the control panel.


## Control panel state message

The display of the control panel is divided in two lines. The upper line shows current status of the rover:


<table>
  <tr>
   <td><strong>State display</strong>
<p>
<strong> (1<sup>st</sup> line)</strong>
   </td>
   <td><strong>Description</strong>
   </td>
  </tr>
  <tr>
   <td><strong><code>... </code></strong>
   </td>
   <td>The control panel has been powered up and is initializing.
   </td>
  </tr>
  <tr>
   <td><strong><code>Off</code></strong>
   </td>
   <td>The on-board computer is powered down and the motors are off. 
   </td>
  </tr>
  <tr>
   <td><strong><code>Starting up</code></strong>
   </td>
   <td>The on-board computer is starting up. The power to the motors is cut.
   </td>
  </tr>
  <tr>
   <td><strong><code>On</code></strong>
   </td>
   <td>The rover is ready for use. The on-board computer is running and the motors can be powered up.
   </td>
  </tr>
  <tr>
   <td><strong><code>Shutting down</code></strong>
   </td>
   <td>The power to the motors has been cut and the on-board computer is shutting down.
   </td>
  </tr>
  <tr>
   <td><strong><code>Error</code></strong>
   </td>
   <td>The rover is in an error state. 
   </td>
  </tr>
</table>



## **Start-up procedure**

Before starting up, the rover should be in the following state:



1. Verify that the emergency button is deactivated (pushed in).
2. Verify that the rover is off (the control panel display shows “**<code>Off</code></strong>”). If not …see “XXX”
3. Verify that the lock levers on the motor are disengaged to put the motors into freewheeling mode.

The start-up can now proceed:



4. Engage the lock levers on the motor to put the motors into drive mode.
5. Activate the security button by pulling it out. 
6. Turn the rover on by holding the on/off button pressed for 5 seconds (see Fig. 1). At that point, the rover begins the start-up sequence and the display says “**<code>Starting up</code></strong>”. When the start-up is completed, the display will show “<strong><code>On</code></strong>”. 
7. The motors of the wheels and the CNC are now powered up. 

The start-up is now finished. You can either do the following:



8. If it is the first usage of the rover, you should go to the section “**First time configuration**”.
9. You can use the remote control to move the rover (see “**Remote control mode and software control mode**”), or
10. Use the control interface to send commands to the rover (see “**Controlling the rover through the control panel**”).


## **Shut-down procedure**

To turn off the rover, press the On/Off button for 5 seconds. The display will briefly display the message “**<code>Shutting down</code></strong>”, followed by the message “<strong><code>Off</code></strong>”.


## **Switching from drive to freewheeling mode **

When the rover is in drive mode (motors powered on, the lock levers on the motor engaged/vertical), it is possible to go to freewheeling mode as follows:



1. Turn off the power of the motors by pressing the red emergency button.
2. Turn the motor lock levers in the horizontal position (disengaged).

Once these steps are completed, you can move the rover by pushing it.


## **Switching from freewheeling to drive mode **

To switch from freewheeling to drive mode, the rover’s state should be ”On”. Then do the following operations:



1. Assure that the motors are not moving by sending a STOP command (TODO).
2. Turn the motor lock levers in the vertical position (engaged).
3. Pull the red security button to power the motors.

CAUTION: Make sure that the speed and direction controllers of the remote control are in the neutral position.


## **First time configuration (**V2**)**

To configure the robot, you need a mobile phone, tablet, or computer with Wi-Fi capabilities, a recent web browser (see “**Supported web browsers**”) and a screen of minimum 320x240 (TEST) pixels. 

Connect your device to the “Romi” wireless network, using the password “rover”. Once you are connected, open a web browser and navigate to the page [https://romirover.local](https://romirover.local). 


## **The configuration page of the rover (**V2**)**


<table>
  <tr>
   <td>

<p id="gdcalert21" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image21.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert22">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


<img src="images/image21.png" width="" alt="alt_text" title="image_tooltip">

   </td>
  </tr>
  <tr>
   <td>Figure 2: The configuration page.
   </td>
  </tr>
</table>


This page will be shown on the first connection to the rover’s web address, or when you select the “Configuration” button in the main page on subsequent access to the rover’s interface. 

The configuration page lets you:



*   Change the password of interface
*   Change the name of the rover
*   Change the WiFi settings
*   Change the settings for the Farmer’s Dashboard.


## **Changing the password of the interface (**V2**)**

The first thing you should do is change the default password to something more secure but still easy to remember. 


## **Changing the rover’s name and address (**V2**)**

The name of the rover can remain unchanged unless you have several rovers. In that latter case, you should give each a distinct name in order to access the web interface of each. In the configuration page you can enter the following two strings:



*   Short name: A short string that satisfies the following constraints: minimum 5 characters and maximum 32 characters long, only letters (a-z, A_Z), digits (0-9), and the underscore character (_) are allowed. The name should start with a letter. 
*   Name: A free-form name of maximum 64 characters.

When the name of the rover is changed, the address of the web interface will change to [https://NEWNAME.localhost](https://NEWNAME.localhost). The value of NEWNAME must be replaced with the short name you have given to the rover. This change will be active after the rover has been turned off and then turned on again.


## **Using a Wi-Fi access point / Enabling Internet access (**V2**)**

To change the Wi-Fi configuration, open the web page [https://romirover.local](https://romirover.local)  (TODO: does Raspian use Rendez-Vous/Avahi by default?) (or its new location, see “**Changing the rover’s name and address**”). In the configuration page, check “Use access point” and enter the name of the Wi-Fi network (the SSID) and the password. 

In case the rover fails to connect to the access point, the configuration will revert to the default configuration that initializes the rover as a local access point. (TODO: verify/configure with Raspian, similar to Ubuntu)


## **Verifying the Wi-Fi connection (**V3**)**

If the Wi-Fi fails to connect, the control panel will display “No network”. In that case, please verify the network name and password as in the previous section.

This status message is not a problem and can be ignored if this happens occasionally, for example, when the rover is far away from the access point. As soon as the rover will be in proximity of the access point, the connection will be re-established. If the message continues to appear when the rover is in proximity of the access point and after the rover has been turned off and on again, then you should verify the Wi-Fi configuration. 


## **Connecting a phone, tablet, or computer to the rover**

Adapt the Wi-Fi settings of the device such that it connects to the same Wi-Fi network as the rover. The interface of the rover is accessible through a web browser. On the mobile device, open up your preferred web browser (see “**Supported web browsers**”) and in the address field enter the following URL: [https://ROVER_SHORT_NAME.local](https://ROVER_SHORT_NAME.local).  By default, the ROVER_SHORT_NAME is “romirover”. If you changed the name of the rover, you must use the new short name instead (see “**Changing the rover’s name and address**”).

To facilitate the access to the interface, you can add the address to your bookmarks.


## **Moving the rover to the field**

The rover can be moved to the field either by simply pushing it with the motors in the freewheeling mode or by using the remote control to steer the rover. 

CAUTION: When you use the remote controller, you must stay close to the rover (less than 3m away?). TODO: regulations?


## **Positioning the rover on a vegetable bed**

Manually push the rover onto the beginning of the vegetable bed. Make sure that the front wheels (caster wheels) and the rear wheels slide nicely along the rails of the bed.


## **Remote control mode and software control mode**

The navigation of the rover can be controlled either by the remote control or by the rover’s software. 

TODO: Must add an indicator to know what mode the rover is in. 

TODO: How do we switch from one to another mode?


## **Emergency control recovery with the remote control**

When the rover is in software control mode it is possible at any time to switch back to remote control mode by pushing the speed or direction controller to the maximum position. The rover will stop and remain immobilized for 3 seconds before listening to the commands of the remote control again. 


## **Using the remote control**

The rover comes with the Spektrum STX3 remote controller (RC). 


<table>
  <tr>
   <td>

<p id="gdcalert22" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image22.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert23">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


<img src="images/image22.png" width="" alt="alt_text" title="image_tooltip">

   </td>
  </tr>
  <tr>
   <td><em>Figure 7: The remote control.</em> 
   </td>
  </tr>
</table>


The RC’s steering wheel lets you define the direction in which the rover moves. The trigger lets you set the speed, both backward and forward (TODO: is this true with this controller?).

Please check the Spektrum STX3 official user manual for detailed information on its use.

The RC is powered by 4 AA batteries.


## **Calibrating the CNC-**to-Camera mapping (V2)

The weeding algorithm must be able to map the position of a pixel in the image to a XY coordinate of the CNC. The following steps 

Replace weeding tool with

TODO


## Change the weeding tool head

Pin


## **Controlling the rover through the control panel** (V2)

You can send commands to the rover using the control panel as follows. 


<table>
  <tr>
   <td>

<p id="gdcalert23" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image23.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert24">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


<img src="images/image23.png" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>MAIN SCREEN
<p>
The rover must be in the On state. Then press the MENU button.
   </td>
  </tr>
  <tr>
   <td>

<p id="gdcalert24" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image24.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert25">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


<img src="images/image24.png" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>MENU SCREEN
<p>
The name of the first task will appear on the bottom line of the display. Use the UP and DOWN buttons to navigate in the list of possible tasks. To cancel and return to the main screen, press MENU.
   </td>
  </tr>
  <tr>
   <td>

<p id="gdcalert25" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image25.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert26">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


<img src="images/image25.png" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>To start the task, press the SELECT button. To return to the menu screen, press MENU.
   </td>
  </tr>
  <tr>
   <td>

<p id="gdcalert26" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image26.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert27">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


<img src="images/image26.png" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>CONFIRM SCREEN
<p>
Press the SEL button a second time to confirm the action, or press MENU to cancel the start of the action and return to the menu screen.
   </td>
  </tr>
  <tr>
   <td>

<p id="gdcalert27" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image27.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert28">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


<img src="images/image27.png" width="" alt="alt_text" title="image_tooltip">

   </td>
   <td>PROGRESS SCREEN
<p>
If the action is confirmed, the display will show the progress status. When the task is finished, the display will return to the main screen.
   </td>
  </tr>
</table>



## **Controlling the rover through the web interface**

The web interface is a convenient way to send commands to the rover.  The interface consists of large buttons to facilitate its use on a mobile phone in the field. The buttons and associated actions are programmable (see “**Editing the rover scripts**”). By default, a couple of generic buttons are provided (see Fig. 3). When you press a button, a confirmation will be asked to avoid launching an action inadvertently. Upon confirmation, a progress screen will be shown with information on the advancement of the action. 


<table>
  <tr>
   <td>

<p id="gdcalert28" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image28.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert29">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


<img src="images/image28.png" width="" alt="alt_text" title="image_tooltip">

   </td>
  </tr>
  <tr>
   <td><em>Figure 8: The web interface. Left: The main screen. Centre: The confirmation screen. Right: The progress screen. </em>
   </td>
  </tr>
</table>


The list of buttons and associated actions can be programmed. This is useful to adapt them to your needs. See “**Editing the rover buttons and actions”** for more information. 


## **Using the tool carrier**

The tool carrier can pull classical weeding tools along the soil. It is best adapted for cultivars that are grown in dense lines, such as carrots. The weeding tools are not part of the Romi Rover package and must be purchased separately.

The tool carrier must be attached to the main frame of the rover using the clamps that are welded on the carrier. Attach the power cable to the frame using the available clamps and plug it into the TOOL CARRIER socket on the control box of the rover.  

The tools must be fixed to one of the horizontal bars of the tool carrier using the dedicated clamps. 


## **Remote maintenance** (V3)

The rover automatically connects to the remote service provided by Dataplicity.


## Remote maintenance (V3)

The rover automatically connects to the remote service provided by Dataplicity.


## **The USB memory stick (**V2**)**

The on-board computer stores all editable and generated data on a USB memory stick. When the rover is turned off, it is possible to remove the stick in the electronics box of the rover and connect it to another computer. This should normally not be necessary but can be convenient to make a backup of the recorded data or to edit the configuration files manually.

The default organisation looks as follows.


```
bin/
config/
 +- config.json
 +- scripts.json
 +- wifi.json (TODO)
database/
lib/
sessions/
 +- 2020-08-15_08-47-51/
     +- logs/
     +- dumps/ 
 +- 2020-08-16_08-53-03/
     +- logs/
     +- dumps/
```


The config directory contains several configuration files including:


<table>
  <tr>
   <td>Filename
   </td>
   <td>Description
   </td>
  </tr>
  <tr>
   <td><code>config.json</code>
   </td>
   <td>The main configuration file of the rover. It is not advised to change this file.
   </td>
  </tr>
  <tr>
   <td><code>scripts.json</code>
   </td>
   <td>This file defines the list of buttons and their associated actions that are shown on the user interface (web interface and control panel).
   </td>
  </tr>
  <tr>
   <td><code>wifi.json</code>
   </td>
   <td>The wifi set-up of the rover. (TODO)
   </td>
  </tr>
</table>


The database directory contains the images and analyses generated either by the weeding tasks or by the camera recorder. It is not advised to make any changes in this directory.

The sessions directory contains the log and dump files that are used for the rover’s maintenance. It is not advised to make any changes in this directory.


## Manually editing the configuration

In some cases, it may be necessary or more convenient to edit the rover’s configuration file directly instead of using the web interface (see “**The configuration page of the rover**”).

TODO: continue


## **Editing the rover buttons and actions**

Turn off the rover and open the box with the electronic components to recover the USB stick (see **“The USB memory stick”**). Open the file `config/scripts.json` on the memory stick using a plain text editor (On Windows, use Notepad, for example).

The file uses the JSON format to describe the list of scripts and the associated sequences of actions. The general structure is as follows:


```
[
    {
        "name": "move-forward",
        "display_name": "Forward",
        "script": [
            { "action": "move", "distance": 0.60 }
        ]
    },
    {
        "name": "move-backward",
        "display_name": "Backward",
        "script": [
            { "action": "move", "distance": -0.60 }
        ]
    },
    {
        "name": "scan",
        "display_name": "Scan",
        "script": [
            { "action": "start_recording" },
            { "action": "move", "distance": 3.6 },
            { "action": "stop_recording" }
        ]
    }
]
```


The file contains a list of scripts. Each script has a `name `that is used to identify the script, a `display_name `that is shown in the user interface, and a `script `field that consists of a list of actions. The list of available actions and their parameters is out of the scope of this manual. Please refer to the online documentation at [https://docs.romi-project.eu/Rover/configuration/](https://docs.romi-project.eu/Rover/configuration/) for details. 

If you make modifications to the file, it is very important that the new content is a valid JSON file. If not, the rover will fail to load the file and no buttons will be shown in the user interface.


## **Farmer’s Dashboard** (V3)

The Farmer’s Dashboard is an online website to view and analyse images scans of the crops. The images collected by the rover can also be uploaded to the Farmer’s Dashboard. The web site offers a means to browse the archive of images.

The Farmer’s Dashboard is a complementary service offered by the Romi Organisation. Since the software for the Farmer’s Dashboard is Free and Open Source Software, it is possible to install it on your own server or to rely on a third party. 

For more information, please visit the Farmer’s Dashboard information page at XXX.


## **Automatically uploading the images to the Farmer’s Dashboard (**V3**)**

You must first create an account on the Farmer’s Dashboard web site. Next, in the account settings, click the “API key” tab. You must then enter the name of the web site and the API key in the configuration page of the rover (see “**The configuration page of the rover**”).


## **Manually uploading the images to the Farmer’s Dashboard (**V3**)**

It is possible to manually upload the images to the Farmer’s Dashboard web site. First, turn off the rover. Then recover the USB memory stick of the on-board computer of the rover. Put the memory stick in a PC. Finally, follow the upload instructions on the Farmer’s Dashboard web site. 

CAUTION: Make sure to put the USB memory stick back into the rover. If not, the rover may fail to function properly upon its next use.


## **Supported web browsers**

The interface of the rover should be viewable in any modern, compliant HTML5-compliant web browser with support for ECMAScript 5 (Javascript), XMLHttpRequests, and WebSockets. The following versions and more recent versions of commonly used browsers should work with the rover (TODO: verify!):


<table>
  <tr>
   <td>Browser name
   </td>
   <td>Version
   </td>
   <td>Release date
   </td>
  </tr>
  <tr>
   <td>Chrome
   </td>
   <td>23
   </td>
   <td>Sep 2012
   </td>
  </tr>
  <tr>
   <td>Firefox
   </td>
   <td>21
   </td>
   <td>Apr 2013
   </td>
  </tr>
  <tr>
   <td>IE / Edge
   </td>
   <td>10
   </td>
   <td>Sep 2012
   </td>
  </tr>
  <tr>
   <td>iOS
   </td>
   <td>6
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>Safari
   </td>
   <td>6
   </td>
   <td>Jul 2012
   </td>
  </tr>
  <tr>
   <td>Opera
   </td>
   <td>15
   </td>
   <td>Jul 2013
   </td>
  </tr>
</table>


 \


The Farmer’s Dashboard web site that is used to browse archived images has its own requirements that are documented on the Farmer’s Dashboard web site.


## Installing a new SD card

The rover uses a Raspberry Pi as its main computer. The control software of the rover is installed on an SD card that sits in the card slot of the Raspberry Pi 4. You can replace the SD card with a new one, following steps below:



1. TODO
