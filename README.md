# Terraform Azure CI/CD Template

## Overview

This repository contains a CI/CD template for managing Terraform deployments in Azure using GitHub Actions. It includes workflows for validating, planning, and applying Terraform configurations. The setup ensures that Terraform changes are applied systematically and consistently through automated processes.
For a visual demonstration of the setup and configuration, you can watch the following video:
[Usage Demonstration and Setup Video](https://youtu.be/2bq8RmuXekY)


## Key Workflow Components:

1. **Terraform Validate**: Checks the syntax and integrity of the Terraform configuration files.
2. **Terraform Plan**: Creates an execution plan for Terraform, which details the changes that will be made.
3. **Terraform Apply**: Applies the changes required to reach the desired state of the configuration.

The template uses GitHub Actions to automate these tasks, making it easier to integrate Terraform with your development and deployment pipelines.

## Azure-side Prerequisites
Before using this template you will need to have below pre-requisites in place form Azure side.

1. **Azure Service Principal**:
   - Create an Azure Service Principal to authenticate Terraform operations. This Service Principal needs to have sufficient permissions to manage resources in your Azure subscription.This can be ceated form Azure portal or using cli. Example : 

   ```sh
   az ad sp create-for-rbac --name "<your-service-principal-name>" --role Contributor --scopes /subscriptions/<your-subscription-id>
   ```
   - This command will output `client_id`, `client_secret`, `tenant_id`, and `subscription_id` which are required for the GitHub secrets.

2. **Azure Storage Account**:
   - Set up an Azure Storage account to store the Terraform state files. This ensures state management across different environments and team members.This can be done using Azure portal or CLI like below : 

   ```sh
   az storage account create --name <your-storage-account-name> --resource-group <your-resource-group> --location <location> --sku Standard_LRS
   ```
   - Create a container within the storage account to hold the Terraform state files.
   ```sh
   az storage container create --name <your-container-name> --account-name <your-storage-account-name>
   ```
3. **Configure Access**:
   - Ensure the Service Principal has access to the Storage account and container for state file management. You can configure access using Azure Role-Based Access Control (RBAC) to grant the necessary permissions. this can be done using Azure portal or using CLI : 

   - Assign the Service Principal the `Storage Blob Data Contributor` or `Contributor` role on the Storage account to allow it to read and write the Terraform state files.

   ```sh
   az role assignment create --assignee <your-service-principal-id> --role "Storage Blob Data Contributor" --scope /subscriptions/<your-subscription-id>/resourceGroups/<your-resource-group>/providers/Microsoft.Storage/storageAccounts/<your-storage-account-name>



## GitHub Side Prerequisites

Before using this CI/CD template, ensure you have the below credentials set up at repository level in GitHub Actions or at the GitHub organisation level. If set at organisational level these will need to be passed downstream to subsequent repositories that will be created from this template.

1. **Azure Credentials**: Set up Azure Service Principal credentials:
   - `ARM_CLIENT_ID`: Azure Service Principal client ID.
   - `ARM_CLIENT_SECRET`: Azure Service Principal client secret.
   - `ARM_TENANT_ID`: Azure tenant ID.
   - `ARM_SUBSCRIPTION_ID`: Azure subscription ID.

2. **Azure Storage Backend**: Configure the backend for storing Terraform state files. Set up the following secrets:
   - `BACKEND_RESOURCE_GROUP_NAME`: The name of the Azure resource group where the backend storage account is located.
   - `BACKEND_STORAGE_ACCOUNT_NAME`: The name of the Azure Storage account used for the backend.
   - `BACKEND_STORAGE_CONTAINER_NAME`: The name of the container within the Azure Storage account used for Terraform state files.

3. **Terraform backend file**: Ensure that you have a `backend.tfvars` file in `src/terraform` directory. Ensure below two values are set. This will ensure that backend file is named as per application and environment. Example file : 
   - ApplicationName = "LirookIAC"
   - EnvironmentName = "dev"
   - So the resulting backend file will be : `LirookIAC-dev.tfplan`

5.  **Versions file **: Ensure that your `src/teraform/versions.tf` has required versions and providers set up.

6.  **Terraform Configuration**: Ensure that your Terraform configuration files are correctly set up and located in the `src/terraform` directory. This setup includes your Terraform files, variable files, and any necessary modules or resources.
   
7.  **Environment Protection Rules** : Make sure you have `production` and `dev` environment set up in github repository. Add approvers to prod if needed. Plan runs on `dev` environment while the apply step runs on `production`.

With these prerequisites met, you can start using the CI/CD template to manage your Terraform deployments in Azure effectively.


## Creating a New Repository from Template and Using It

###  Create a New Repository from the Template

1. **Navigate to the Template Repository**
   - Go to the GitHub page of the repository.

2. **Create a New Repository**
   - Click on the **"Use this template"** button, usually found on the right side of the repository page.
   - You will be redirected to a new page where you can create a new repository based on the template.

3. **Configure the New Repository**
   - **Repository Name**: Enter a name for your new repository.
   - **Description** (optional): Provide a description for your new repository.
   - **Visibility**: Choose whether the repository should be **Public** or **Private**.
   - Click **"Create repository from template"** to create the new repository.
  
4. **Ensure pre-requisites**
   - Ensure all GitHub and Azure Pre-requisites are met outlined in above sections.


5. **Clone the Repository Locally**
   - Once the new repository is created, clone it to your local machine using the following command:

   ```sh
   git clone https://github.com/<your-username>/<your-new-repo>.git
   cd <your-new-repo>
   ```
## 3. Configure and Run GitHub Actions

1. **Push Changes to GitHub**
   - After making necessary updates to Terraform configurations and backend settings, commit and push your changes to the repository.

2. **Trigger the Workflow**
   - Go to the **Actions** tab in your new repository on GitHub.
   - You should see the workflow named "Terraform Apply" or similar. Click on it to view the workflow runs.
   - Manually trigger the workflow by clicking the **"Run workflow"** button if necessary.

3. **Monitor Workflow Execution**
   - Monitor the progress and results of the GitHub Actions workflow. You can view logs for each step of the workflow to ensure that the Terraform operations are executed correctly.

This template provides a starting point for setting up a Terraform CI/CD pipeline with GitHub Actions. You can further customize and modify this template to fit your organization's specific needs and policies. Adjust the workflows, variables, and configurations as necessary to align with your infrastructure and operational requirements.



