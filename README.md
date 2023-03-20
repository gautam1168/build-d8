## d8 build scripts

The repository is part of the [Compiler Explorer](https://godbolt.org/) project. It builds
the docker images used to build the d8 runtime/compiler/tooling used on the site.

### Using the Dockerfile to make a d8 build locally

You need to have docker installed on your machine. If you do not have docker installed you can
get it from [here](https://docs.docker.com/engine/install/)

After doing this, run the following command in the root directory of this repository:

```
docker build -t d8:trunk .
```
This will create a container in your machine named `d8:trunk`

You can check if the container has been built by running the following command:
```
docker images
```
You should see the image listed as follows:
```
REPOSITORY   TAG        IMAGE ID       CREATED        SIZE
d8           trunk      fcd7f69f0e42   3 weeks ago    8.31GB
```

Once you have this, you can start a shell with this image using the following command.
```
docker run --rm -it d8:trunk bash
```

You can then build the d8 executable inside the container by running the following commands
```
cd /root/v8
python ./tools/dev/gm.py x64.release
```

After this you will see that the d8 executale is present in /root/v8/out/x64.release

You can then start a d8 shell by running the following command

```
cd /root/v8/out/x64.release
./d8
```

### Which version of d8 is the latest
To get the latest version of v8 you can list the branches that start with `branch-heads`. You can use this command to get the latest version:
```
 git branch -a | grep remotes/branch-heads | awk -F/ '{print $NF}' \
 | sort -t. -k1,1nr -k2,2nr -k3,3nr | head -n1
```
