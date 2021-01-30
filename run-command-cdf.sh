#!/bin/sh

if [[ ! -z $1 && ! -z $2 ]];
then
    echo "Trying to create the stack"
    aws cloudformation create-stack --stack-name $1 --region us-west-2 --parameters file://$2 --template-body file://$3 --capabilitie CAPABILITY_IAM CAPABILITY_NAMED_IAM 
    if [[ $? != 0 ]]
    then
        echo "Stack already exists so trying to update it"
        aws cloudformation update-stack --stack-name $1 --region us-west-2 --parameters file://$2 --template-body file://$3 --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM
        if [[ $? == 0 ]]
        then
            echo "Updated the stack"
        fi
    else
            echo "Created the stack"
    fi
else
    echo "Please pass the parameters!"
fi
