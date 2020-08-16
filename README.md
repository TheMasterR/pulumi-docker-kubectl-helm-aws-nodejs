# pulumi-docker-kubectl-helm-aws-nodejs

A docker image bundled with
> pulumi
> docker
> kubectl
> helm
> awscli
> nodejs

You can use it to deploy pulumi stacks.

One example of using this would be:

```
docker run --rm \ 
 -e PULUMI_ACCESS_TOKEN=${PULUMI_ACCESS_TOKEN} \
 -e AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} \
 -e AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} \
 -v "$(pwd)":/pulumi/projects \
 themasterr/pulumi-docker-kubectl-helm-aws-nodejs /bin/bash -c "npm ci && pulumi preview -s dev"
```

the required env variables are:
> PULUMI_ACCESS_TOKEN - get it from app.pulumi.com
> AWS_ACCESS_KEY_ID &
> AWS_SECRET_ACCESS_KEY - that you can get from aws (with apropriate permissions for the pulumi stack)

I would recomand doing a from the image, and running npm ci to create a cache of the files, so that you can run without installing the typescript / nodejs dependencies all the time. (see Dockerfile for example).
