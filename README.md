# playwith
some scripts to remember when playing with [k8s](https://labs.play-with-k8s.com/) or [docker](https://labs.play-with-docker.com/)

**Warning** Scripts use highly insecure constructs like `curl | sh` to keep them focussed on the topic - don't ever use them outside of a playground!

i.e. to set up kubeless in labs.play-with-k8s:

    curl https://raw.githubusercontent.com/embix/playwith/master/kubernetes/init-master-with-network.sh | bash
