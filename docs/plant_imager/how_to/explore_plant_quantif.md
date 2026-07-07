# How to Explore Reconstruction and Quantification with the _Plant 3D Explorer_

To visualize the reconstruction and quantification results in 3D, use the _Plant 3D Explorer_.

Start it, along with a PlantDB server (REST API), as follows:

```bash
cd ~/Projects/plant-3d-explorer/
export ROMI_DB=/data/ROMI/test_v2 && docker compose up
```
Then open your browser and go to [http://localhost:3000/](http://localhost:3000/).

Note: You may need to change the path to the database you want to use by editing the `ROMI_DB` value!
