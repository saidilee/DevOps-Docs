## Connect with Me

- **YouTube**: [Watch and Learn on YouTube](https://www.youtube.com/@AshokKumar-DevOps)  
- **LinkedIn**: [Connect with me on LinkedIn](https://www.linkedin.com/in/ashokkumar-devops13/)  
- **TopMate**: [Support or Consult on TopMate](https://topmate.io/ashok_kumar)  

## Support This Project

If you find this content helpful:
- **Like** the [YouTube video](https://www.youtube.com/@AshokKumar-DevOps) for more such tutorials.
- **Star** this GitHub repository to get the latest updates.

# Kubernetes Troubleshooting Scenarios

## Scenario 1: Application Downtime During Deployment

**Problem:** During deployment, all old pods are terminated before the new pods are ready, causing application downtime.

**Solution:**

- Configure the deployment's strategy to use `RollingUpdate`.
- Set `maxUnavailable` to `0` and `maxSurge` to a higher value.
- Ensure readiness probes are correctly configured to verify pod readiness before marking it as available.

## Scenario 2: Pending Pods Due to Node Constraints

**Problem:** Pods remain in a `Pending` state due to insufficient CPU or memory resources.

**Solution:**

- Check the pod’s resource requests and limits.
- Scale the cluster by adding more nodes.
- Use the `kubectl describe pod` command to examine event logs.

## Scenario 3: Pod Fails to Communicate with Another Service

**Problem:** A pod cannot connect to another service despite correct service and endpoint configurations.

**Solution:**

- Verify network policies are not blocking traffic.
- Check service selectors and pod labels for mismatches.
- Test connectivity using `curl` or `ping` from within the pod.

## Scenario 4: Node Goes NotReady After Update

**Problem:** After a Kubernetes version upgrade, a worker node shows as `NotReady`.

**Solution:**

- Restart the `kubelet` service.
- Verify node components (e.g., `kube-proxy`) are running.
- Inspect logs in `/var/log` for specific errors.

## Scenario 5: Data Loss After Pod Restart

**Problem:** Stateful application data is lost after pod restart due to lack of persistent storage.

**Solution:**

- Use `PersistentVolume` (PV) and `PersistentVolumeClaim` (PVC).
- Modify the application’s YAML file to mount the volume.

## Scenario 6: CrashLoopBackOff Due to Misconfigured Environment Variables

**Problem:** Application deployment fails due to incorrect database credentials.

**Solution:**

- Update environment variables in the deployment YAML file.
- Use Kubernetes `Secrets` to manage sensitive information securely.

## Scenario 7: High Latency in a Service

**Problem:** Traffic is unevenly distributed among pods, leading to high latency.

**Solution:**

- Check if the service uses `ExternalTrafficPolicy: Local`.
- Verify the health checks on all pods.
- Use a `LoadBalancer` service or optimize pod affinity rules.

## Scenario 8: OOMKilled Pods

**Problem:** Pods are terminated with an `OOMKilled` status due to memory spikes.

**Solution:**

- Increase memory limits in the pod specification.
- Optimize application code to handle memory usage.
- Implement HPA with resource requests.

## Scenario 9: ImagePullBackOff During Deployment

**Problem:** Pod fails to pull an image from a private container registry after credential rotation.

**Solution:**

- Update the Docker registry secret using `kubectl create secret docker-registry`.
- Link the secret to the service account.

## Scenario 10: Failed Horizontal Pod Autoscaling

**Problem:** HPA does not scale pods during traffic surge.

**Solution:**

- Check if the metrics server is installed and running.
- Verify resource metrics (CPU/Memory) meet the threshold.

## Scenario 11: Ingress Controller Not Routing Traffic

**Problem:** Ingress controller logs show `404 Not Found` errors.

**Solution:**

- Verify ingress rules and hostnames.
- Check DNS resolution for the ingress hostname.
- Ensure the ingress controller is correctly configured.

## Scenario 12: PersistentVolume Not Bound

**Problem:** PVC remains in a `Pending` state due to no suitable PVs.

**Solution:**

- Verify the storage class matches between PVC and PV.
- Check PV availability and capacity.

## Scenario 13: Pod Fails Due to Read-Only Filesystem

**Problem:** Pod fails to write to its filesystem because the mounted volume is read-only.

**Solution:**

- Verify volume mount configuration in the pod’s YAML file.
- Check permissions on the volume.

## Scenario 14: Service Discovery Fails After Namespace Change

**Problem:** Pods fail to communicate after migrating to a new namespace.

**Solution:**

- Update service names to include the namespace, e.g., `service-name.namespace.svc.cluster.local`.
- Reapply DNS policies if modified.

## Scenario 15: High Disk I/O on Node Hosting Logging Pods

**Problem:** A node experiences high disk I/O due to logging and monitoring pods.

**Solution:**

- Rotate and compress logs using `logrotate`.
- Use a remote logging solution like Fluentd or Elasticsearch.
- Monitor disk usage and scale logging pods as needed.
