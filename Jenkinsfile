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
        // Create our project directory.
        sh 'cd ${GOPATH}/src'
        sh 'mkdir -p ${GOPATH}/src/hello-world'
        // Copy all files in our Jenkins workspace to our project directory.
        sh 'cp -r ${WORKSPACE}/* ${GOPATH}/src/hello-world'
        // Build the app.
        sh 'go build'
      }
    }
