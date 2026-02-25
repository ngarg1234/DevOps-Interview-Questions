Prerequisites
Minimum hardware requirements:
-> 256 MB of RAM
-> 1 GB of drive space (although 10 GB is a recommended minimum if running Jenkins as a Docker container)

Recommended hardware configuration for a small team:
-> 4 GB+ of RAM
-> 50 GB+ of drive space

Comprehensive hardware recommendations:
-> Hardware: see the Hardware Recommendations page

Software requirements:
-> Java: see the Java Requirements page
-> For Linux operating system: Linux Support Policy
-> For servlet containers: Servlet Container Support Policy


sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins

The package installation will:
1. Setup Jenkins as a daemon launched on start. Run systemctl cat jenkins for more details.
2. Create a ‘jenkins’ user to run this service.
3. Direct console log output to systemd-journald. Run journalctl -u jenkins.service if you are troubleshooting Jenkins.
4. Populate /lib/systemd/system/jenkins.service with configuration parameters for the launch, e.g JENKINS_HOME
5. Set Jenkins to listen on port 8080. Access this port with your browser to start configuration.


1. Install Jenkins on Linux (Ubuntu/Debian)

Update the system:
sudo apt update
sudo apt upgrade -y

Install Java (Jenkins requires Java to run):
sudo apt install openjdk-11-jdk -y  # Jenkins recommends Java 11 or later
java -version

Add the Jenkins repository:

Download and add the Jenkins repository to your system:
wget -q -O - https://pkg.jenkins.io/keys/jenkins.io.key | sudo tee /etc/apt/trusted.gpg.d/jenkins.asc

Add the Jenkins repository:
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable/ stable main > /etc/apt/sources.list.d/jenkins.list'

Install Jenkins:
sudo apt update
sudo apt install jenkins -y

Start Jenkins service:
sudo systemctl start jenkins

Enable Jenkins to start at boot:
sudo systemctl enable jenkins

Check if Jenkins is running:
sudo systemctl status jenkins

Access Jenkins UI:

By default, Jenkins runs on port 8080. Open a browser and go to:
http://<your_server_ip>:8080

Unlock Jenkins:
When you first access Jenkins, you will be asked to unlock it with a secret key. Retrieve the key using the following command:
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

Copy and paste the secret key into the setup wizard to unlock Jenkins.
Complete the setup wizard:

After unlocking Jenkins, you can choose to install the suggested plugins and create an admin user for Jenkins.