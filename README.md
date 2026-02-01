# AWS Serverless Portfolio (Terraform)

A hands-on AWS project demonstrating EC2, S3, IAM, Terraform, and other core AWS services. This README documents steps, challenges faced, and solutions, along with screenshots for clarity.

## Architecture
- Static portfolio hosted on Amazon S3
- Distributed globally using Amazon CloudFront
- Visitor tracking using API Gateway + AWS Lambda
- View count stored in DynamoDB
- IAM roles for secure service access

## Services Used
- Amazon S3
- Amazon CloudFront
- AWS Lambda (Python)
- Amazon API Gateway
- Amazon DynamoDB
- AWS IAM
- Terraform

## Key Learnings
- CloudFront caching and invalidation
- CORS configuration with API Gateway and Lambda proxy integration
- IAM permissions for Lambda and DynamoDB
- Terraform state and resource dependencies
- Debugging real-world deployment issues

Project Steps
Step 1: Upload Static Files to S3

Description:
Uploaded HTML, CSS, and JS files to an S3 bucket configured for static website hosting.
S3 bucket public access blocked by default (access only to cloudfront).


Step 2: Configure CloudFront Distribution

Description:
Created a CloudFront distribution pointing to the S3 bucket for faster content delivery globally.

![CloudFront](/images/cloudfront.png)
![Portfolio](/images/portfolio.png)

Challenge:
CloudFront caching caused delayed updates of website changes.
  -Invalidated cache in CloudFront after each website update.
  -Used versioning in file name as invalidation didnt work for changes in my js file


Step 3: Setup DynamoDB Table

Description:
Created a DynamoDB table to store page view counts.

Table Name: portfolio-table
Primary Key: page_id (String)
Attribute: view_count (Number)

![DynamoDB](/images/dynamotableoverview.png)
![DynamoDBtable](/images/dynamotable.png)


Step 4: Create Lambda Function

Description:
Lambda function updates DynamoDB view_count whenever a page is visited.

![LambdaCode](/images/lambdaCode.png)
![Lambda Function](/images/lambdaOverview.png)

Challenge:
Ensuring to provide dynamodb access to lambda

![IAM role](/images/IAMrole.png)


Step 5: Configure API Gateway

Description:
Created an API Gateway endpoint to trigger the Lambda function on page visits.

![API gw](/images/apigwrest.png)
![API gw](/images/apigw.png)

Challenge:
API gw manually tested working fine but lambda not invoked in js when opening portfolio in browser
  -Enabled Lambda proxy integration and deployed API.
  -CORS setup check for headers

Step 6: Connect Lambda to API Gateway

Description:
Configured the website JS code to call the API Gateway endpoint on page load.

![API in JS](/images/callAPI.png)


Challenge:
CORS error in browser.
  -Enabled CORS in API Gateway settings.


Step 7: Test View Tracking

Description:
Accessed the website, and DynamoDB updated in real-time with page view counts.
