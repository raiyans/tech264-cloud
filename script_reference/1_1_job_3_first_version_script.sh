# Define variables
EC2_USER=ubuntu
EC2_IP=34.241.57.116
REMOTE_PATH=/home/ubuntu/app3

# Add the EC2 instance to known hosts (this prevents SSH prompt when connecting for the first time)
ssh-keyscan -H $EC2_IP >> ~/.ssh/known_hosts
echo $AWS_SSH_KEY

ssh -i  $AWS_SSH_KEY $EC2_USER@$EC2_IP "rm -rf $REMOTE_PATH && pm2 kill"
# Use scp to copy code from Jenkins workspace to EC2
scp -o StrictHostKeyChecking=no -i $AWS_SSH_KEY -r $(pwd) $EC2_USER@$EC2_IP:$REMOTE_PATH

ssh -i  $AWS_SSH_KEY $EC2_USER@$EC2_IP "cd $REMOTE_PATH/app && npm install && pm2 start app.js"
