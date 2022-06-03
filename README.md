Overview

This module is going to give a walkthrough on how to Invoke AWS Lambda from AWS Step Functions with the help of terraform. In this project, I will create a file in s3 bucket. So I will create 2 lambda logic functions where one of the functions would be to check whether a file exist in the s3 bucket and ouput sucess while the second function would be to send a notification that the file doesn't exist when a file is not found in the s3 bucket. I will be using terraform which is an Infrastructure as a Code. Terraform is an open-source infrastructure as code software tool. It allows building, changing, and versioning the infrastructure. Terraform uses a declarative approach to define the infrastructure.

Also, AWS Lambda which is a Function-as-a-Service platform by Amazon Web Services will be utilized since it can run codes without provisioning the servers. In the same vein, AWS Step Functions would be used to test the outcome of the file in the s3 bucket and would send an email notification if the code catches an error where the file in the s3 bucket doesnt exist.


Diagram
![Basic StepFunction (1)](https://user-images.githubusercontent.com/34858886/171946733-11ac070d-f49d-4a44-af41-9f03780e6843.png)

Deploy
Since we have defined the infrastructure for an AWS Lambda and AWS Step Functions in terraform, it is time to deploy and test them. Finally the directory structure will be as below.

<img width="297" alt="Screenshot 2022-06-03 at 21 27 27" src="https://user-images.githubusercontent.com/34858886/171936331-d8dc5688-4b66-4fa3-a6ea-791220da902e.png">



Steps 

* Clone the project
```
git clone https://github.com/UbongMichael/Lambda-Project.git
```

* Change to the project folder
```
cd terraform
```
* Run the following command to initialize and deploy the infrastructure.

```
terraform init  # To initialize
```  
```
terraform plan  # View the execution plan of terraform
```  
```
terraform apply  # Apply the infrastructure in AWS
``` 
```
terraform destroy  # Destroy the infrastructure in AWS
``` 
