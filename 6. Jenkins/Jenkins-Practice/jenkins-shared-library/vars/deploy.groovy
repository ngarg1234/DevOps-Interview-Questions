// vars/deploy.groovy
def call(String environment) {
    echo "Deploying to ${environment} environment..."
    // Replace this with your actual deployment commands
    if (environment == 'prod') {
        echo 'Deploying to Production server...'
        // sh 'deploy-to-prod.sh'
    } else {
        echo "Deploying to ${environment} environment..."
        // sh "deploy-to-${environment}.sh"
    }
}
