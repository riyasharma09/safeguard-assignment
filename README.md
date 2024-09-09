# safeguard-assignment

Problem Statement: 
Your organization uses multiple AWS accounts for enhanced security and resource 
management. You are tasked with setting up secure and compliant access for Account B to 
sensitive data stored in an S3 bucket in Account A. The data transfer must occur without 
using the public internet and should comply with stringent security policies, including 
logging, encryption, and fine-grained access control. The entire setup must be automated 
using IAC like Terraform, AWS CloudFormation etc. 

Requirements: 
1. Secure Data Transfer: 
o Private Network Configuration: Ensure data transfer between Account A 
and Account B occurs over private network connections without exposing the 
data to the public internet. 
2. Advanced Access Control: 
o Dynamic IAM Role Management: Automate the creation of IAM roles with 
session-based temporary credentials. Ensure roles in Account B have only the 
minimum required permissions to access specific objects in the S3 bucket of 
Account A. 
o Fine-Grained S3 Bucket Policies: Implement S3 bucket policies that enforce 
access restrictions based on conditions such as source VPC, IP address, or 
AWS Organizations ID. 
3. Enhanced Data Security: 
o End-to-End Encryption: Encrypt data at rest using AWS KMS in Account 
A, and ensure data in transit between the two accounts is encrypted using 
SSL/TLS. Implement client-side encryption for added security, where data is 
encrypted before being uploaded to S3. 
o KMS Key Policies: Configure KMS key policies that allow cross-account 
access but restrict key usage to specific services and actions, ensuring that 
even with access, only authorized services can decrypt the data. 
4. Comprehensive Logging and Monitoring: 
o Cross-Account CloudWatch Alarms: Set up CloudWatch Alarms that 
monitor and trigger alerts for unusual activities, such as unauthorized access 
attempts or unexpected data transfers, across both accounts. 
o Centralized Logging: Implement centralized logging in a dedicated logging 
account, where all access logs (from CloudTrail, VPC Flow Logs, and S3 
Access Logs) are aggregated and stored securely. Ensure that logs are 
encrypted and access to them is tightly controlled. 
5. Data Integrity and Compliance: 
o Data Integrity Checks: Implement automated integrity checks on the data 
before and after transfer to ensure it has not been tampered with during transit. 
o Compliance Auditing: Use AWS Config to enforce and audit compliance 
with your organization’s security standards across both accounts, ensuring that 
all resources are correctly configured and in line with best practices.

Deliverables: 
1. IaC Templates: Terraform or CloudFormation scripts for the setup. 
2. Architecture Diagram: Visual representation of the secure network and data flow. 
