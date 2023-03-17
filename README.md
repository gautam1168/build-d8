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

Once you have this, you can run a container with this image using the following command:
```
docker run -d -t d8:trunk
```

You can see the running container by running the following command:
```
docker ps
```

You will see something like this:
```
CONTAINER ID   IMAGE      COMMAND   CREATED              STATUS              PORTS     NAMES
cfdab51b3818   d8:trunk   "fish"    About a minute ago   Up About a minute             compassionate_lamport
```

You can then open a shell inside this container using:
```
docker exec -it cfdab51b3818 fish
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
According to [this blogpost](https://v8.dev/docs/release-process) on v8's blog, the release process of v8 is coupled with chrome. You 
probably want the latest version of d8 that is associated with the latest chrome release. To find this version you have to look at [OmahaProxy](https://omahaproxy.appspot.com/).
If you are using this container you want the stable branch for linux. Look at the the column `true branch` in the table and get the number corresponding to `linux` and `stable` channel. At the time of writing this, the number is `5563`. So the branch you want to checkout is `chromium/5563`. 
