#!/usr/bin/env bash
{
    echo "Please enter the ECR arn you wish to push to";
    read ecr;
    docker build -t simplewebapp . ;
    docker tag simplewebapp:latest $ecr:latest
    docker push $ecr:latest
    echo "Success: PHP image was built and pushed." ;
} || {
    echo "Error: PHP image was not built."
}