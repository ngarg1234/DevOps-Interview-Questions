// src/org/company/MavenHelper.groovy
package org.company

class MavenHelper {
    static String getMavenVersion() {
        def version = sh(script: 'mvn -v', returnStdout: true).trim()
        return version
    }
    
    static void validateMavenInstallation() {
        def version = getMavenVersion()
        if (!version) {
            error "Maven is not installed or not working properly"
        } else {
            echo "Maven version: ${version}"
        }
    }
}
