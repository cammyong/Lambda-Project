Overview

This module is going to give a walkthrough on how to Invoke AWS Lambda from AWS Step Functions with the help of terraform. In this project, I will create a file in s3 bucket. So I will create 2 lambda logic functions where one of the functions would be to check whether a file exist in the s3 bucket and ouput sucess while the second function would be to send a notification that the file doesn't exist when a file is not found in the s3 bucket. I will be using terraform which is an Infrastructure as a Code. Terraform is an open-source infrastructure as code software tool. It allows building, changing, and versioning the infrastructure. Terraform uses a declarative approach to define the infrastructure.

Also, AWS Lambda which is a Function-as-a-Service platform by Amazon Web Services will be utilized since it can run codes without provisioning the servers. In the same vein, AWS Step Functions would be used to test the outcome of the file in the s3 bucket and would send an email notification if the code catches an error where the file in the s3 bucket doesnt exist.


Diagram
![Basic StepFunction](https://user-images.githubusercontent.com/34858886/171869449-2a35a652-b58b-4fea-9c57-6f06040aed34.png)

Deploy
Since we have defined the infrastructure for an AWS Lambda and an AWS Step Functions in terraform, it is time to deploy and test them. Finally the directory structure will be as below.
.
├── lambda.tf
├── lambda_zip
│   ├── check_file_lambda.zip
│   └── report_error_lambda.zip
├── main.tf
├── myfile
│   ├── file.txt
│   ├── file2.txt
│   └── file3.txt
├── output.tf
├── s3.tf
├── sns.tf
├── step_function.tf
├── terraform.tfstate
├── terraform.tfstate.backup
└── vars.tf

Steps
Clone this repo using command

Go to project folder
cd terraform


`terraform init`   # it will perform initialization step
`terraform plan`   # see the execution plan of terraform
`terraform apply`   # apply the infrastructure in AWS
`terraform destroy` # destroy the infrastructure in AWS
