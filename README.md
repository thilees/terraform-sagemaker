##The execution steps:

#Step 1: Make sure you have the right permission to the instance where you are going to execute this terraform scripts to connect to your AWS account and create the resources

#Step 2: Set up terraform binary
	wget https://releases.hashicorp.com/terraform/0.12.26/terraform_0.12.26_linux_amd64.zip0
        unzip terraform_0.12.26_linux_amd64.zip 
        sudo mv terraform /usr/local/bin/

#Step 3: Install git and clone the repo
	sudo yum install git -y
	git clone git@github.com:thilees/terraform-sagemaker.git 

#Step 4: Navigate to the cloned repo directory and run the followings
	terraform init
        terraform apply

#Step 5: Get the api endpoint at the end of terraform execution and make a post request with the following formate
	{"data": "5,3,1,0,0,1,1,1,1,0,0,1"}

	The order of the input parameters: 
		"AppID"
		"Deployment Type"
		"Numbre of bug fixes"
		"Number of features"
		"Number of POC"
		"Number of config"
		"Manual test"
		"UAT test"
		"Integration test"
		"Number of downstreams"
		"Number of upstreams"
		"Hosting platform"



