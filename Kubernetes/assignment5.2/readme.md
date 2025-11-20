**Title: Hands-On Assignment: ReplicaSets, Deployments, and DaemonSets in Kubernetes**

**Objective:**
This assignment will give you hands-on experience with managing workloads in Kubernetes using ReplicaSets, Deployments, and DaemonSets.

---

## **1. ReplicaSets**

### **Task 1.1: Create a ReplicaSet**

* Write a YAML manifest `replicaset.yaml` that:

  * Runs 3 replicas of an `nginx` container
  * Labels each pod with `app: nginx`
* Apply the manifest and verify the ReplicaSet and pods.

```bash
kubectl apply -f replicaset.yaml
kubectl get rs
kubectl get pods -l app=nginx
```

### **Task 1.2: Scale the ReplicaSet**

* Scale the ReplicaSet to 5 replicas using:

  * kubectl command
  * by editing the YAML file
* Verify the scaling worked.

---

## **2. Deployments**

### **Task 2.1: Create a Deployment**

* Write a YAML manifest `deployment.yaml` that:

  * Deploys 2 replicas of an `httpd` container
  * Exposes port 80
* Apply and verify the Deployment.

```bash
kubectl apply -f deployment.yaml
kubectl get deployments
kubectl get pods -l app=httpd
```

### **Task 2.2: Update the Deployment**

* Update the image from `httpd` to `httpd:2.4-alpine`.
* Verify the rollout status using `kubectl`.
* Check the updated pods.

### **Task 2.3: Rollback the Deployment**

* Perform a rollback to the previous version using `kubectl`.
* Verify that pods are reverted to the old version.

---

## **3. DaemonSets**

### **Task 3.0: Initialize a Minikube Cluster with 2 Nodes**

* Start a Minikube cluster with 2 nodes to test the DaemonSet behavior:

```bash
minikube start --nodes=2
```

* Verify that both nodes are part of the cluster:

```bash
kubectl get nodes
```

### **Task 3.1: Create a DaemonSet**

* Write a YAML manifest `daemonset.yaml` that:

  * Runs a `busybox` container with the command `sleep 3600`
  * Ensures one pod runs on every node in the cluster
* Apply the DaemonSet and verify pods.

```bash
kubectl apply -f daemonset.yaml
kubectl get ds
kubectl get pods -o wide
```

### **Task 3.2: Observe Node Distribution**

* Verify that exactly one pod is scheduled on each node.
* Add a new node (if using Minikube, try `minikube node add`), then confirm a new pod is scheduled automatically.

---

## **4. Cleanup**

```bash
kubectl delete -f replicaset.yaml
kubectl delete -f deployment.yaml
kubectl delete -f daemonset.yaml
```

---

**Deliverables:**

* Submit the YAML manifests (`replicaset.yaml`, `deployment.yaml`, `daemonset.yaml`)
* Provide screenshots or output of `kubectl get rs,deployments,ds,pods` showing your work

**Outcome:**
By completing this assignment, you will gain hands-on experience with ReplicaSets, Deployments, and DaemonSets, including scaling, updating, rolling back, and node-aware scheduling.
