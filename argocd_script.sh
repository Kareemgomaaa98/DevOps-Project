#!/bin/bash

# Install ArgoCD and configure the project
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
# sleep 300
kubectl apply -f application.yaml