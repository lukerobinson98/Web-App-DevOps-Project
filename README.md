# Web-App-DevOps-Project

Welcome to the Web App DevOps Project repo! This application allows you to efficiently manage and track orders for a potential business. It provides an intuitive user interface for viewing existing orders and adding new ones. The repo outlines the process to containerise the application in Docker. It also hosts the infrastructure as code (IaC) for managing the Azure Kubernetes Service (AKS) cluster and networking services using Terraform.

## Table of Contents

- [Features](#features)
- [Getting Started](#getting-started)
- [Technology Stack](#technology-stack)
- [Contributors](#contributors)
- [License](#license)

## Features

- **Order List:** View a comprehensive list of orders including details like date UUID, user ID, card number, store code, product code, product quantity, order date, and shipping date.
  
![Screenshot 2023-08-31 at 15 48 48](https://github.com/maya-a-iuga/Web-App-DevOps-Project/assets/104773240/3a3bae88-9224-4755-bf62-567beb7bf692)

- **Pagination:** Easily navigate through multiple pages of orders using the built-in pagination feature.
  
![Screenshot 2023-08-31 at 15 49 08](https://github.com/maya-a-iuga/Web-App-DevOps-Project/assets/104773240/d92a045d-b568-4695-b2b9-986874b4ed5a)

- **Add New Order:** Fill out a user-friendly form to add new orders to the system with necessary information.
  
![Screenshot 2023-08-31 at 15 49 26](https://github.com/maya-a-iuga/Web-App-DevOps-Project/assets/104773240/83236d79-6212-4fc3-afa3-3cee88354b1a)

- **Data Validation:** Ensure data accuracy and completeness with required fields, date restrictions, and card number validation.

## Getting Started

### Prerequisites

For the application to succesfully run, you need to install the following packages:

- flask (version 2.2.2)
- pyodbc (version 4.0.39)
- SQLAlchemy (version 2.0.21)
- werkzeug (version 2.2.3)

### Containerisation using Docker and clean up

1. To containerise first make sure the dockerfile is saved in the directory.
2. Then run the command docker build -t image-name .
3. To run the Docker container locally execute docker run -p 8050:5000 image-name.
4. Make sure you are logged into Docker Hub and then push the image using docker push docker-hub-username/image-name:tag.
5. You can then check the image has succesfully pushed by logging into Docker Hub and seeing if it is there.
6. To test pulling the image from Docker Hub run the commands docker pull docker-hub-username/image-name:tag and then docker run -p 8050:5000 docker-hub-username/image-name:tag.

#### Image Information
- Image Name: 'web-app-image'.
- Tags: 'v1'.
- Docker Hub Repo: 'lukerobinson98/web-app-image'.

### Clean Up Process

1. To clean up unnecessary containers first run docker ps -a to list all containers.
2. Then run docker rm container-id, replacing container-id with the id of any unnecessary containers.
3. To clean up unnecessary images run docker images -a.
4. Then remove any unnecessary images using docker rmi image-id, replacing image-id with the id of any unnecessary images.

### Defining Networking Services with IaC using Terraform

#### **networking-module:** Manages the Azure Networking Services for the AKS cluster.

Please find the **variables.tf**, **main.tf** and **outputs.tf** files in the AKS-Terraform/networking-module folder of this repo

- Input variables defined in **variables.tf**:
    - resource_group_name: Represents the Azure Resource Group name.
    - location: Specifies the Azure region for networking resources.
    - vnet_address_space: Specifies the address space for the Virtual Network (VNet).
      
- Essential networking resources defined in **main.tf**:
    - Azure Resource Group: Created to group networking resources together.
    - Virtual Network (VNet): Represents the core networking component.
    - Control Plane Subnet: Dedicated subnet for AKS control plane components.
    - Worker Node Subnet: Dedicated subnet for AKS worker nodes.
    - Network Security Group (NSG): Provides network security rules.
      
- Inbound rules within the NSG:
    - kube-apiserver Rule:
        - Allows inbound traffic to the kube-apiserver.
        - Restricted to a specific public IP address.
    - SSH Rule:
        - Allows inbound SSH traffic.
        - Restricted to a specific public IP address.

- CIDR Block Configuration:
    - Defined CIDR blocks for subnets to ensure proper IP address allocation.
    - Used cidrsubnet function to calculate subnet address ranges.

- Output variables defined in **outputs.tf**:
    - vnet_id: ID of the VNet.
    - control_plane_subnet_id: ID of the control plane subnet.
    - worker_node_subnet_id: ID of the worker node subnet.
    - networking_resource_group_name: Name of the Azure Resource Group.
    - aks_nsg_id: ID of the Network Security Group.

### Defining an AKS Cluster with IaC using Terraform

#### **aks-cluster-module:** Manages the defining and provisioning of the AKS cluster.

Please find the **variables.tf**, **main.tf** and **outputs.tf** files in the AKS-Terraform/aks-cluster-module folder of this repo

- Input variables defined in **variables.tf**:
    - aks_cluster_name: Name of the AKS cluster.
    - cluster_location: Azure region where the AKS cluster will be deployed.
    - dns_prefix: DNS prefix of the cluster.
    - kubernetes_version: Kubernetes version for the cluster.
    - service_principal_client_id: Client ID for the service principal.
    - service_principal_secret: Client Secret for the service principal.

- **main.tf**: Defines Azure resources for provisioning an AKS cluster, including the AKS cluster itself, node pool, and service principal.
  
- Output variables defined in **outputs.tf**:
    - aks_cluster_name: Name of the provisioned AKS cluster.
    - aks_cluster_id: ID of the AKS cluster.
    - aks_kubeconfig: Kubernetes configuration file for managing the AKS cluster.
 
### Creating an AKS Cluster with IaC using Terraform

#### **main.tf**

The **main.tf** file serves as the main configuration file and is responsible for setting up the Azure provider, integrating networking and cluster modules, and defining input variables.

In this section, the Azure provider is configured using the specified service principal credentials and subscription details.

#### networking-module integration

The networking module is integrated into the project, providing a reusable and organized way to define the Azure networking resources.

#### aks-cluster-module integration

The cluster module is integrated, allowing for the provisioning of an Azure Kubernetes Service (AKS) cluster. Input variables are passed, referencing the outputs from the networking module.

#### Input Variables

The following input variables are defined in the variables.tf file:

- aks_cluster_name: The name of the AKS cluster.
- cluster_location: The Azure region where the cluster will be deployed.
- dns_prefix: The DNS prefix of the cluster.
- kubernetes_version: Kubernetes version the cluster will use.
- service_principal_client_id: The client ID of the service principal associated with the cluster.
- service_principal_secret: The client secret for the service principal.

#### Variables referencing the output variables from the networking module:

- resource_group_name: Name of the Azure Resource Group.
- vnet_id: ID of the VNet.
- control_plane_subnet_id: ID of the control plane subnet.
- worker_node_subnet_id: ID of the worker node subnet.
- aks_nsg_id: The ID of the Network Security Group.

### Kubernetes Deployment Documentation

#### Deployment and Service Manifests

**Deployment Manifest (deployment.yaml)**

- The `deployment.yaml` file defines the specifications for deploying the Flask application within the AKS cluster.
- Key Concepts:
  - **Replicas:** Specifies the desired number of application instances (pods) to run concurrently (set to 2 for scalability and high availability).
  - **Selector and Labels:** Utilizes labels (e.g., app: flask-app) for pod management, ensuring proper identification by the Deployment.
  - **Container Image:** Points to the Docker Hub container image (lukerobinson98/web-app-image:v1).
  - **Ports:** Exposes port 8050 within the pod for internal communication.

**Service Manifest (service.yaml)**

- The `service.yaml` file defines the Kubernetes Service responsible for routing internal communication.
- Key Concepts:
  - **Selector:** Matches the labels (app: flask-app) defined in the Deployment, ensuring efficient traffic routing.
  - **Port Configuration:** Uses TCP protocol on port 80 for internal communication within the AKS cluster, forwarding to port 8050 in the pods.
  - **Service Type:** Set to ClusterIP, designating it as an internal service within the AKS cluster.

#### Deployment Strategy

- **Rolling Update Strategy:**
  - Chose the Rolling Update deployment strategy for seamless application updates.
  - Ensures a maximum of one pod deploys at a time while maintaining application availability.
  - Facilitates zero-downtime updates and smooth transitions between different versions of the application.

#### Testing and Validation

- **Testing Process:**
  - Conducted thorough testing of the deployed application within the AKS cluster.
  - Verified the health and status of pods and services.
  - Tested the functionality of the application, paying particular attention to the orders table and Add Order functionality.

- **Validation:**
  - Ensured that the pods are running as expected and responding to requests.
  - Verified that the services are correctly exposed and accessible within the AKS cluster.
 
#### Application Distribution Plan

**Internal Distribution**

- To make the application accessible to internal users:
  - Use Kubernetes Services to expose the application internally.
  - Share the service URL or DNS with team members.
  - Consider implementing role-based access control (RBAC) to restrict access if needed.

**External Distribution**

- For external access:
  - Use Kubernetes Ingress to expose the application securely.
  - Implement HTTPS and authentication mechanisms for external access.
  - Consider using Azure Application Gateway or a similar service for additional security.

#### Additional Considerations

- **Secure Access:**
  - Implement secure access mechanisms, such as HTTPS and authentication, for both internal and external access.
  - Regularly update secrets and credentials used in the application.

- **Documentation:**
  - Keep documentation up-to-date for team members and external users.
  - Document any changes or updates made to the deployment configuration.

### Azure DevOps CI/CD Pipeline Configuration

#### Source Repository
- This project is hosted on [GitHub](https://github.com/lukerobinson98/Web-App-DevOps-Project)
- The main branch triggers the CI/CD pipeline on Azure DevOps.

#### Build Pipeline
- The build pipeline is defined in the `azure-pipelines.yml` file.
- It uses an Ubuntu agent for building and publishing the application.
- The Docker image is built and pushed to Docker Hub with the tag 'v1'.
- The build artifacts are stored for use in the release pipeline.

**Sample Build Pipeline Configuration**

![image](https://github.com/lukerobinson98/Web-App-DevOps-Project/assets/150971337/f9d23a5e-2088-4d1b-af14-5a2a9bb7c904)

#### Release Pipeline

- The release pipeline is configured to deploy the application to an Azure Kubernetes Service (AKS) cluster.
- It uses the KubernetesManifest task to deploy the application using the manifest file (application-manifest.yaml).
- The AKS service connection (aks-service-connection) is utilized for the deployment.

**Sample Release Pipeline Configuration**

![image](https://github.com/lukerobinson98/Web-App-DevOps-Project/assets/150971337/85a22b45-52b1-49ad-b06e-74b3c7370c02)


#### Integration with Docker Hub and AKS

- A service connection to Docker Hub (Docker Hub) is configured to authenticate and push Docker images.
- An AKS service connection (aks-service-connection) is established for secure communication between Azure DevOps and the AKS cluster.

#### Testing Functionality

1. After each CI/CD run, monitor the Azure DevOps pipeline logs for successful builds and releases.
2. Validate the Docker image by checking Docker Hub for the latest pushed image with the 'v1' tag.
3. Monitor the AKS cluster for successful deployments.
4. Initiate port forwarding using kubectl to access the application locally: kubectl port-forward <pod-name> 8080:5000.
5. Access the application at http://localhost:8080 and perform functional testing.


## AKS Cluster Monitoring Strategy

### Average Node CPU Usage

![image](https://github.com/lukerobinson98/Web-App-DevOps-Project/assets/150971337/f9f9fc89-db97-4b5a-bf24-82710da7a235)

This chart tracks the CPU usage of AKS cluster nodes. It is crucial for identifying potential performance bottlenecks and ensuring efficient resource allocation.

### Average Pod Count

![image](https://github.com/lukerobinson98/Web-App-DevOps-Project/assets/150971337/54eb32a5-e950-4d89-9704-90584fa88864)

The average pod count chart provides insights into the workload distribution within the AKS cluster. Monitoring this metric is essential for evaluating cluster capacity.

### Used Disk Percentage

![image](https://github.com/lukerobinson98/Web-App-DevOps-Project/assets/150971337/f9b04462-6dfe-4cb8-a9b5-a73858810702)

Tracking disk usage is critical to preventing storage-related issues. This chart visualizes the percentage of used disk space in the AKS cluster.

### Bytes Read and Written per Second

![image](https://github.com/lukerobinson98/Web-App-DevOps-Project/assets/150971337/bc9615bb-e4f3-4b39-af6e-4e5704415543)

Monitoring data I/O is crucial for identifying performance issues. This chart shows the data transfer rates within the AKS cluster.

### Log Analytics Logs

#### Average Node CPU Usage Percentage per Minute

```kql
Perf
| where ObjectName == "K8SNode" and CounterName == "cpuUsagePercentage"
| summarize AvgCPUUsage = avg(CounterValue) by bin(TimeGenerated, 1m), Computer
| project TimeGenerated, Node = Computer, AvgCPUUsage
```
This log configuration captures node-level CPU usage at a granular level, logged per minute.

#### Average Node Memory Usage Percentage per Minute

```kql
Perf
| where ObjectName == "K8SNode" and CounterName == "memoryUsagePercentage"
| summarize AvgMemoryUsage = avg(CounterValue) by bin(TimeGenerated, 1m), Computer
| project TimeGenerated, Node = Computer, AvgMemoryUsage
```
Similar to CPU usage, this log captures node-level memory usage per minute.

#### Pods Counts with Phase

```kql
KubePodInventory
| summarize Count by ClusterName, ClusterId, Namespace, PodName, PodPhase
```
This log configuration provides information on the count of pods with different phases, such as Pending, Running, or Terminating.

#### Find Warning Value in Container Logs

```kql
ContainerLog
| where LogEntry contains "warning"
```
This log configuration searches for warning values in container logs, helping proactively detect issues or errors.

#### Monitoring Kubernetes Events

```kql
KubeEvents
| project TimeGenerated, Namespace, ClusterName, Message
| order by TimeGenerated desc
```
This log configuration monitors Kubernetes events, providing insights into pod scheduling, scaling activities, and errors.

### Alert Configurations

#### Used Disk Percentage Alert:
- Condition: Used Disk Percentage > 90%
- Frequency: Every 5 minutes
- Lookback Period: 15 minutes
- Actions: Email notification
  
#### CPU Usage Alert:
- Condition: CPU Usage > 80%
- Frequency: Every 5 minutes
- Lookback Period: 15 minutes
- Actions: Email notification
  
#### Memory Working Set Percentage Alert:
- Condition: Memory Working Set Percentage > 80%
- Frequency: Every 5 minutes
- Lookback Period: 15 minutes
- Actions: Email notification
- Alarm Response Procedures

#### Used Disk Percentage Alert:
- Check the affected nodes for resource-intensive processes.
- Scale resources or allocate additional capacity as needed.
- Investigate and resolve any disk-related issues.

#### CPU Usage and Memory Alerts:
- Identify resource-hungry pods or containers.
- Scale resources or allocate additional capacity.
- Investigate and optimize resource utilization.
- Implement autoscaling if needed.

#### Kubernetes Events Alert:
- Investigate events with high EventLevels.
- Troubleshoot and resolve issues related to pod scheduling, scaling, or errors.

## AKS Integration with Azure Key Vault for Secrets Management

### Azure Key Vault Setup

- Created a Key vault in azure with the name **aks-cluster-kv-luke**
- Added an access policy to grant necessary permissions, assigning role 'Key Vault Secrets Officer' to the Managed Identity of the AKS Cluster

### Stored Secrets in Key Vault

- **server-name**: Server name.
- **server-username**: Server username.
- **server-password**: Server password.
- **database-name**: Database name.

### AKS Integration with Key Vault

- Enabled Managed Identity for AKS Cluster
- Assigned necessary permissions to Managed Identity
- Modified application code to integrate Azure Identity and Azure Key Vault libraries in the Python application code.

#### Example Modified Application Code 

```python

from azure.identity import ManagedIdentityCredential
from azure.keyvault.secrets import SecretClient
import pyodbc
import os

# Key Vault url and credential
key_vault_url = "https://aks-cluster-kv-luke.vault.azure.net/"
credential = ManagedIdentityCredential()

# Create key vault client
secret_client = SecretClient(vault_url=key_vault_url, credential=credential)

# Access secret values from key vault   
server = secret_client.get_secret("server-name").value
username = secret_client.get_secret("server-username").value
password = secret_client.get_secret("server-password").value
database = secret_client.get_secret("database-name").value
```

## DevOps Pipeline Architecture

![image](https://github.com/lukerobinson98/Web-App-DevOps-Project/assets/150971337/79be77ce-3032-46f6-b047-aefadf2299b4)


### Usage

To run the application, you simply need to run the `app.py` script in this repository. Once the application starts you should be able to access it locally at `http://127.0.0.1:5000`. Here you will be meet with the following two pages:

1. **Order List Page:** Navigate to the "Order List" page to view all existing orders. Use the pagination controls to navigate between pages.

2. **Add New Order Page:** Click on the "Add New Order" tab to access the order form. Complete all required fields and ensure that your entries meet the specified criteria.

## Technology Stack

- **Backend:** Flask is used to build the backend of the application, handling routing, data processing, and interactions with the database.

- **Frontend:** The user interface is designed using HTML, CSS, and JavaScript to ensure a smooth and intuitive user experience.

- **Database:** The application employs an Azure SQL Database as its database system to store order-related data.

## Contributors 

- [Maya Iuga]([https://github.com/yourusername](https://github.com/maya-a-iuga))

## License

This project is licensed under the MIT License. For more details, refer to the [LICENSE](LICENSE) file.
