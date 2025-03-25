// vars/checkoutCode.groovy
def call(String repoUrl, String branch = 'main') {
    echo "Checking out ${repoUrl} from branch ${branch}..."
    checkout([$class: 'GitSCM', branches: [[name: "*/${branch}"]],
              userRemoteConfigs: [[url: repoUrl]]])
}
