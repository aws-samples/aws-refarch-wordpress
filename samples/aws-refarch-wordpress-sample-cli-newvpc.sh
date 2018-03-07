aws cloudformation create-stack \
 --stack-name WordPress \
 --template-body https://s3.amazonaws.com/aws-refarch/wordpress/latest/templates/aws-refarch-wordpress-master-newvpc.yaml \
 --parameters file://aws-refarch-wordpress-parameters-newvpc.json \
 --capabilities CAPABILITY_IAM \
 --disable-rollback \
 --region us-east-1 \
 --output json