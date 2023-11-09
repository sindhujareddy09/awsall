Creating an Amazon CloudFront distribution to serve content securely over HTTPS using AWS Certificate Manager (ACM) and Amazon S3 involves a few steps. Below is a step-by-step guide:

Step 1: Request a Certificate in AWS Certificate Manager
Sign in to the AWS Management Console and open the ACM console.
Click on Request a certificate.
Choose Request a public certificate and click Next.
Enter your domain name and any subdomains if needed.
Choose the validation method (DNS or email validation) for your domain.
Review your request and click Confirm and request.
Follow the instructions to validate the domain ownership which will depend on the validation method chosen.