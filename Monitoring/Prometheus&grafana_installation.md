**Step 1: Install Minikube on AWS Ubuntu**

Ensure your system is updated:

```

sudo apt update && sudo apt upgrade -y

```

Install required dependencies:

```

sudo apt install -y curl wget apt-transport-https ca-certificates conntrack

```

Download and install Minikube:

```

curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
rm minikube-linux-amd64

```

Verify installation:

```

minikube version

```

---

## **Step 2: Start Minikube**

Since you're running Minikube on AWS Ubuntu (without a GUI), use the **none** driver (runs directly on the host):

Confirm Minikube is running:

```

kubectl cluster-info

```

---

## **Step 3: Install Helm**

Download and install Helm:

```

curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

```

Verify installation:

```

helm version

```

---

## **Step 4: Add Prometheus & Grafana Helm Repositories**

```

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

```

---

## **Step 5: Create a Monitoring Namespace**

```

kubectl create namespace monitoring

```

---

## **Step 6: Install Prometheus & Grafana**

Install **Prometheus and Grafana** using the Helm chart:

```

helm install prometheus prometheus-community/kube-prometheus-stack --namespace monitoring

```

---

## **Step 7: Verify Installation**

Check if all pods are running:

```

kubectl get pods -n monitoring

```

Expected output:

```

NAME                                                     READY   STATUS    RESTARTS   AGE
alertmanager-prometheus-kube-prometheus-alertmanager-0   2/2     Running   0          2m
prometheus-kube-prometheus-operator-xxxxxx              1/1     Running   0          2m
prometheus-kube-prometheus-prometheus-0                 2/2     Running   0          2m
grafana-xxxxxx                                          2/2     Running   0          2m

```

---

## **Step 8: Access Prometheus Dashboard**

Since you are on an AWS Ubuntu instance without a GUI, you need to **expose Prometheus** externally.

First, get the Prometheus service name:

Find the Prometheus service, which is usually named **prometheus-kube-prometheus-prometheus**.

Expose it as a **NodePort** service:

```
kubectl patch svc prometheus-kube-prometheus-prometheus -n monitoring -p '{"spec": {"type": "NodePort"}}'

```

Get the **NodePort**:

```

kubectl get svc prometheus-kube-prometheus-prometheus -n monitoring -o=jsonpath='{.spec.ports[0].nodePort}'

```

Find the public IP of your AWS Ubuntu instance:

```

curl -s ifconfig.me

```

Now, open Prometheus in your browser using:

```

http://<AWS_PUBLIC_IP>:<NODEPORT>

```

---

## **Step 9: Access Grafana Dashboard**

Expose **Grafana** as a **NodePort** service:

```

kubectl patch svc prometheus-grafana -n monitoring -p '{"spec": {"type": "NodePort"}}'

```

Get the **NodePort** for Grafana:

```

kubectl get svc prometheus-grafana -n monitoring -o=jsonpath='{.spec.ports[0].nodePort}'

```

Now, open Grafana in your browser using:

```

http://<AWS_PUBLIC_IP>:<NODEPORT>

```

---

## **Step 10: Get Grafana Credentials**

Grafana's default username is **admin**.

To get the password, run:

```

kubectl get secret -n monitoring prometheus-grafana -o jsonpath="{.data.admin-password}" | base64 --decode

```

Login to Grafana using:

- **Username:** `admin`
- **Password:** (from the above command)

---

## **Step 11: Configure Prometheus as a Data Source in Grafana**

1. In **Grafana**, go to **Configuration > Data Sources**.
2. Click **Add data source** and select **Prometheus**.
3. Enter the Prometheus service URL:
    
    ```
    
    http://prometheus-kube-prometheus-prometheus.monitoring.svc:9090
    
    ```
    
4. Click **Save & Test**.

---

## **Step 12: Import Grafana Dashboards**

1. Go to **Dashboards > Import**.
2. Use **Dashboard ID** from the Grafana Dashboard Library.
3. Click **Load**, select **Prometheus** as the data source, and **Import**.