# Local Development

Using docker compose I've set up a multi container project that would launch the Flask API and load the sql script into a postgresql container. 
Please note that there is currently an issue with the connectivity between the API container and the database container which needs to be resolved (as it might be an issue related to my M1 Mac, this might work on an Intel Chip device). 

## Prerequisites

* Docker Desktop

## How to deploy

* make sure you are in the root folder of the repository

* run the following command to build the images required for the project

```
docker compose build
```

* to start the API, run:

```
docker compose up
```

* the API can now be accessed on [localhost:5000](http://localhost:5000)

# Cloud Deployment

Azure is the cloud provider of choice for hosting the API and its corresponding database.  

## Prerequisites

* Azure account and subscription. 
* Azure CLI installed on the local device.
* Terraform CLI installed on the local device.

## Infrastructure deployment

The infrastructure required to run the services is provisioned using Terraform from the "infra" folder. The state is currently managed localy and uploaded to the github repository. For a project where multiple developers are collaborating it is advised to use a centralised solution for managing the state file (i.e. Azure Blob Storage).


### Steps to deploy

* Login to your Azure account via the AZ CLI:

```
az login
```

* Select the Azure subscription you wish to deploy to:

```
az account set <subscription-id>
```

* Navigate to the infra folder:

```
cd infra
```

* Initialise the Terraform configuration:

```
terraform init
```

* Apply the configuration:

```
terraform apply 
```

Please note that the initial run will fail on creating the container app. This is because the container images have not yet been deployed to the Azure Container Registry. To deploy them, proceed with the following steps:

* Navigate to the root of the repository and open the makefile. Ensure the ACR_NAME, IMAGE_NAME and IMAGE_TAG are set correctly and run the following command: 

```
make deploy-to-acr
```

This will push the Flask API container image to the newly created ACR. 

* Repeat the step above in the db folder to push the postgresql container image with the preloaded data. 

* Re-run "terraform apply". This should now deploy the container app succesfull.

Please note that this solution does not yet work end to end. The following networking configuration is still required:

- between the Flask API container and the Postgresql container
- Ingress for the Flask API to succesfully connect from local machine

# CI/CD

ToDO:

- Create a Github Actions pipeline that:

* runs a Snyk workflow against the code whenever a PR is raised against main
* uploads the image of the PR to the ACR
* deploys the instance to a Container App for end to end testing

# Secure Database Access

Below is an outline of the hosting components that should be used:

![Diagram](/images/cf-secops.drawio.png)

- Azure Application Gateway - Used to secure Traffic to CF Apps deployed on AKS
- Azure Kubernetes Service - Hosts the CF Apps
- Azure Database for Postgresql 
- Log Analytics 

## Database requirements

- Auditing;  pgAudit extension is required. This will ensure all events are forwarded to the Log Analytics Workspace. 
- Credential Rotation; A cron job with database access can be set up on AKS to rotate the credentials. To ensure that CF Apps do not lose connectivity, the credentials should be stored in Key Vault and updated by the cron job. 
- User Access; An API should provide the ability to create an update user accounts. Ideally it would integrate with the existing Service Desk system to ensure any approvals required are embedded into the process. 






