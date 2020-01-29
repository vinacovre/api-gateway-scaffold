# !/bin/bash
#
# kubectl sales-crm-gateway deployment
#
# We need to provide these parameters to our deploy:
# - ENVIRONMENT: The environment that will be deployed. Valid values: qa and prod
# - VERSION: The version that we want to deploy (release tag)
# - K8S_TOKEN: The token to authenticate on the kubernetes
# - K8S_CLUSTER: The kubernetes cluster to connect
#
# Usage:
#   ./.deploy/bin/deploy [ENVIRONMENT] [VERSION] [K8S_TOKEN] [K8S_CLUSTER]
#

### VARIABLES ###

environment=${1:-$ENVIRONMENT}
version=${2:-$VERSION}
token=${3:-$K8S_TOKEN}
cluster=${4:-$K8S_CLUSTER}

app="sales-crm-gateway"
deploy_file="./.deploy/k8s/resources.yml"
namespace="vcovre"

default_limit_cpu="0.9"
default_limit_memory="256Mi"
default_requests_cpu="0.1"
default_requests_memory="128Mi"

### FUNCTIONS ###

prepare() {
  local deploy_file=${deploy_file}
  local environment=${environment}
  local limit_cpu=${default_limit_cpu}
  local limit_memory=${default_limit_memory}
  local requests_cpu=${default_requests_cpu}
  local requests_memory=${default_requests_memory}

  echo "Preparing deploy for app '${app}'"

  deploy_config_file="./.deploy/${environment}-deployment-${app}-${version}.yml"
  limit_memory="512Mi"

  ENVIRONMENT=$environment \
  VERSION=$version \
  APP=$app \
  APP_REQUESTS_CPU=${requests_cpu} \
  APP_REQUESTS_MEMORY=${requests_memory} \
  APP_LIMIT_CPU=${limit_cpu} \
  APP_LIMIT_MEMORY=${limit_memory} \
  envsubst < $deploy_file > $deploy_config_file
}

deploy() {
  local deploy_config_file=${1}
  local app=${2}
  local token=${3}
  local cluster=${4}

  echo "Starting deploy of app '${app}'"

  ## Apply the new deployment to the k8s
  kubectl -n ${namespace} \
    apply --record -f ${deploy_config_file} \
    --server=${cluster} \
    --token=${token} \
    --insecure-skip-tls-verify \
    --record || exit 1
}

rollout() {
  local deploy_config_file=${1}
  local app=${2}
  local token=${3}
  local cluster=${4}

  echo "Starting the rollout app '${app}'"

  ## Check if the deploy was successful or not
  kubectl -n ${namespace} \
    rollout status deployments "${app}" \
    -s ${cluster} \
    --token=${token} \
    --insecure-skip-tls-verify || {

  ## If deploy failed, undo it
  kubectl -n ${namespace} \
    rollout undo deployments "${app}" \
    -s ${cluster} \
    --token=${token} \
    -f ${deploy_config_file} \
    --insecure-skip-tls-verify; exit 1; }
}

main() {
  if [[ "$environment" && "$version" && "$token" && "$cluster" ]]; then
    prepare
    deploy ${deploy_config_file} ${app} ${token} ${cluster}
    rollout ${deploy_config_file} ${app} ${token} ${cluster}
  else
    echo "Missing values! You must define: ENVIRONMENT, VERSION, K8S_TOKEN, and K8S_CLUSTER!"
    exit 1
  fi
}

### SCRIPT RUN ###

main
