# Project Overview

This repository contains three sub-projects: API, Automation, and Terraform. Each sub-project plays a crucial role in the overall functionality and deployment of our application.

## API

The API sub-project is the main application, running a Python Flask program that exposes two web services.

### Endpoints

1. **Validate IP**

   - **Route:** `/validate_ip`
   - **Method:** `POST`
   - **Description:** Validates if the provided IP address is valid.
   - **Request Body:**
     ```json
     {
       "ip": "string"
     }
     ```
   - **Responses:**
     - `200 OK`: IP address is valid.
       ```json
       {
         "status": "valid"
       }
       ```
     - `400 Bad Request`: IP address is invalid.
       ```json
       {
         "status": "invalid"
       }
       ```

2. **Traceroute**

   - **Route:** `/traceroute`
   - **Method:** `POST`
   - **Description:** Performs a traceroute to the provided IP address.
   - **Request Body:**
     ```json
     {
       "ip": "string"
     }
     ```
   - **Responses:**
     - `200 OK`: Traceroute result.
       ```json
       {
         "traceroute": "string"
       }
       ```
     - `400 Bad Request`: Invalid IP address.
       ```json
       {
         "error": "Invalid IP address"
       }
       ```

## Automation

The Automation sub-project contains Jenkins scripts used for building, deploying, and destroying the application.

### Jenkins Scripts

1. **jenkinsfileBuild**
   - **Purpose:** Builds the application locally, tests the image by creating a container and pinging it. If the image is valid, it creates a new image and deploys it with the tag `latest` to Docker Hub Image repo.

2. **jenkinsfileDeploy**
   - **Purpose:** Used by the Jenkins pipeline to deploy to AWS. It uses Terraform to create a Security Group and EC2 instance, installs Docker, deploys the image, and runs the container. Finally, it uses two curl commands to check the two endpoints of the app.

3. **jenkinsfileTerraformDestroy**
   - **Purpose:** Used by the Jenkins pipeline to destroy and delete all resources in AWS.

## Terraform

The Terraform sub-project contains all the files used to create the necessary resources in AWS, such as Security Groups and EC2 instances.

## Getting Started

### Prerequisites

- Python 3.x
- Flask
- Docker
- Jenkins
- Terraform
- AWS CLI

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/your-repo.git
   cd your-repo
