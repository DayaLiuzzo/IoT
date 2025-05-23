1 Project setup
    a) Install Docker
    b) Install other dependencies
    c) Install k3d

    understand differences between k3s && k3d

2 Orientation
    testing out with the k3d ressources;

3 Development Phase  
    (GOAL: Argo CD automatically pulls and deploys an application from your GitHub repo into a Kubernetes cluster.)
    a) create the argocd namespace
        Install Argo CD
        might act as a controller ?
    b) PrepareGithub repo
        add manifests with correct namespace
    c) create the dev namespace
        create an application that will be automatically deployed by argoCS using online github repository
    d) Define ArgoCD app
        yaml file that links to github and deploys to dev namespace
    e) Deploy argoCD app 
        deploy the app in the cluster from the argocd namespace 
            kubectl apply -f app.yaml

