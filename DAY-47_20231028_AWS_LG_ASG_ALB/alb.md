Creating an AWS Application Load Balancer (ALB) along with a listener, target group, and target instances involves several steps in the AWS Management Console. Here is a step-by-step guide to setting up your ALB:

Step 1: Create an Application Load Balancer
Sign in to the AWS Management Console and open the Amazon EC2 console.
In the navigation pane, under Load Balancing, choose Load Balancers.
Choose Create Load Balancer.
Select Application Load Balancer and choose Create.
Name your ALB and set the scheme according to your requirements.
Select at least two Availability Zones and their corresponding subnets.
Choose Next: Configure Security Settings (if HTTPS, configure your SSL certificate here).
Choose Next: Configure Security Groups and select/create a security group as needed.
Choose Next: Configure Routing.
Step 2: Create a Target Group
For Target group, choose to create a new target group.
Provide a name for the target group.
Choose the protocol and port for your targets.
Set Health checks settings that the ALB will use to check the health of targets.
Choose Next: Register Targets.
Step 3: Register Targets
Choose Register Targets and select the instances to be part of the ALB.
For each instance, specify the port that will receive traffic from the load balancer.
After selecting the instances, choose Include as pending below.
Choose Next: Review, check all the configurations.
Choose Create to create the target group.
Step 4: Create a Listener
After creating the target group, you will be prompted to create a listener.
For Default action, choose your newly created target group.
Set the protocol and port for the listener, usually HTTP/80 or HTTPS/443.
(Optional) If using HTTPS, upload a certificate or choose one from ACM (AWS Certificate Manager).
Choose Create listener.
Step 5: Review and Create
Review all configurations to make sure they match your requirements.
If everything looks good, choose Create to create your Application Load Balancer.
Step 6: Verify and Test
After creation, select the Load Balancer and check the Description tab to see details like DNS name.
Use the DNS name provided by the ALB to test that it's routing traffic correctly to your target instances.
Check the Target Group and ensure that the instances are passing the health checks.
Final Note
Remember that changes to security groups, network ACLs, and route tables may be necessary depending on your VPC setup and whether your ALB is internet-facing or internal. Ensure that your EC2 instances have the proper IAM roles and security group rules to communicate with the ALB.

These notes give you a high-level overview of creating an ALB with all the necessary components. The AWS documentation provides detailed guidance and should be referred to for specific configurations and up-to-date instructions.