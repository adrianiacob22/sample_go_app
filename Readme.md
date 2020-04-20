The Application Files
Our sample application will respond with ‘Hello World’ to any GET request. --> main.go

Since we are building a CD pipeline, we should have some tests in place. Our code is so simple that it only needs one test case; ensuring that we receive the correct string when we hit the root URL. --> main_test.go

The Dockerfile
The Dockerfile is a multistage one to keep the image size as small as possible. It starts with a build image based on golang:alpine. The resulting binary is used in the second image, which is just a scratch one. A scratch image contains no dependencies or libraries, just the binary file that starts the application.
