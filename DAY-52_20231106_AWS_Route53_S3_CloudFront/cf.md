Step 3: Create a CloudFront Distribution
Open the CloudFront console.
Click Create Distribution.
Choose Web as the delivery method for your content.
For the Origin Domain Name, select the S3 bucket you created earlier.
If you want to restrict access to the S3 bucket so that users can only access content through CloudFront, consider configuring Origin Access Identity (OAI).
Set the Viewer Protocol Policy to Redirect HTTP to HTTPS to enforce secure connections.
Under Distribution Settings, choose the certificate you created in ACM from the SSL Certificate dropdown.
Set up the Cache Behavior and Distribution Settings as needed (e.g., CNAMEs, logging, price class).
Click Create Distribution.


Step 4: Configure the S3 Bucket Policy (Optional but recommended)
Go to your S3 bucket permissions.
Click on Bucket Policy.
Use the policy generator or manually write a policy to grant CloudFront permission to access your S3 bucket.
Example of a policy to allow CloudFront access:

```

{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity YOUR_OAI_ID"
      },
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::YOUR_BUCKET_NAME/*"
    }
  ]
}

```

Replace YOUR_OAI_ID with your actual Origin Access Identity and YOUR_BUCKET_NAME with your bucket's name.
Click Save.
Step 5: Test Your CloudFront Distribution
After the distribution is created, it will take some time for the status to change from In Progress to Deployed.
Once deployed, you'll receive a CloudFront domain name (e.g., d1234abcdghkl.cloudfront.net).
Access the CloudFront domain name in your browser to verify that your S3 content is being delivered securely over HTTPS.
Final Notes:
Ensure your S3 bucket has the necessary permissions to interact with CloudFront.
It can take some time for the certificate to be issued and the distribution to be deployed.
Be aware of the costs associated with ACM (if you request certificates that you don't use) and CloudFront, especially if you use custom SSL certificates or if your content is accessed frequently.
For security, you should always follow the principle of least privilege when setting permissions. Only grant permissions that are necessary for the services to interact with each other.