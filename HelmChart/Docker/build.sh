#!/usr/bin/env bash
{
    docker build -t simplewebapp . ;
    docker tag simplewebapp:latest 723949785394.dkr.ecr.eu-west-2.amazonaws.com/simplewebapp:latest
    docker push 723949785394.dkr.ecr.eu-west-2.amazonaws.com/simplewebapp:latest
    echo "Success: PHP image was built." ;
} || {
    echo "Error: PHP image was not built."
}