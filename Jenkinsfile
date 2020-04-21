pipeline {
   agent {
   kubernetes {
       // Rather than inline YAML, in a multibranch Pipeline you could use: yamlFile 'jenkins-pod.yaml'
       // Or, to avoid YAML:
       // containerTemplate {
       //     name 'shell'
       //     image 'ubuntu'
       //     command 'sleep'
       //     args 'infinity'
       // }
       yaml '''
apiVersion: v1
kind: Pod
spec:
containers:
- name: shell
image: ubuntu
command:
- sleep
args:
- 50
'''
       // Can also wrap individual steps:
       // container('shell') {
       //     sh 'hostname'
       // }
       defaultContainer 'shell'
   }
   }
   environment {
         GOCACHE = "/tmp"
   }
   stages {
       stage('Build') {
           agent {
               docker {
                   image 'golang'
               }
           }
           steps {
               // Create our project directory.
               sh 'cd ${GOPATH}/src'
               sh 'mkdir -p ${GOPATH}/src/hello-world'
               // Copy all files in our Jenkins workspace to our project directory.
               sh 'cp -r ${WORKSPACE}/* ${GOPATH}/src/hello-world'
               // Build the app.
               sh 'go build'
               sh 'hostname'
           }
       }
       stage('Test') {
           agent {
               docker {
                   image 'golang'
               }
           }
           steps {
               // Create our project directory.
               sh 'cd ${GOPATH}/src'
               sh 'mkdir -p ${GOPATH}/src/hello-world'
               // Copy all files in our Jenkins workspace to our project directory.
               sh 'cp -r ${WORKSPACE}/* ${GOPATH}/src/hello-world'
               // Remove cached test results.
               sh 'go clean -cache'
               // Run Unit Tests.
               sh 'go test ./... -v -short'
           }
       }

   }
}
