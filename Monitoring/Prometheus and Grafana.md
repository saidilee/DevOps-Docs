## **What is Prometheus?**

Prometheus is an open-source **monitoring and alerting system** designed for reliability and scalability. It collects metrics from configured targets at given intervals, evaluates rule expressions, displays results, and triggers alerts if conditions are met

### **Key Features of Prometheus**

- **Time-series database** that stores data in a structured format.
- **Pull-based architecture**, where Prometheus scrapes data from endpoints.
- **Powerful query language (PromQL)** for analysis and visualization.
- **Built-in alerting** with Alertmanager integration.
- **Service discovery** for dynamic environments like Kubernetes.

---

## **Components of Prometheus**

Prometheus consists of multiple components working together:

### **1. Prometheus Server**

🔹 **Core component** responsible for scraping, storing, and querying metrics.

🔹 It consists of:

- **Time-series database** to store metric data.
- **Scraper** to collect metrics from targets.
- **PromQL Engine** to execute queries.

**Example:**

- Scrapes metrics from `http://node-exporter:9100/metrics`.
- Stores the response as time-series data.

---

### **2. Data Collection: Exporters & Instrumentation**

Prometheus collects metrics via two main methods:

### **A. Exporters (For External Services)**

Exporters are **agents** that expose metrics in Prometheus format.

Common Exporters:

| Exporter | Purpose | Port |
| --- | --- | --- |
| **Node Exporter** | Monitors system-level metrics (CPU, RAM, Disk, etc.) | `9100` |
| **cAdvisor** | Collects Docker container metrics | `8080` |
| **Blackbox Exporter** | Probes HTTP, TCP, DNS endpoints | `9115` |
| **MySQL Exporter** | Collects MySQL database metrics | `9104` |

**Example:**

```

http://<node_exporter_ip>:9100/metrics

```

Returns:

```

node_cpu_seconds_total{cpu="0",mode="idle"} 12345.67

```

### **B. Instrumentation (For Custom Applications)**

Applications can be **instrumented** to expose Prometheus metrics using:

- Python (`prometheus_client`)
- Java (`Micrometer`)
- Go (`prometheus/client_golang`)

Example in Python:

```python

from prometheus_client import start_http_server, Counter
REQUESTS = Counter('http_requests_total', 'Total HTTP Requests')
start_http_server(8000)

```

Metrics will be exposed at `http://localhost:8000/metrics`.

---

### **3. Service Discovery**

Prometheus dynamically discovers services using:
✅ **Kubernetes (Pod, Service, Endpoints)**

✅ **Consul, Etcd, AWS EC2, Azure, GCP**

✅ **Static configurations** (manual IPs)

**Example Kubernetes Service Discovery Config:**

```yaml

scrape_configs:
  - job_name: 'kubernetes-pods'
    kubernetes_sd_configs:
      - role: pod

```

---

### **4. PromQL (Prometheus Query Language)**

PromQL allows querying and aggregating metrics.

✅ **Get CPU Usage for last 5 mins:**

```

rate(node_cpu_seconds_total[5m])

```

✅ **Count active HTTP requests:**

```

http_requests_total

```

✅ **Average Memory Usage by Pod:**

```

avg(container_memory_usage_bytes) by (pod)

```

---

### **5. Alertmanager (Handles Alerts)**

🔹 **Manages and routes alerts** to destinations like Slack, Email, PagerDuty.

🔹 **Deduplicates and silences** alerts.

🔹 Works with **Prometheus Alerting Rules**.

**Example Alert Rule:**

```yaml

groups:
  - name: high_cpu
    rules:
      - alert: HighCPUUsage
        expr: avg(rate(node_cpu_seconds_total[2m])) > 80
        for: 5m
        labels:
          severity: critical
        annotations:
          description: "CPU usage is above 80% for 5 minutes"

```

If CPU usage >80% for 5 minutes, an alert is triggered.

---

## **What is Grafana?**

Grafana is an **open-source visualization and analytics platform** used to create **dashboards** from Prometheus and other data sources.

### **Key Features**

✅ **Connects to multiple data sources** (Prometheus, MySQL, Elasticsearch, AWS CloudWatch).

✅ **Custom dashboards** with graphs, tables, and heatmaps.

✅ **Alerts & notifications** via Slack, PagerDuty, Email.

✅ **User authentication & permissions**.

---

## **Components of Grafana**

### **1. Data Sources**

Grafana supports **Prometheus, InfluxDB, MySQL, PostgreSQL, AWS CloudWatch, etc.**

**Add Prometheus as Data Source in Grafana:**
1️⃣ Go to **Configuration → Data Sources → Add Data Source**

2️⃣ Select **Prometheus**

3️⃣ Enter URL: `http://prometheus-kube-prometheus-prometheus.monitoring.svc:9090`

4️⃣ Click **Save & Test**

---

### **2. Dashboards & Panels**

🔹 **Dashboards** → Collection of **Panels**

🔹 **Panels** → Display **Graphs, Gauges, Tables, Heatmaps**

🔹 **Templates** → Dynamic queries with dropdowns

Example Query in Grafana:

```

rate(node_cpu_seconds_total{mode="idle"}[5m])

```

🔹 Displays CPU usage over time.

---

### **3. Alerting in Grafana**

Grafana can trigger **alerts** and send notifications.

✅ **Set Alert Conditions** → E.g., CPU usage > 80%

✅ **Alert Destinations** → Email, Slack, PagerDuty

✅ **Alert Rules** → Define conditions and thresholds

---

## **Prometheus vs. Grafana: What's the Difference?**

| Feature | **Prometheus** | **Grafana** |
| --- | --- | --- |
| Purpose | **Monitoring & Alerting** | **Visualization & Dashboards** |
| Data Storage | **Time-series DB** | **Queries data sources** |
| Query Language | **PromQL** | **Uses PromQL, SQL, etc.** |
| Alerts | **Yes (Alertmanager)** | **Yes (Built-in Alerts)** |
| UI | **Basic Graphs** | **Rich & Custom Dashboards** |

---

## **Final Architecture of Prometheus + Grafana**

1️⃣ **Prometheus Server** scrapes metrics.

2️⃣ **Exporters** expose system/app metrics.

3️⃣ **Alertmanager** sends alerts.

4️⃣ **Grafana** visualizes Prometheus data.

5️⃣ **Kubernetes Service Discovery** automatically finds new targets.

---

## **Conclusion**

✅ **Prometheus** is a monitoring and alerting system.

✅ **Grafana** is a visualization tool for Prometheus and other data sources.

✅ **Exporters** help collect metrics from various systems.

✅ **Alertmanager** handles Prometheus alerts.