1. Install AWS CLI and eksctl
2. Setup AWS Credentials
3. Install kubectl
4. Install Helm chart
5. Create Kubernetes cluster in AWS using eksctl
6. Install Kubernetes Metrics Server
7. Install Prometheus
8. Install grafana
9. Import Grafana dashboard from Grafana Labs
10. Deploy a spring boot microservice and monitor it on Grafana

1. Install AWS CLI and eksctl:
-------------------------------
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
$ sudo apt install zip
unzip awscliv2.zip
sudo ./aws/install

aws --version 

Install eksctl:
------------------
** Download the latest release -
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin


2. Setup AWS Credentials
-------------------------
Goto your AWS account- Goto Security Credentials - Click on Access Keys - Then Create New Access Key

Run the command "aws configure" and then enter AWS Access key ID and AWS secret access key

$$ aws configure

3. Install kubectl:
-------------------
curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"

chmod +x ./kubectl 

sudo mv ./kubectl /usr/local/bin

kubectl version 


4. Install Helm chart
-----------------------
-> The next tool we need is Helm Chart. If you are working on setting up Prometheus and Grafan for the Kubernetes cluster then it is always recommended using the Helm Chart Repository - https://prometheus-community.github. io/helm-charts so that you do not miss any configuration step.
-> Helm Chart works out of the box and it will take care of everything for you by installing prometheus-alertnamanger, prometheus-server, prometheus-operator.

4.1 Install Helm Chart - Use the following script to install the helm chart -
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

4.2 Verify Helm Chart installation
WARNING: Kubernetes configuration file is group-readable. This is insecure. Location: /home/vagrant/.kube/config
version.BuildInfo{Version:"v3.4.0", GitCommit:"7090a89efc8a18f3d8178bf47d2462450349a004", GitTreeState:"clean", GoVersion:"go1.14.10"}


5. Create Kubernetes cluster in AWS using eksctl
-------------------------------------------------

5.1 Creae Kubernetes Cluster - Goto your terminal and run the following create cluster command -

eksctl create cluster --name test-cluster-1 --version 1.22 --region eu-central-1 --nodegroup-name worker-nodes 
--node-type t2.large --nodes 2 --nodes-min 2 --nodes-max 3

** eksctl create cluster - This is will tell eksctl to create a Kubernetes cluster
--name test-cluster-1 - The --name flag is used for assigning the name of the cluster
--version 1.18 - The --version flag is used for choosing the Kubernetes version which you want to install on AWS
--region eu-central-1 - As we are working on AWS so we need to specify the --region flag along with correct region-name
--nodegroup-name worker-nodes- The --nodegroup-name is used for assigning the name for the worker node 6.--node-type t2.large - --node-type flag is used for specifying which ec2 instance we are going to use for setting up the Kubernetes cluster
--nodes 2 - The --nodes flag is used for defining how many numbers of nodes we need inside the Kubernetes cluster
--nodes-min 2 - The --nodes-min flag is used to tell the minimum number for nodes we need inside the Kubernetes cluster
--nodes-max 3 - The --nodes-min flag is used to tell the maximum number of nodes we need inside the kubernetes cluster

-> After login to AWS management console, in the search bar type EKS - you will find an option Cluster click on it
-> And you should be able to view the Kubernetes cluster which you have created using the eksctl command.

"Note run following command to update your kubeconfig aws eks update-kubeconfig --name test-cluster-1 

https://stackoverflow.com/questions/72126048/error-exec-plugin-invalid-apiversion-client-authentication-k8s-io-v1alpha1-c"


6. Install Kubernetes Metrics Server
-------------------------------------
-> Kubernetes Metrics server collects the resource metrics from "kubelets" and exposes it to the Kubernetes "api server" through Metrics API for use by Horizontal Pod Autoscaler and Vertical Pod Autoscaler.

The Kubernetes metrics offers -
a. Fast autoscaling, collecting metrics
b. Scalable support up to 5,000 node clusters.
c. Resource efficiency and it requires very less cpu(1 mili core) and less memory(2 mb)

Installation of Kubernetes metrics server:
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

Note - In case you face the issue error: exec plugin: invalid apiVersion "client.authentication.k8s.io/v1alpha1" while running the kubectl apply -f command then follow these troubleshooting steps

-> Verify the Kubernetes metric server installation- You can verify the Kubernetes metric server installation kubectl get deployment metrics-server -n kube-system or kubectl get pods -n kube-system



7. Install Prometheus
----------------------

7.1 Add Prometheus helm chart repository
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts 

7.2 Update the helm chart repository
helm repo update 

7.3 Create prometheus namespace
kubectl create namespace prometheus

7.4 Install the grafana
helm install prometheus prometheus-community/prometheus \
    --namespace prometheus \
    --set alertmanager.persistentVolume.storageClass="gp2" \
    --set server.persistentVolume.storageClass="gp2" 

7.5 View the Prometheus dashboard by forwarding the deployment ports
kubectl port-forward deployment/prometheus-server 9090:9090 -n prometheus


8. Install grafana
-------------------
-> After installing Prometheus let's install the Grafana using the Helm Chart.

8.1 Add the Grafana helm chart repository
helm repo add grafana https://grafana.github.io/helm-charts 

8.2 Update the helm chart repository
helm repo update 

8.3 Now we need to create a Prometheus data source so that Grafana can access the Kubernetes metrics. Create a yaml file prometheus-datasource.yaml and save the following data source configuration into it

datasources:
  datasources.yaml:
    apiVersion: 1
    datasources:
    - name: Prometheus
      type: prometheus
      url: http://prometheus-server.prometheus.svc.cluster.local
      access: proxy
      isDefault: true

8.4 Create a namespace grafana
kubectl create namespace grafana

8.5 Install the Grafana
helm install grafana grafana/grafana \
    --namespace grafana \
    --set persistence.storageClassName="gp2" \
    --set persistence.enabled=true \
    --set adminPassword='EKS!sAWSome' \
    --values prometheus-datasource.yaml \
    --set service.type=LoadBalancer 

8.6 Verify the Grafana installation by using the following kubectl command -
kubectl get all -n grafana

8.7 Public AWS IP of Grafana Kubernetes Server- To Access the Grafana dashboard we need to find Public AWS IP address and for that use the following command -
kubectl get service -n grafana 

8.8 Copy the Public AWS IP address and open it in the browser -


9. Import Grafana dashboard from Grafana Labs
-----------------------------------------------
9.1 On left navigation click on + sign
9.2 Then goto import and enter the grafana dashboard number 6417
9.3 Select the data source and save it.
9.4 Now you can see your Grafana dashboard displaying all the Kubernetes metrics.

