# Kubernates 1.24.3 常用命令

	kubectl get pods -n kube-system -o wide
	kubectl get pods -n kube-flannel  -o wide
	kubectl get nodes  -o wide
	
	kubectl get pod -n kubernetes-dashboard -o wide
	kubectl get svc  -n kubernetes-dashboard -o wide

	kubectl describe nodes k8s-node-01
	kubectl describe po kube-proxy-9x6fr -n kube-system
	
	kubectl get secret login-harbor --output=yaml
	
	kubectl get deployment -n kube-system -o wide
	kubectl delete deployment node-test-deployment -n kube-system

	kubectl scale --replicas=5 deployment/node-test-deployment -n kube-system

	kubectl expose --help

	kubectl expose deployment node-test-deployment --port=8081 --target-port=8080 -n kube-system

	kubectl get svc -n kube-system
	kubectl delete svc node-test-deployment -n kube-system

	kubectl edit svc node-test-deployment -n kube-system
	
	

# 查看node节点加入的 sha
	kubeadm token create --print-join-command
	
# 重置 kubeadm
	kubeadm reset

# 私有仓部署
	kubectl create deployment node-test-deployment --image=hub.gigimed.cn:30002/k8s/k8sapp:v1 --port=80 --replicas=1 --namespace=kube-system


# 登入私有仓库
	kubectl create secret docker-registry login-harbor --docker-server=hub.gigimed.cn:30002 --docker-username=ison --docker-password=Ison1234 --namespace=kube-system --dry-run=client -o yaml > login-harbor.yaml
	# kubectl apply -f login-harbor.yaml
	kubectl create secret generic login-harbor --from-file=.dockerconfigjson=/root/.docker/config.json --type=kubernetes.io/dockerconfigjson --namespace=kube-system
	kubectl get secret login-harbor --output=yaml


![k8s-system](images/k8s-system.jpeg)
![k8s-docker](images/k8s-docker.jpg)
