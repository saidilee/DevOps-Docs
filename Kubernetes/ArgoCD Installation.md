We will create a namespace for argocd.

kubectl create ns argocd
ArgoCD can be  installed using its manifests. First, you’ll need to download these manifests and apply them to your Minikube cluster.

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v2.5.8/manifests/install.yaml
verify the installation by getting all the objects in the ArgoCD namespace.

kubectl get all -n argocd

By default, the ArgoCD server is not exposed outside the cluster. You can expose it using port-forwarding to access the ArgoCD UI.

kubectl port-forward svc/argocd-server -n argocd --address 0.0.0.0 8080:443
