## Connect with Me

- **YouTube**: [Watch and Learn on YouTube](https://www.youtube.com/@AshokKumar-DevOps)  
- **LinkedIn**: [Connect with me on LinkedIn](https://www.linkedin.com/in/ashokkumar-devops13/)  
- **TopMate**: [Support or Consult on TopMate](https://topmate.io/ashok_kumar)  

## Support This Project

If you find this content helpful:
- **Like** the [YouTube video](https://www.youtube.com/@AshokKumar-DevOps) for more such tutorials.
- **Star** this GitHub repository to get the latest updates.

# Kubernetes Errors & Troubleshooting

## 1. CrashLoopBackOff Error

- **Cause:** The container is repeatedly failing and restarting.
- **Fix:**
    1. Inspect logs:
        ```bash
        kubectl logs <pod-name>
        ```
    2. Check readiness/liveness probes in the pod configuration.
    3. Validate the application code or configuration (e.g., missing environment variables).

---

## 2. ImagePullBackOff

- **Cause:** Kubernetes cannot pull the specified container image.
- **Fix:**
    1. Check the image name and tag:
        ```yaml
        spec:
          containers:
          - image: <repository>/<image>:<tag>
        ```
    2. Ensure the image exists in the container registry.
    3. For private images, create a `Secret` for authentication:
        ```bash
        kubectl create secret docker-registry <secret-name> \
          --docker-server=<registry> --docker-username=<user> \
          --docker-password=<password> --docker-email=<email>
        ```

---

## 3. ErrImageNeverPull

- **Cause:** The image pull policy is set to `Never`, and the image is not locally available.
- **Fix:**
    1. Update `imagePullPolicy`:
        ```yaml
        imagePullPolicy: IfNotPresent
        ```
    2. Or ensure the image exists locally using:
        ```bash
        docker images
        ```

---

## 4. Node Not Ready

- **Cause:** The Kubernetes node is in a "NotReady" state.
- **Fix:**
    1. Check node status:
        ```bash
        kubectl describe node <node-name>
        ```
    2. Restart kubelet:
        ```bash
        systemctl restart kubelet
        ```
    3. Ensure sufficient resources (CPU, memory).

---

## 5. Pending Pods

- **Cause:** No available nodes match the pod's scheduling requirements.
- **Fix:**
    1. Check pod events:
        ```bash
        kubectl describe pod <pod-name>
        ```
    2. Remove unnecessary resource requests/limits.
    3. Verify taints/tolerations and affinity rules.

---

## 6. OOMKilled Error

- **Cause:** The container exceeded its memory limit.
- **Fix:**
    1. Increase memory limits:
        ```yaml
        resources:
          limits:
            memory: "512Mi"
        ```
    2. Optimize the application to use less memory.

---

## 7. Pod Stuck in Terminating

- **Cause:** Kubernetes cannot delete the pod.
- **Fix:**
    1. Force delete the pod:
        ```bash
        kubectl delete pod <pod-name> --grace-period=0 --force
        ```
    2. Check for issues with the volume detach process.

---

## 8. Service Not Accessible

- **Cause:** Service is misconfigured or backend pods are not ready.
- **Fix:**
    1. Verify the service type and configuration:
        ```bash
        kubectl describe service <service-name>
        ```
    2. Check endpoints:
        ```bash
        kubectl get endpoints <service-name>
        ```

---

## 9. Error: Forbidden - User Cannot Access Resource

- **Cause:** RBAC policy does not permit the action.
- **Fix:**
    1. Check and modify role bindings:
        ```bash
        kubectl edit rolebinding <role-binding-name>
        ```

---

## 10. PVC Pending

- **Cause:** No matching storage class or insufficient storage.
- **Fix:**
    1. Check storage classes:
        ```bash
        kubectl get storageclass
        ```
    2. Update PVC to use a valid storage class.

---

## 11. Unauthorized Error

- **Cause:** Incorrect Kubernetes credentials.
- **Fix:**
    1. Refresh kubeconfig:
        ```bash
        aws eks update-kubeconfig --name <cluster-name>
        ```

---

## 12. ImagePullSecrets Missing

- **Cause:** Pulling private images without authentication secrets.
- **Fix:**
    1. Attach a valid `imagePullSecrets` to the pod spec:
        ```yaml
        imagePullSecrets:
        - name: <secret-name>
        ```

---

## 13. Pod Stuck in ContainerCreating

- **Cause:** Issues with the container runtime or network plugin.
- **Fix:**
    1. Check events:
        ```bash
        kubectl describe pod <pod-name>
        ```
    2. Restart container runtime (e.g., Docker or CRI-O).

---

## 14. DNS Resolution Failure

- **Cause:** Kubernetes DNS not resolving service names.
- **Fix:**
    1. Check CoreDNS logs:
        ```bash
        kubectl logs -n kube-system <coredns-pod>
        ```
    2. Update the `resolv.conf` file or CoreDNS ConfigMap.

---

## 15. Pod Disruption Budget (PDB) Violations

- **Cause:** Insufficient pods available to meet PDB.
- **Fix:**
    1. Temporarily remove or adjust the PDB:
        ```bash
        kubectl edit pdb <pdb-name>
        ```

---

## 16. kube-apiserver is Down

- **Cause:** The control plane node is not functioning.
- **Fix:**
    1. Restart the kube-apiserver:
        ```bash
        systemctl restart kube-apiserver
        ```
