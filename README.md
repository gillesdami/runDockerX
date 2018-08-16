# runDockerX

Bash program to launch graphical apps in docker without re-writing a Dockerfile and copy-pasting strange commands!

## run

runDockerX [opts] program -- build a container named program with XSOCK bindings and run it

options:

  -p PACKAGE package(s) name(s) fetched via apt-get install requiered as a string

  -d DISPLAY display used default to :0

  -r REPOSITORY repositor(y|ies) requiered to fetch the package

  -e EXTRA add the string to docker run parameters

  -c CMD command run in the container
  
  -h display this help

## examples

### run xeyes

Build a ubuntu 18:04 image and run xeyes on your display then remove the container:

./runDockerX.sh -e rm" xeyes

### run pinta

Build a ubuntu 18:04 image with pinta installed and run it on your display with ME's Picture directory mouted then remove the container:

./runDockerX.sh -p pinta -e "--rm -v /home/ME/Pictures:/home" pinta