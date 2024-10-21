# Define variables
EC2_USER=ubuntu
EC2_IP=34.241.57.116
REMOTE_PATH=/home/ubuntu/app3

# Add the EC2 instance to known hosts (this prevents SSH prompt when connecting for the first time)
ssh-keyscan -H $EC2_IP >> ~/.ssh/known_hosts

# Copy files from Jenkins workspace to the remote EC2 instance using rsync
rsync -avz -e "ssh -o StrictHostKeyChecking=no" $(pwd)/ $EC2_USER@$EC2_IP:$REMOTE_PATH

# SSH into EC2 instance and execute deployment commands
ssh $EC2_USER@$EC2_IP << EOF
    pm2 kill
    # Navigate to the app directory
    cd $REMOTE_PATH/app
    # Run npm install and start the app with pm2
    npm install
    pm2 start app.js
EOF