#!/bin/sh
cd /home/ec2-user/SageMaker
aws s3 cp s3://sagemaker-robotic-cm-bot/RoboticCM.ipynb .
sudo -u ec2-user -i <<'EOF'
source activate python3
pip install runipy
nohup runipy /home/ec2-user/SageMaker/RoboticCM.ipynb &
source deactivate
EOF
