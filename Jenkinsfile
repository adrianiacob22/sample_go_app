podTemplate(yaml: '''
apiVersion: v1
kind: Pod
spec:
containers:
- name: jnlp
  image: nexus.local.net:8123/jenkins-jnlp-slave:20200420
  env:
  - name: CONTAINER_ENV_VAR
    value: jnlp
- name: golang
  image: golang
  command:
  - sleep
  args:
  - infinity
imagePullSecrets:
- name: docker-repo
''')
    node(POD_LABEL) {
      container('golang'){
        sh "echo Building"
      }
      environment {
          registry = "docker-repo"
          GOCACHE = "/tmp"
      }
      stages {
          stage('Build') {
              steps {
                  // Create our project directory.
                  sh 'cd ${GOPATH}/src'
                  sh 'mkdir -p ${GOPATH}/src/hello-world'
                  // Copy all files in our Jenkins workspace to our project directory.
                  sh 'cp -r ${WORKSPACE}/* ${GOPATH}/src/hello-world'
                  // Build the app.
                  sh 'go build'
              }
          }
          stage('Test') {
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
            /*stage('Publish') {
              environment {
                  registryCredential = 'docker-repo'
              }
              steps{
                  script {
                      def appimage = docker.build registry + ":$BUILD_NUMBER"
                      docker.withRegistry( '', registryCredential ) {
                          appimage.push()
                          appimage.push('latest')
                      }
                  }
              }
          }
          stage ('Deploy') {
              steps {
                  script{
                      def image_id = registry + ":$BUILD_NUMBER"
                      sh "ansible-playbook  playbook.yml --extra-vars \"image_id=${image_id}\""
                  }
              }
          }*/
      }
    }
