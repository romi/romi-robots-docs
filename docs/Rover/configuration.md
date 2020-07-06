
The rover uses the following input files and directories:

* Configuration file: The main configuration file. This file should be passed on the command line to `rclaunch`.
* HTML directory: The location of the files for the web interface. The path should be set in the configuration file in the `webproxy` section.  
* Script file: The list of operations and associated command sequences. The path should be set in the configuration file in the `script_engine` section.  


The configuration and script files are discussed in detail below.


## Configuration file

The rover control software is starting using the `rclaunch`
command. This command takes the path to the main configuration as an
argument. Example configutation files can be found in the
`romi-rover/config` directory.

### The launch section

The `launch` section is required in all configuration files. A
stripped-down version of this section looks like below:


```json
{    
    
    "launch": {
        "general": {
            "sessions-dir": "/tmp/session",
            "user": "romi"
        },
        "nodes": [{
            "path": "rclogger"
        }, {
            "path": "configuration"
        }, {
        //...
        }]
    }
}
```

The `launch` section has two subsections, `general` and `nodes`. The
first section groups the following settings:


| Name          | Value  | Required | Description  |
| ------------- | ------ | -------- | -----------  |
| sessions-dir  | String | Optional | Where to store the session data (log files, database, dumps) |
| user          | String | Optional | The username under which the nodes will be executed |


The `nodes` section is an array that lists all the nodes that should
be launched. The nodes are launched in the order given, but no
guarantee is given that a node in the front of the list will be ready
for communication before a node later in the list.

Each node object accepts the following fields:

| Name          | Value   | Required | Description  |
| ------------- | ------- | -------- | ------------ |
| path          | String  | Required | The path (or name) of the executable |
| args          | String  | Optional | Additional command-line arguments to be passed to the executable |
| disabled      | Boolean | Optional | Whether to skip the node or not |
| host          | String  | Optional | To start the node on a remote machine |
| user          | String  | Optional | The user account to start the node on a remote machine |

The PATH environment variable is used to find the executable.



### The node settings

Each node can have its own section in the configuration file. The name
of the section must be the name of the node. For example, the
`webproxy` node will look for the key `webproxy` at the root of the
configuration file:

```json
{    
    "proxy": {
        "html": "romi-rover/html"
    },
        
    "launch": {
        //...
    }
}
```






