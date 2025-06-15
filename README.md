# Grafana + Prometheus + MySQL + Redis + RedisInsight + phpMyAdmin + InitVolumes + *exporter

## Docker Compose for Monitoring and Database Stack

This Docker Compose setup deploys a comprehensive stack for database management and system monitoring. It includes MySQL with phpMyAdmin, Redis with RedisInsight, and a monitoring suite with Prometheus, Grafana, MySQL Exporter, and Node Exporter.

## Services
- **init-volumes**: Initializes persistent data directories with appropriate permissions.
- **mysql**: MySQL 8.0 database with pre-configured credentials (database: `home`, user: `home`, password: `home`).
- **phpmyadmin**: Web interface for MySQL management, accessible at `http://localhost:8080`.
- **redis**: Redis server with authentication (password: `redis`), persisting data and logs.
- **redisinsight**: Web-based Redis management tool, accessible at `http://localhost:5540`.
- **prometheus**: Monitoring system with custom configuration, accessible at `http://localhost:9090`.
- **grafana**: Visualization dashboard for metrics, accessible at `http://localhost:3001`.
- **mysqld-exporter**: Exports MySQL metrics for Prometheus, accessible at `http://localhost:9104`.
- **node-exporter**: Exports host system metrics for Prometheus, accessible at `http://localhost:9100`.

## Prerequisites
- Docker and Docker Compose installed.
- Run `sudo sysctl -w vm.overcommit_memory=1` on the host to ensure Redis stability.

## Usage
1. Clone this repository.
2. Ensure the following directories exist or are created by `init-volumes`:
   - `./data/mysql`, `./data/redis`, `./data/grafana`, `./logs/redis`
   - `./prometheus/prometheus.yml` (Prometheus config)
   - `./exporter/.my.cnf` (MySQL Exporter config)
3. Run:
   ```bash
   docker-compose up -d