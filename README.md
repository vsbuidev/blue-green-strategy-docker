# Blue-Green Deployment Strategy for Multi-Service Application (React + Node.js + MongoDB + Redis)

This project demonstrates a full-stack Dockerized application with a **Blue-Green deployment strategy** for zero-downtime updates.

---

## Tech Stack

| Layer         | Tech                  |
| ------------- | --------------------- |
| Frontend      | React (Vite)          |
| Backend       | Node.js (Express)     |
| Database      | MongoDB               |
| Cache         | Redis                 |
| Proxy         | Nginx (reverse proxy) |
| Orchestration | Docker Compose        |

---

## Blue-Green Deployment Explained

Blue-Green Deployment allows two identical environments to run in parallel:

- **Blue** – the current production version
- **Green** – the new version for deployment testing

Once Green passes health checks, traffic is switched from Blue to Green **instantly**, minimizing downtime and risk.

---

## Project Structure

```bash
multi-service-app/
│── backend/ # Express API
│── frontend/ # React + Vite App
│── proxy/ # Nginx reverse proxy
│── docker-compose.blue.yml
│── docker-compose.green.yml
│── switch-to-green.sh
│── rollback-to-blue.sh
│── README.md
```

---

## 🛠️ Getting Started

### 1. Clone the Repo

```bash
git clone https://github.com/vsbuidev/blue-green-strategy-docker.git
cd blue-green-strategy-docker
```

### 2. 🔵 Start the Blue Stack - Current Production Version

```bash
docker-compose -f docker-compose.blue.yml up -d --build
```

This runs the "blue" version at:

Proxy: http://localhost

Frontend: http://localhost:5173

API: http://localhost:5001/api/users

### 3. 🟢 Start the Green Stack - Deploying a new version (Green)

```bash
docker-compose -f docker-compose.green.yml up -d --build
```

Green stack will run:

Frontend: mapped internally or change the port to 5174

Backend: on port 5001

### 4. Health Check

Ensure the backend responds at /health:

```bash
curl http://localhost:5001/health
```

### 5. Switch Traffic to Green

```bash
./switch-to-green.sh
```

This updates Nginx to route traffic to the Green stack and restarts the proxy.

### 6. Rollback to Blue, In case of issues:

```bash
./rollback-to-blue.sh
```

This switches Nginx back to the Blue stack.

## Notes

- MongoDB and Redis are shared between both environments.
- Update ports, health endpoints, and service names if needed.

## Contributing

Feel free to fork and submit pull requests!

## License

Distributed under the MIT License. See `LICENSE` for more information.

## Acknowledgements

Special thanks to all the open-source libraries and tools used in this project. and this project is based on the [DevOps Roadmap's Project](https://roadmap.sh/projects/blue-green-deployment)
