#!/bin/bash
help="$(basename "$0") [opts] program -- build a container named program with XSOCK bindings and run it

options:
  -p PACKAGE package(s) name(s) fetched via apt-get install requiered as a string
  -d DISPLAY display used default to :0
  -r REPOSITORY repositor(y|ies) requiered to fetch the package
  -e EXTRA add the string to docker run parameters
  -c CMD command run in the container
  -h display this help

examples: 
  $0 -e \"--rm\" xeyes
  $0 -e --rm -e \"-v \$(pwd):/home/\" -p pinta pinta
"

REPOSITORY=""
PACKAGE=""
DISP=":0"
EXTRA=""
OPTS=""

while getopts ":p:r:d:e:c:h" opt; do
  case $opt in
    p)
      PACKAGE=$OPTARG
      ;;
    d)
      DISP=$OPTARG
      ;;
    r)
      REPOSITORY=$OPTARG
      ;;
    e)
      EXTRA="$EXTRA $OPTARG"
      ;;
    c)
      CMD=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG"
      echo "$help"
      exit 1
      ;;
    h)
      echo "$help"
      exit 1
      ;;
  esac
done

shift $((OPTIND-1))
[ "${1:-}" = "--" ] && shift

XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

docker build -t $@:rdx --build-arg PACKAGE=$PACKAGE --build-arg DISPLAY=$DISP --build-arg REPOSITORY=$REPOSITORY --build-arg PROGRAM=$@ .
docker run -ti -v $XSOCK:$XSOCK -v $XAUTH:$XAUTH -e XAUTHORITY=$XAUTH --device /dev/snd $EXTRA $@:rdx $CMD