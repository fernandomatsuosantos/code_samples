## Kubernets (AKS)

| Description | Command                                          |
| ----------- | ------------------------------------------------ |
| Deployment  | kubectl create -f deployment.yaml -n (namespace) |
| Ingress     | kubectl create -f ingress.yaml -n (namespace)    |
| Service     | kubectl create -f service.yaml -n (namespace)    |

### Some useful commands

```bash
#Display addresses of the master and services
kubectl cluster-info

#Switch connection to another cluster that already has cached credentials
kubectl config get-contexts
kubectl config use-context (context_name)

#Get pods
kubectl get pods -o wide

#Start pod and run shell / delete pod on exit
kubectl run -it --rm aks-ssh --image=ubuntu

#SSH in a running pod in interactive mode
kubectl exec -it (pod_name) -- sh

#Get service yaml
kubectl get service my-service -o yaml

#Describe with verbose output
kubectl describe pods my-pod

#Listen on port 8080 on the local machine and forward to port 80
kubectl port-forward my-pod 8080:80
kubectl port-forward deployment/my-deployment 8080:80

#Show logs
kubectl logs --since=1h http-deployment
kubectl logs --tail=20 http-deployment

#Show logs from a specific app
kubectl logs --ignore-errors=true --max-log-requests=50 -f -l app=(app_name)

#Delete Evicted pods from all namespaces
kubectl get pods --all-namespaces | grep Evicted | awk '{print $2 " --namespace=" $1}' | xargs -n 2 -d '\n' bash -c 'kubectl delete pod $0 $1'
```

### Pod

| Description                      | Command                                                                                                                                          |
| -------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| List all pods                    | kubectl get pods                                                                                                                                 |
| List pods for all namespace      | kubectl get pods -all-namespaces                                                                                                                 |
| List all critical pods           | kubectl get -n kube-system pods -a                                                                                                               |
| List pods with more information  | kubectl get pod -o wide                                                                                                                          |
| List pods and output to YAML     | kubectl get pod -o yaml                                                                                                                          |
| Get pod info                     | kubectl describe pod/(pod name)                                                                                                                  |
| List all pods with labels        | kubectl get pods --show-labels                                                                                                                   |
| List running pods                | kubectl get pods --field-selector=status.phase=Running --all-namespaces                                                                          |
| Watch pods                       | kubectl get pods -n (namespace) --watch                                                                                                          |
| List pods and containers         | `kubectl get pods --all-namespaces -o='custom-columns=PODS:.metadata.name,CONTAINERS:.spec.containers[*].name'`                                  |
| List pods, containers and images | `kubectl get pods --all-namespaces -o='custom-columns=PODS:.metadata.name,CONTAINERS:.spec.containers[*].name,Images:.spec.containers[*].image'` |
| Scale out Deployment             | kubectl scale --replicas=3 ds (name)                                                                                                             |
| Log file of pod                  | kubectl logs (pod)                                                                                                                               |
| Log file of a previous pod       | kubectl logs (pod) --previous                                                                                                                    |
| Tail logs of pod                 | kubectl logs -f (pod)                                                                                                                            |

### Resources Deletion

| Description                             | Command                                                        |
| --------------------------------------- | -------------------------------------------------------------- |
| Delete pod                              | kubectl delete pod/(pod-name) -n (my-namespace)                |
| Delete by file                          | kubectl delete -f (nameofyaml).yaml                            |
| Delete pod by force                     | kubectl delete pod/(pod-name) --grace-period=0 --force         |
| Delete pods by labels                   | kubectl delete pod -l (key)=(label)                            |
| Delete deployments by labels            | kubectl delete deployment -l (key)=(label)                     |
| Delete all resources filtered by labels | kubectl delete pods,services -l (key)=(label)                  |
| Delete resources under a namespace      | kubectl -n (namespace) delete po,svc --all                     |
| Delete all pods in namespace            | kubectl delete --all pods -n kubectl describe podmy-namespace) |

### Service

| Description                | Command                                                                                         |
| -------------------------- | ----------------------------------------------------------------------------------------------- |
| List all services          | kubectl get services --all-namespaces                                                           |
| List service endpoints     | kubectl get endpoints --all-namespaces                                                          |
| Get service detail in YAML | kubectl get service (servicename) -n (namespace) -o yaml                                        |
| Get service cluster ip     | kubectl get service (servicename) -n (namespace) -o go-template='{{.spec.clusterIP}}'           |
| Get service cluster port   | kubectl get service (servicename) -n (namespace) -o go-template='{{(index .spec.ports 0).port}} |

### Events & Metrics

| Description                     | Command                                                  |
| ------------------------------- | -------------------------------------------------------- |
| View all events                 | kubectl get events --all-namespaces                      |
| List Events sorted by timestamp | kubectl get events --sort-by=.metadata.creationTimestamp |

### Namespace & Security

| Description                   | Command                                                                        |
| ----------------------------- | ------------------------------------------------------------------------------ |
| List authenticated contexts   | kubectl config get-contexts                                                    |
| Load context from config file | kubectl get cs --kubeconfig (kubeconfig file).yml                              |
| Switch context                | kubectl config use-context (cluster-name)                                      |
| Delete the specified context  | kubectl config delete-context (cluster-name)                                   |
| List all namespaces defined   | kubectl get namespaces                                                         |
| Set namespace preference      | kubectl config set-context $(kubectl config current-context) --namespace=(ns1) |
| List certificates             | kubectl get csr --all-namespaces                                               |

### Intermediate Commands

| Description                          | Command                                                                        |
| ------------------------------------ | ------------------------------------------------------------------------------ |
| Run curl test temporarily            | kubectl run --rm mytest --image=yauritux/busybox-curl -it                      |
| Run wget test temporarily            | kubectl run --rm mytest --image=busybox -it                                    |
| Run nginx deployment with 2 replicas | kubectl run my-nginx --image=nginx --replicas=2 --port=80                      |
| Set namespace preference             | kubectl config set-context $(kubectl config current-context) --namespace=(ns1) |
| List everything                      | kubectl get all --all-namespaces                                               |
| Get all services                     | kubectl get service --all-namespaces                                           |

### Formatting output

To output details to your terminal window in a specific format, add the -o (or --output) flag to a supported kubectl command.
| Output format | Description |
| --- | --- |
| -o=custom-columns=(spec) | Print a table using a comma separated list of custom columns |
| -o=custom-columns-file=(filename) | Print a table using the custom columns template in the (filename) file |
| -o=json | Output a JSON formatted API object |
| -o=jsonpath=(template) | Print the fields defined in a jsonpath expression |
| -o=jsonpath-file=(filename) | Print the fields defined by the jsonpath expression in the (filename) file |
| -o=name | Print only the resource name and nothing else |
| -o=wide | Output in the plain-text format with any additional information, and for pods, the node name is included |
| -o=yaml | Output a YAML formatted API object |

More information at:

- <https://kubernetes.io/docs/reference/kubectl/cheatsheet/>  
- <https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands>  
