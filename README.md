# docker-user-example

## Description

An example of how UIDs and GIDs work in docker containers and why it's
important not to run containers as the default root user.

Based on this article:
https://medium.com/@mccode/understanding-how-uid-and-gid-work-in-docker-containers-c37a01d01cf

## Walkthrough

By default, containers run as the root user, just try: `docker run -d
ubuntu:latest sleep infinity` and `ps aux | grep sleep`.

This means they can do X and Y

You can prevent this by writing a Dockerfile like [this one](Dockerfile)

Kill the earlier container and try `docker build -t docker-user-example .` and
`docker run -d docker-user-example --name docker-user-example`, and check `ps
aux | grep sleep` again.

This time it runs as a user with UID 1000. Outside the container, UID 1000 will be
reported as whichever username has that UID. Inside the container, UID 1000
will be reported as the user `docker`: just try `docker exec -it
docker-user-example /bin/bash` and `ps aux | grep sleep`.

Because containers use the host OS Linux kernel (unlike a full virtual machine
which runs another OS on top of the host), container permissions are based on
the user on the host. To grant UID 1000 permissions on the host, is to grant
those same permissions to the container running as UID 1000.

