Dockerfiles for various services and platforms

Structure of folders and files:

- platform
    - service-name_version
        - Dockerfile
        - README.md
        - files 
		
Below folder structure should be present on the host which runs docker:
```
a_folder\myDocker\on_host       shell scripts to build and run the docker configurations
        |        \services      folder with the various configurations of services (YOU SHOULD BE HERE)
        |        \integrations  folder with the docker compose yaml files 
        \myStorage              folder with volumes used to store data
```

Below folder structure should be present on the workstation on which development is done:
```
a_folder\dev_scripts command/batch files to interact with docker host
        \secrets       secrets not to be put on github
        \on_host       shell scripts to build and run the docker configurations
        \services      folder with the various configurations of services (OR YOU SHOULD BE HERE)    
        \integrations  folder with the docker compose yaml files
```
