Dockerfiles for various services and platforms

Structure of folders and files:

- platform
    - service-name_version
        - Dockerfile
        - README.md
        - files 
		
Below folder structure should be present on the host which runs docker:
```
a_folder\on_host       shell scripts to build and run the docker configurations
        \services      folder with the various configurations of services
        \integrations  folder with the docker compose yaml files (YOU SHOULD BE HERE)
        \storage       not used yet
```

Below folder structure should be present on the workstation on which development is done:
```
a_folder\dev_scripts command/batch files to interact with docker host
        \secrets       secrets not to be put on github
        \on_host       shell scripts to build and run the docker configurations
        \services      folder with the various configurations of services    
        \integrations  folder with the docker compose yaml files (OR YOU SHOULD BE HERE)
        \storage       not used yet
```