<p align="center">
  <img src="https://img.shields.io/badge/Spring%20Boot-3.x-6DB33F?style=for-the-badge&logo=springboot&logoColor=white" />
  <img src="https://img.shields.io/badge/MongoDB-Atlas-47A248?style=for-the-badge&logo=mongodb&logoColor=white" />
  <img src="https://img.shields.io/badge/Redis-Cloud-DC382D?style=for-the-badge&logo=redis&logoColor=white" />
  <img src="https://img.shields.io/badge/Docker-Containerized-2496ED?style=for-the-badge&logo=docker&logoColor=white" />
  <img src="https://img.shields.io/badge/Render-Deployed-46E3B7?style=for-the-badge&logo=render&logoColor=white" />
</p>

# ⚡ EasyBackend

**Instant REST APIs without writing a single line of backend code.**

EasyBackend is a Backend-as-a-Service (BaaS) that lets you create fully functional CRUD APIs on the fly. Generate a unique endpoint key, start storing JSON data — and your API is ready. No setup, no schemas, no hassle.

> **Live URL:** [https://easybackend-3zbr.onrender.com](https://easybackend-3zbr.onrender.com)
>

---

## ✨ Features

- **Dynamic API Creation** — Generate a unique key and instantly get full CRUD endpoints
- **Schema-Free** — Send any JSON structure, no predefined models needed
- **Auto-Incrementing IDs** — Each record gets an auto-generated, incrementing ID
- **Custom ID Fields** — Choose your own ID field name (e.g., `userId`, `productId`)
- **Redis Caching** — GET responses are cached for 10 minutes for blazing-fast reads
- **Cache Invalidation** — Write operations (POST/PUT/PATCH/DELETE) automatically clear relevant caches
- **MongoDB Atlas** — Persistent, cloud-hosted NoSQL storage
- **Docker Ready** — Containerized for easy deployment anywhere

---

## 🏗️ Tech Stack

| Layer | Technology |
|-------|------------|
| Framework | Spring Boot 3.x (Java) |
| Database | MongoDB Atlas |
| Caching | Redis Cloud |
| Containerization | Docker |
| Hosting | Render (Free Tier) |
| Frontend | React (Vercel) |

---

## 🚀 How It Works

```
1. Generate a unique key     →   GET  /generateUniqueKey
2. Register your endpoint    →   POST /endpoint
3. Start CRUD operations     →   POST/GET/PUT/PATCH/DELETE /{yourKey}
```

That's it. Three steps to a fully working REST API.

---

## 📡 API Reference

**Base URL:** `https://easybackend-3zbr.onrender.com`

> ⏳ **Note:** First request may take ~50 seconds due to Render free tier cold start.

### 1️⃣ Generate Unique Key

Creates a random unique key that acts as your API namespace.

```
GET /generateUniqueKey
```

**Response:**
```
"aB3xK7mN"
```

> 💡 Save this key — you'll use it as `{uniqueKey}` in all other endpoints.

---

### 2️⃣ Register Endpoint

Registers your unique key and sets the ID field name for your records.

```
POST /endpoint
Content-Type: application/json
```

**Request Body:**
```json
{
  "uniqueKey": "aB3xK7mN",
  "keyId": "id"
}
```

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `uniqueKey` | String | Yes | Your generated unique key |
| `keyId` | String | No | Custom ID field name (defaults to `"id"`) |

**Response:**
```json
{
  "id": "65f...",
  "uniqueKey": "aB3xK7mN",
  "keyId": "id"
}
```

> ⚠️ **This must be done before creating any data.**

---

### 3️⃣ Create Data

Adds a new record with an auto-generated, auto-incrementing ID.

```
POST /{uniqueKey}
Content-Type: application/json
```

**Request Body:**
```json
{
  "name": "Siddharth",
  "email": "siddharth@example.com",
  "role": "Backend Developer",
  "skills": ["Java", "Spring Boot", "MongoDB"]
}
```

**Response:**
```json
{
  "id": "1",
  "name": "Siddharth",
  "email": "siddharth@example.com",
  "role": "Backend Developer",
  "skills": ["Java", "Spring Boot", "MongoDB"]
}
```

---

### 4️⃣ Get All Data

Retrieves all records under your endpoint. Results are cached in Redis for 10 minutes.

```
GET /{uniqueKey}
```

**Response:**
```json
[
  {
    "id": "1",
    "name": "Siddharth",
    "email": "siddharth@example.com",
    "role": "Backend Developer"
  },
  {
    "id": "2",
    "name": "Rahul",
    "email": "rahul@example.com",
    "role": "Frontend Developer"
  }
]
```

---

### 5️⃣ Get Data By ID

Retrieves a single record by its ID. Also cached in Redis.

```
GET /{uniqueKey}/{id}
```

**Response:**
```json
{
  "id": "1",
  "name": "Siddharth",
  "email": "siddharth@example.com",
  "role": "Backend Developer"
}
```

---

### 6️⃣ Full Update (PUT)

Replaces **all** fields of a record (except the ID). Fields not included will be removed.

```
PUT /{uniqueKey}/{id}
Content-Type: application/json
```

**Request Body:**
```json
{
  "name": "Siddharth Kumar",
  "email": "siddharth.kumar@newmail.com",
  "role": "Full Stack Developer",
  "experience": "3 years"
}
```

> ⚡ PUT replaces the entire record. Any fields you don't send will be lost.

---

### 7️⃣ Partial Update (PATCH)

Updates **only** the fields you send. All other existing fields remain untouched.

```
PATCH /{uniqueKey}/{id}
Content-Type: application/json
```

**Request Body:**
```json
{
  "role": "Senior Backend Developer",
  "location": "Bengaluru"
}
```

> Only `role` changes and `location` gets added. Everything else stays the same.

---

### 8️⃣ Delete Single Record

```
DELETE /{uniqueKey}/{id}
```

**Response:**
```
"Data deleted Successfully"
```

---

### 9️⃣ Delete All Data

Removes all records under the given endpoint.

```
DELETE /{uniqueKey}
```

**Response:**
```
"All Data deleted Successfully"
```

> 🔴 **Caution:** This permanently deletes everything under this endpoint.

---

## 🧪 Quick Test with cURL

```bash
# Step 1: Generate a unique key
curl https://easybackend-3zbr.onrender.com/generateUniqueKey

# Step 2: Register endpoint (replace YOUR_KEY with the key from Step 1)
curl -X POST https://easybackend-3zbr.onrender.com/endpoint \
  -H "Content-Type: application/json" \
  -d '{"uniqueKey":"YOUR_KEY","keyId":"id"}'

# Step 3: Create data
curl -X POST https://easybackend-3zbr.onrender.com/YOUR_KEY \
  -H "Content-Type: application/json" \
  -d '{"name":"Siddharth","role":"Developer","skills":["Java","Spring Boot"]}'

# Step 4: Get all data
curl https://easybackend-3zbr.onrender.com/YOUR_KEY

# Step 5: Get by ID
curl https://easybackend-3zbr.onrender.com/YOUR_KEY/1

# Step 6: Full update (PUT)
curl -X PUT https://easybackend-3zbr.onrender.com/YOUR_KEY/1 \
  -H "Content-Type: application/json" \
  -d '{"name":"Siddharth Kumar","role":"Senior Dev"}'

# Step 7: Partial update (PATCH)
curl -X PATCH https://easybackend-3zbr.onrender.com/YOUR_KEY/1 \
  -H "Content-Type: application/json" \
  -d '{"location":"Bengaluru"}'

# Step 8: Delete one record
curl -X DELETE https://easybackend-3zbr.onrender.com/YOUR_KEY/1

# Step 9: Delete all records
curl -X DELETE https://easybackend-3zbr.onrender.com/YOUR_KEY
```

---

## ❌ Error Responses

All errors return a consistent JSON structure:

```json
{
  "message": "Error description",
  "status": "ERROR_TYPE",
  "code": 400
}
```

| Code | Message | Cause |
|------|---------|-------|
| 400 | Invalid JSON format | Malformed JSON in request body |
| 404 | Data not found for the provided Endpoint | Invalid `uniqueKey` or endpoint not registered |
| 404 | Data not found for the provided id | No record exists with the given ID |
| 404 | Please Enter your valid unique Endpoint in Url | Endpoint not registered (Step 2 was skipped) |
| 500 | Unable to connect to Redis | Redis connection issue — check env variables |
| 500 | Database access error | MongoDB connection failure |

---

## 🛠️ Build & Run Locally

### Prerequisites

- Java 17+
- Docker (optional)
- MongoDB instance (local or Atlas)
- Redis instance (local or Cloud)

### Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `MONGODB_URI` | MongoDB connection string | `mongodb+srv://user:pass@cluster.mongodb.net/` |
| `SPRING_REDIS_HOST` | Redis hostname | `redis-16641.c212.ap-south-1-1.ec2.cloud.redislabs.com` |
| `SPRING_REDIS_PORT` | Redis port | `16641` |
| `SPRING_REDIS_PASSWORD` | Redis password | `your-redis-password` |

### Run with Maven

```bash
# Build the JAR (skip tests)
./mvnw clean package -DskipTests

# Run the JAR
java -jar target/easybackend-0.0.1-SNAPSHOT.jar
```

The server starts on **port 9999**: `http://localhost:9999`

### Run with Docker

```bash
# Build image and run container
docker build -t easybackend . && docker run -p 9999:9999 easybackend
```

---

## 📁 Project Structure

```
src/main/java/com/easybackend/
├── config/
│   ├── MongoConfig.java          # MongoDB configuration
│   ├── RedisConfig.java          # Redis + cache manager setup
│   └── ScheduledTasks.java       # Scheduled cleanup tasks
├── controller/
│   └── DynamicDataController.java # All REST endpoints
├── entity/
│   ├── DynamicData.java          # MongoDB document model
│   ├── DynamicDataDto.java       # Response DTO (flat JSON output)
│   └── EndpointData.java         # Endpoint registration model
├── exception/                     # Custom exception handlers
├── repository/
│   ├── DynamicDataRepository.java     # MongoDB queries
│   └── EndpointDataRepository.java    # Endpoint key storage
├── service/
│   ├── DynamicDataService.java        # Service interface
│   └── DynamicDataServiceImpl.java    # Business logic + caching
├── utils/
│   └── Utility.java              # Validation & helper methods
└── EasyBackendApplication.java    # Main application entry point
```

---

## 🏛️ Architecture

```
Client Request
      │
      ▼
┌─────────────────┐
│   Controller     │   Handles HTTP methods, parses JSON/form data
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│    Service       │   Business logic, validation, ID generation
│  + @Cacheable    │   Redis caching on GET endpoints
│  + @CacheEvict   │   Cache invalidation on write operations
└────────┬────────┘
         │
    ┌────┴────┐
    ▼         ▼
┌───────┐ ┌───────┐
│MongoDB│ │ Redis │
│ Atlas │ │ Cloud │
└───────┘ └───────┘
```

---

## 📄 License

This project is open source and available for personal and educational use.

---

<p align="center">
  Built with ☕ by <a href="https://github.com/siddhld">Siddharth</a>
</p>
