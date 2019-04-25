# kubeless samples

## golang sample for kubeless

write some code:

    curl -o paramsasstring.go https://raw.githubusercontent.com/embix/playwith/master/kubernetes/kubeless/paramsasstring.go

deploy:

    kubeless function deploy paramsasstring --runtime go1.10 --from-file paramsasstring.go --handler samples.paramsasstring

check:

    kubeless function ls paramsasstring

if we need to debug, check [docu](https://kubeless.io/docs/debug-functions/)

   kubectl get pods -l function=paramsasstring