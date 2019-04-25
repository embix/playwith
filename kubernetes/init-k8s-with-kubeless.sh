# almost any shell

# set up k8s
kubeadm init --apiserver-advertise-address $(hostname -i)
kubectl apply -n kube-system -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 |tr -d '\n')"

# set up kubeless
export RELEASE=$(curl -s https://api.github.com/repos/kubeless/kubeless/releases/latest | grep tag_name | cut -d '"' -f 4)
kubectl create ns kubeless
kubectl create -f https://github.com/kubeless/kubeless/releases/download/$RELEASE/kubeless-$RELEASE.yaml

# check everything is as it should be
kubectl get pods -n kubeless
kubectl get deployment -n kubeless
kubectl get customresourcedefinition

# install kubeless cli so we can play righ away
export OS=$(uname -s| tr '[:upper:]' '[:lower:]')
curl -OL https://github.com/kubeless/kubeless/releases/download/$RELEASE/kubeless_$OS-amd64.zip
# basically `unzip kubeless_$OS-amd64.zip` but play with k8s has neither unzip nor apk
# so we have to improvise...
docker run -t --rm -v $PWD:/halp alpine:latest /bin/sh -c "apk update && apk add unzip && cd /halp && unzip kubeless_$OS-amd64.zip"
mv bundles/kubeless_$OS-amd64/kubeless /usr/local/bin/

# final check
kubeless --help
# list supported language runtimes
kubeless get-server-config

# kubeless does not run on masters out of the box :-/
echo "remember to fire up some workers:"
kubeadm token create --print-join-command
