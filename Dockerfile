# start from pulumi nodejs (has nodejs + pulumi binary)
FROM pulumi/pulumi-nodejs:2.9.0

# Metadata
LABEL org.label-schema.name="pulumi-docker-kubectl-helm-aws-nodejs" \
      org.label-schema.url="https://cloud.docker.com/r/themasterr/pulumi-docker-kubectl-helm-aws-nodejs/" \
      org.label-schema.vcs-url="https://github.com/themasterr/pulumi-docker-kubectl-helm-aws-nodejs"

# Note: Latest version of kubectl may be found at:
# https://github.com/kubernetes/kubernetes/releases
ENV KUBE_LATEST_VERSION="v1.18.8"

# Note: Latest version of helm may be found at:
# https://github.com/kubernetes/helm/releases
ENV HELM_VERSION="v3.3.0"

# install dependencies {awscli, curl, wget, docker, kubectl, helm, awscli}
RUN apt update && apt install curl wget unzip python git -y \
    && wget -q https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -O /bin/kubectl \
    && chmod +x /bin/kubectl \
    && wget -q https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /bin/helm \
    && chmod +x /bin/helm \
    && curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip" \
    && unzip awscli-bundle.zip \
    && ./awscli-bundle/install -b /bin/aws \
    && rm -rf ./awscli-bundle awscli-bundle.zip \
    && curl https://get.docker.com | bash \
    && rm -rf /var/lib/apt/lists/* \
    && apt clean

# REQUIRED ENV
ENV PULUMI_ACCESS_TOKEN=
ENV AWS_ACCESS_KEY_ID=
ENV AWS_SECRET_ACCESS_KEY=

# next install required modules { npm packages } - eg:
# COPY infrastructure/k8s/package*.json infrastructure/k8s/
# RUN cd infrastructure/k8s && npm ci && cd ../../

# COPY infrastructure/aws/package*.json infrastructure/aws/
# RUN cd infrastructure/aws && npm ci && cd ../../

# EXAMPLE usage

# docker run --rm \ 
#  -e PULUMI_ACCESS_TOKEN=${PULUMI_ACCESS_TOKEN} \
#  -e AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} \
#  -e AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} \
#  -v "$(pwd)":/pulumi/projects \
#  themasterr/pulumi-docker-kubectl-helm-aws-nodejs /bin/bash -c "pulumi preview -s dev"
