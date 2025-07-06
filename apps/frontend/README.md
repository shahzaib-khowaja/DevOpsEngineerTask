
---

## 🚀 Getting Started

### Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- Node.js (optional, for local development)

---

### 🔧 Build & Run the Docker Container

```bash
# Build the image
docker build -t devops-task-frontend .

# Run the container on port 5000
docker run -p 5000:5000 devops-task-frontend

