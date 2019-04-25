# kubeless samples

TL;DR: kubeless on play-with-k8s is no fun b/c nodes have disk pressure :-(

## golang sample for kubeless

write some code:

    curl -o paramsasstring.go https://raw.githubusercontent.com/embix/playwith/master/kubernetes/kubeless/paramsasstring.go

deploy:

    kubeless function deploy paramsasstring --runtime go1.10 --from-file paramsasstring.go --handler samples.paramsasstring

check:

    kubeless function ls paramsasstring

if we need to debug, check [docu](https://kubeless.io/docs/debug-functions/)

   kubectl get pods -l function=paramsasstring

if you `describe pod` you may see something like this:

```
    Name:      paramsasstring
    Optional:  false
  default-token-fnp64:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-fnp64
    Optional:    false
QoS Class:       BestEffort
Node-Selectors:  <none>
Tolerations:     node.kubernetes.io/not-ready:NoExecute for 300s
                 node.kubernetes.io/unreachable:NoExecute for 300s
Events:
  Type     Reason            Age   From               Message
  ----     ------            ----  ----               -------
  Warning  FailedScheduling  2m    default-scheduler  0/3 nodes are available: 1 node(s) had taints that the pod didn't tolerate, 2 node(s) had disk pressure.
  Normal   Scheduled         1m    default-scheduler  Successfully assigned default/paramsasstring-665798d9db-xnwls to node3
  Normal   Pulled            1m    kubelet, node3     Container image "kubeless/unzip@sha256:f162c062973cca05459834de6ed14c039d45df8cdb76097f50b028a1621b3697" already present on machine
  Normal   Created           1m    kubelet, node3     Created container
  Normal   Started           1m    kubelet, node3     Started container
  Normal   Pulling           1m    kubelet, node3     pulling image "kubeless/go-init@sha256:88104a60bcd4c67fd6aa92fffa46062396c08bc2632529ee435517e7628a2f95"
  Warning  Evicted           13s   kubelet, node3     The node was low on resource: ephemeral-storage.
  Warning  Failed            5s    kubelet, node3     Failed to pull image "kubeless/go-init@sha256:88104a60bcd4c67fd6aa92fffa46062396c08bc2632529ee435517e7628a2f95": rpc error: code = Unknown desc = failed to register layer: open /var/lib/docker/vfs/dir/6fbad8dac97beb9a6e3c3131bcaf7c93dc55a2ac212c2bc4192e9e7e1c56aa37/var/log/btmp: disk quota exceeded
  Warning  Failed            5s    kubelet, node3     Error: ErrImagePull
```