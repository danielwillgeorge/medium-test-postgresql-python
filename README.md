# Running PostgreSQL Tests in a Docker Pipeline From Scratch (Almost)

To run this code locally, first make sure that you have installed Docker.  Then, clone the repo and follow these steps:

1. `virtualenv ENV`
2. `docker build -t docker_postgresql_test:latest .`
3. `docker run -it docker_postgresql_test:latest`

That's it!
