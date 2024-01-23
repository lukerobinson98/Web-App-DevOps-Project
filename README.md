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
6. To test pulling the image from Docker Hub run the commands docker pull docker-hub-username/image-name:tag and then docker run -p 5000:5000 docker-hub-username/image-name:tag.

#### Image Information
- Image Name: 'web-app-image'.
- Tags: 'v1'.
- Docker Hub Repo: 'lukerobinson98/web-app-image'.

### Clean Up Process

1. To clean up unnecessary containers first run docker ps -a to list all containers.
2. Then run docker rm container-id, replacing container-id with the id of any unnecessary containers.
3. To clean up unnecessary images run docker images -a.
4. Then remove any unnecessary images using docker rmi image-id, replacing image-id with the id of any unnecessary images.

### Defining Networking Services with IaC

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

- Output variables defined in **outputs.tf**
    - vnet_id: ID of the VNet.
    - control_plane_subnet_id: ID of the control plane subnet.
    - worker_node_subnet_id: ID of the worker node subnet.
    - networking_resource_group_name: Name of the Azure Resource Group.
    - aks_nsg_id: ID of the Network Security Group.

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
