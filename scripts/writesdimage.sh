#!/bin/bash
app=$(basename ${BASH_SOURCE[0]})
usage(){
cat << EOF
  usage: 
    $app -d|--device <device> -i|--image <image>       # write image to device
    $app -h|--help                                     # show usage

  parameters: 
    --device <device> 
        device for image, ex: /dev/sde
    --image <image>
        image file, ex: build/2019-09-26-raspbian-buster-full.img

  optional: 
    --bs <bytes>
        bytes to write at one time, ex: 4M (dd supported format)
    --force <0|1>
        without prompt, default is 0
EOF
  exit 1;
}
bs=4M
force=0
opts=$(getopt -o hi:d: -l help,device:,image:,bs:,force: -- "$@")
[ $? -ne 0 ] && usage
eval set -- "$opts"
[ "$1" == "--" ] && usage
while true
do
  case $1 in 
    -d|--device)
      device=$2
      shift 2
    ;;
    -i|--image)
      image=$2
      shift 2
    ;;
    --bs)
      bs=$2
      shift 2
    ;;
    --force)
      re='^[01]$'; 
      [[ "$2" =~ "$re" ]] && usage
      force=$2
      shift 2
    ;;
    -h|--help)
      usage
    ;;
    --)
      shift
      break; 
    ;;
  esac
done
writeimage2device(){
  dd if=$image of=$device bs=4M status=progress conv=fsync
  exit 0;
}
while true
do
  if [ $force -eq 0 ]
  then
    echo image=$image, device=$device
    echo "Are you sure to write image to device? [y/n]"
    read yn
    case $yn in
      y)
        writeimage2device
        ;;
      n)
        echo "bye!!"
        exit 1;
        ;;
    esac
  else
    writeimage2device
  fi
done

