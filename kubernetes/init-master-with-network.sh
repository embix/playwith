# any shell
kubeadm init --apiserver-advertise-address $(hostname -i)
kubectl apply -n kube-system -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 |tr -d '\n')"
