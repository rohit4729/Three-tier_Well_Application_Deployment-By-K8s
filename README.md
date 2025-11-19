# 🌐 Three-Tier Web Application Deployment with Docker and Kubernetes

This project demonstrates the containerization and orchestration of a classic three-tier web application architecture using **Docker** for image creation and **Kubernetes** for deployment, scaling, and networking.

The application is composed of three distinct services: a web frontend, an authentication service, and a user data service, all backed by a MongoDB database.

<img width="2520" height="1764" alt="🌐 Three-Tier Web Application Deployment with Docker and Kubernetes - visual selection" src="https://github.com/user-attachments/assets/2e60f810-d89d-40c1-9f6d-eccdd2506112" />

## 🏛️ Architecture Overview

The application follows a standard three-tier pattern:

| Tier | Component | Technology | Description |
| :--- | :--- | :--- | :--- |
| **Presentation Tier** | `web-frontend` | Nginx, HTML/CSS/JS | Serves the static sign-in/sign-up user interface and acts as a reverse proxy. |
| **Application Tier** | `auth-service` & `user-service` | Node.js (JavaScript) | Handles business logic, API requests, and communication with the database. |
| **Data Tier** | `mongodb` | MongoDB | The persistent storage for application data (users, sessions, etc.). |

<img width="1584" height="1404" alt="🌐 Three-Tier Web Application Deployment with Docker and Kubernetes - visual selection (1)" src="https://github.com/user-attachments/assets/fc2a7d75-b704-405c-9801-496a09676fb6" />

---

## ⚙️ Implementation Steps

The deployment was executed by following these key phases:

### Phase 1: Docker Containerization

1.  **Image Creation:** A dedicated `Dockerfile` was created for each service (`auth-service`, `user-service`, and `web-frontend`).
    * The Node.js services use a standard Node base image.
    * The `web-frontend` uses a small Nginx base image, where the `nginx.conf` and static files are copied into the Nginx content path.
2.  **Image Build:** Each service was built into a Docker image.
    ```bash
    # Example for auth-service
    docker build -t <DOCKER_HUB_USER>/auth-service:v1 ./auth-service
    ```
3.  **Image Registry:** All resulting images were tagged and pushed to **Docker Hub** for easy access by the Kubernetes cluster.

### Phase 2: Kubernetes Orchestration

1.  **YAML Manifests:** A set of YAML files were created in the `kubernetes-manifests` folder to define the desired state of the application.
    * **Deployments:** Used for the application services and MongoDB to manage replica sets, ensuring high availability and rolling updates.
    * **Services (ClusterIP):** Created for inter-service communication (`auth-service`, `user-service`, `mongodb`), allowing services to discover each other using DNS names.
    * **Service (NodePort/LoadBalancer/Ingress):** Used for the `web-frontend` to expose the application externally.
2.  **Deployment Execution:** The YAML files were applied sequentially to a running Kubernetes cluster.
    ```bash
    kubectl apply -f kubernetes-manifests/
    ```
<img width="2745" height="1908" alt="🌐 Three-Tier Web Application Deployment with Docker and Kubernetes - visual selection (2)" src="https://github.com/user-attachments/assets/24489873-e3cd-4dad-87b4-45be47e2c213" />


---

## 🛠️ Key Technologies Used

* **Docker:** For containerizing the application services.
* **Kubernetes (K8s):** For automated deployment, scaling, and management of the containerized application.
* **Node.js / Express:** Used to develop the RESTful APIs for the backend services.
* **MongoDB:** The NoSQL database used for persistence.
* **Nginx:** Used in the `web-frontend` container as a high-performance web server and reverse proxy.
* **Docker Hub:** The container registry used to store and distribute the built Docker images.

<img width="2628" height="2232" alt="🌐 Three-Tier Web Application Deployment with Docker and Kubernetes - visual selection (3)" src="https://github.com/user-attachments/assets/29f2832e-aed5-486c-98ee-ab1d48c252a7" />

---

## 🏃 Getting Started (Local Setup)

To replicate this deployment on a local cluster (e.g., Minikube or Kind):

1.  **Prerequisites:** Install Docker, `kubectl`, and a local K8s environment (e.g., Minikube).
2.  **Clone the Repository:**
    ```bash
    git clone [YOUR_REPO_URL]
    cd [YOUR_REPO_NAME]
    ```
3.  **Update Image Names:** Edit the deployment YAML files (`kubernetes-manifests/*.yaml`) to reference your own Docker Hub repository names.
4.  **Deploy to Cluster:**
    ```bash
    kubectl apply -f kubernetes-manifests/
    ```
5.  **Access the Application:** Once the pods are running, find the external access point for the `web-frontend` service.
    * *If using Minikube:*
        ```bash
        minikube service web-frontend-service -n <YOUR-NAMESPACE>
        ```
