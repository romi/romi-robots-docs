---
title: Getting started
---

This page will describe how to set up and start the plant visualizer.

## Dependencies

This project is build using Node JS. As such, you need to install Node JS and npm (which should come with node).

!!! important To make sure everything works as intended, check that your version of Node is at least 10, and your version of npm is at lease 6.

## Installing packages and setting up the environment

After making sure you have the right versions of Node and npm, you will need to clone the repository of the project. Simply run

```
git clone https://github.com/romi/plant-3d-explorer
```

The next step is to install everything the app needs with the following command:

```
npm install
```

If you want the app to use the remote server to fetch data, run the following command:

```
echo "REACT_APP_API_URL='https://db.romi-project.eu'" > .env.local
```

If you don't, the app will use a local server at address `localhost:5000`. In order to do this, you need to get
[plantdb](https://github.com/romi/plantdb) running.

## Starting the app

To start a development server (used to develop, or simply test the app), run:

```
npm start
```

The app will then run at address `localhost:3000`.

!!! warning Using Google Chrome (or Chromium Browser) is recommended as some problems have been encountered on Firefox due to some libraries we used.

## More commands

To see a more detailed list of available commands, visit the
[GitHub repository](https://github.com/romi/plant-3d-explorer).