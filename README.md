# Local Development

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

The infrastructure required to run the services is provisioned using Terraform from the "infra" folder. The state is currently managed localy and uploaded to the github repository. For a project with multiple developers it is advised to use a centralised solution for managing the state file (i.e. Azure Blob Storage).

### Steps to deploy

* Login to your Azure account via the AZ CLI:

```
az login
```

* Select the Azure subscription you wish to deploy to:

```
az account set <subscription-id>
```
