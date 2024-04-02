# webapp
This is a simple web application hosted on an Azure AKS cluster using an IaC and CI/CD practices

#IaC
Terraform is used as IaC to create the AKS cluster, ACR and a Storage account to store the terraform state file.
Sample Terraform code files are available in terraformfiles folder.


#CI
GitHub actions workflows are used for CI, to build the docker image and push to ACR registry. 
The workflow file is available in .github/workflows location.
![image](https://github.com/balajiflieshigh/webapp/assets/83899529/d43c009e-6736-46f4-8b28-e3b5591595f8)


#CD
Flux v2 is used to monitor the K8s manifest files in the GitHub and deploy the resources in the AKS cluster. 
 ![image](https://github.com/balajiflieshigh/webapp/assets/83899529/2ea4b994-b27d-4795-9c3b-b9da557cc9ce)


HPA is enabled for the deployment.
![image](https://github.com/balajiflieshigh/webapp/assets/83899529/76a9ba8a-dffc-4b44-9f43-9f50c47e0ba7)















