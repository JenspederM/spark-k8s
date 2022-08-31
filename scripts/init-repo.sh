#/usr/bin/bash

# Initialize a new repository
#
# This script will create a new repository and initialize it with the
# following files:
#
#   - .gitignore
#   - README.md
#   - spark-operator/

. scripts/utils.sh
logger info "Initializing a new git repository"
exit 1

git init

logger info  "Creating .gitignore"
cat <<EOF > .gitignore
.vscode/
.DS_Store
*.env
*.log
EOF

logger info "Creating README.md"
cat <<EOF >README.md
# Spark Operator on Kubernetes

This is a Helm chart for installing and managing Spark on Kubernetes.

## Prerequisites

- [helm](https://helm.sh/)
- [git](https://git-scm.com/)
- [kubernetes](https://kubernetes.io/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [skaffold](https://skaffold.dev/)

## Run example
\`\`\`
skaffold dev
\`\`\`
EOF

logger info "Add spark operator repo to helm"
helm repo add spark-operator https://googlecloudplatform.github.io/spark-on-k8s-operator
logger info "Update helm repos"
helm repo update
logger info "Pull helm chart"
helm pull spark-operator/spark-operator
logger info "Unpack and remove tar"
unpack_and_remove_tar_files "spark-operator*"


logger info "Initializing Skaffold"
skaffold init


