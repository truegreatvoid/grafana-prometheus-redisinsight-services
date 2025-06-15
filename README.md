# Grafana + Prometheus + MySQL + Redis + RedisInsight + phpMyAdmin + InitVolumes + Exporters

This Docker Compose setup deploys a comprehensive stack for database management and system monitoring.  
It includes MySQL with phpMyAdmin, Redis with RedisInsight, and a monitoring suite with Prometheus, Grafana, MySQL Exporter, and Node Exporter.

---

## Services

- **init-volumes**: Initializes persistent data directories with appropriate permissions.
- **mysql**: MySQL 8.0 database with pre-configured credentials  
  (`database: home`, `user: home`, `password: home`).
- **phpmyadmin**: Web interface for MySQL management  
  Accessible at: [http://localhost:8080](http://localhost:8080)
- **redis**: Redis server with authentication (`password: redis`), persisting data and logs.
- **redisinsight**: Web-based Redis management tool  
  Accessible at: [http://localhost:5540](http://localhost:5540)
- **prometheus**: Monitoring system with custom configuration  
  Accessible at: [http://localhost:9090](http://localhost:9090)
- **grafana**: Visualization dashboard for metrics  
  Accessible at: [http://localhost:3001](http://localhost:3001)
- **mysqld-exporter**: Exports MySQL metrics for Prometheus  
  Accessible at: [http://localhost:9104](http://localhost:9104)
- **node-exporter**: Exports host system metrics for Prometheus  
  Accessible at: [http://localhost:9100](http://localhost:9100)

---

## Prerequisites

- Docker and Docker Compose installed.
- Run the following on the host to ensure Redis stability:

  ```bash
  sudo sysctl -w vm.overcommit_memory=1
  ```

---

## Usage

1. Clone this repository.
2. Ensure the following directories exist (or will be created by `init-volumes`):
    ```
    ./data/mysql
    ./data/redis
    ./data/grafana
    ./logs/redis
    ./prometheus/prometheus.yml
    ./exporter/.my.cnf
    ```
3. Start the services:

    ```bash
    docker-compose up -d
    ```

---

## Access the Services

- phpMyAdmin: [http://localhost:8080](http://localhost:8080)  
- RedisInsight: [http://localhost:5540](http://localhost:5540)  
- Prometheus: [http://localhost:9090](http://localhost:9090)  
- Grafana: [http://localhost:3001](http://localhost:3001)  
- MySQL Exporter: [http://localhost:9104](http://localhost:9104)  
- Node Exporter: [http://localhost:9100](http://localhost:9100)  

---

## Notes

- All services are connected via a custom Docker network (`home_network`) for seamless communication.
- CPU and memory limits are set per service to ensure balanced usage.
- Persistent data is stored in `./data` and `./logs`.
- Default credentials are provided for local use; update them for production environments.
- Ensure `prometheus.yml` and `.my.cnf` are correctly configured before starting the stack.

---

## MySQL Exporter User Setup

To allow Prometheus to collect MySQL metrics using `mysqld_exporter`, you must create a user with proper permissions inside the MySQL server:

```sql
CREATE USER 'exporter'@'%' IDENTIFIED BY 'exporter_pass';
GRANT PROCESS, REPLICATION CLIENT, SELECT ON *.* TO 'exporter'@'%';
FLUSH PRIVILEGES;
```

Make sure the `exporter/.my.cnf` file contains the correct credentials:

```ini
[client]
user=exporter
password=exporter_pass
host=mysql
```

Then restart the exporter container:

```bash
docker-compose restart mysqld_exporter
```

---

## Customization

- Modify environment variables (e.g., passwords, database names) in the `docker-compose.yml` file.
- Update `prometheus.yml` to add or remove monitoring targets.
- Adjust resource limits (`mem_limit`, `cpus`) according to your machine capacity.
