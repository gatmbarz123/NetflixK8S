# Streaming Website 

This project demonstrates the deployment of a streaming website (similar to Netflix) using Kubernetes, Jenkins, ArgoCD, and Terraform. The goal of the project is to showcase how to build and deploy a **microservices architecture** with Kubernetes. It includes containerizing applications with Docker, implementing an automated CI/CD pipeline, and deploying scalable services in both development and production environments. The project is divided into three main parts: **Frontend**, **Backend**, and the **Kubernetes Infrastructure with CI/CD processes**.

---

## Table of Contents
1. [Frontend](#frontend)
2. [Backend](#backend)
3. [Kubernetes Infrastructure, CI/CD, and Terraform](#kubernetes-infrastructure-cicd-and-terraform)
4. [Key Tools](#key-tools)
5. [Workflow](#workflow)
6. [Repositories](#repositories)
7. [Conclusion](#conclusion)

---

## Frontend

The frontend includes:
- **Technologies**: JavaScript, HTML, CSS, and other tools to build the user interface.
- **Purpose**: Hosts all the necessary code and assets for the streaming website's frontend.
- **Deployment**:
  - Packaged into a Docker image using `docker build` and pushed to a container registry using `docker push`.
  - This image is used later in the Kubernetes infrastructure to deploy the frontend.

---

## Backend

The backend includes:
- **Purpose**: 
  - Handles movie playback functionality.
  - Manages API requests between the frontend and backend.
  - Demonstrates the interaction and scalability of a **microservices architecture** in Kubernetes.
- **Deployment**:
  - Packaged into a Docker image similar to the frontend.
  - Stored in Docker Hub for easy access and deployment.

---

## Kubernetes Infrastructure, CI/CD, and Terraform

The infrastructure and automation processes include:
- **Kubernetes Setup**:
  - The project uses Kubernetes to deploy the streaming website.
  - Two separate environments are created: **Production (Prod)** and **Development (Dev)**.
  - Each environment has:
    - Separate folders for frontend and backend.
    - Deployment YAML files with all necessary configurations for running the services.
    - Services for communication between Pods and external access.
- **CI/CD Process**:
  - Implemented CI/CD pipelines to automate deployments, testing, and updates.
  - Jenkins handles the deployment and testing processes.
  - ArgoCD ensures changes are automatically deployed to the environments after passing tests.
- **Terraform**:
  - The entire infrastructure is provisioned using **Terraform**. This includes:
    - A **VPC module** to isolate resources securely in the cloud.
    - A **Compute module** to create the virtual machines running the website.
  - Each branch in the repository represents a separate cloud environment, ensuring a clear separation between `dev` and `prod`.


![][sw]
---

## Key Tools

### Jenkins
Jenkins is an open-source automation server that facilitates the continuous integration and delivery (CI/CD) of applications. It is used to:
- Automate testing, building, and deploying code changes.
- Monitor the pipeline's progress and status.
- Integrate with various tools like Docker, Kubernetes, and version control systems.
In this project, Jenkins is set up using Docker Compose along with Jenkins agents to execute tasks.

### ArgoCD
ArgoCD is a declarative, GitOps-based tool for continuous delivery (CD) in Kubernetes. Its main features include:
- Synchronizing application state with configuration stored in Git repositories.
- Ensuring Kubernetes clusters always match the desired state defined in configuration files.
- Providing an easy-to-use interface to monitor and manage application deployments.
In this project, ArgoCD is deployed as a Kubernetes Node and is responsible for rolling out updates after code changes are validated by Jenkins.

### Terraform
Terraform is an open-source infrastructure as code (IaC) tool used to provision and manage cloud infrastructure. It is used to:
- Automate the creation and management of resources, such as VPCs, virtual machines, and other infrastructure components.
- Modularize infrastructure code for reusability and scalability.
- Support multi-environment setups, allowing separate configurations for development and production.
In this project, Terraform is used to:
- Provision the Kubernetes clusters and supporting resources.
- Maintain separate environments for `dev` and `prod` by linking them to specific branches in the repository.

---

## Workflow

1. **Code Updates**:
   - All code changes go through a Pull Request (PR) process for approval before merging into the `main` (Production) branch.
2. **Environment-Specific Pipelines**:
   - Both **Dev** and **Prod** environments have their own CI/CD pipelines.
   - Tests and deployments are isolated per environment.
3. **Deployment**:
   - Once changes pass all checks in Jenkins, ArgoCD updates the application in the respective environment.

---

## Repositories

This project consists of multiple repositories for different components:
- **Frontend Repository**: [Link to Frontend Repo](https://github.com/gatmbarz123/NetflixFrontend)
- **Backend Repository**: [Link to Backend Repo](https://github.com/gatmbarz123/NetflixMovieCatalog/tree/dev)
- **Kubernetes & CI/CD Repository**: [Link to Kubernetes Repo](https://github.com/gatmbarz123/NetflixK8S)

---

## Conclusion

This project showcases the integration of Docker, Kubernetes, Jenkins, and ArgoCD to deploy and manage a streaming website. It highlights:
- The power of containerization for frontend and backend applications.
- Efficient deployment processes through Kubernetes.
- Automation capabilities provided by Jenkins and ArgoCD.

Explore the codebase to see the implementation details and learn how to set up a similar environment for your projects!


[sw]: https://github.com/gatmbarz123/NetflixK8S/blob/main/SW.png
