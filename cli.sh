#!/bin/sh
aws ec2 run-instances --image-id ami-032509850cf9ee54e --count 1 --instance-type t2.micro --key-name Ec2KeyPair --security-group-ids sg-059a0455a434a0929 --subnet-id subnet-01383d6fcf8472c81 --tag-specifications 'ResourceType=instance,Tags=[{Key=Type,Value=Backend},{Key=Name,Value=Backend}]'
