// vars/sonarScan.groovy
def call() {
    echo "Running SonarQube scan..."
    withSonarQubeEnv('SonarQube') {
        sh "mvn sonar:sonar"
    }
}
