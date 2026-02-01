# AWS Serverless Portfolio (Terraform)

This is a basic AWS serverless project created to understand how few AWS services work together using Infrastructure as Code (Terraform).

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



