#!/bin/bash
app=$(basename $0)
usage(){
cat << EOF
  Usage: 
    $app --mount=<folder> --image=<name> --part=<1~9>     # Mount image to specified folder
    $app --umount=<folder>                                # Umount image
EOF
  exit 0; 
}
while getopts "h-:" o; do
  case $o in
    -)
      val=${OPTARG#*=}
      opt=${OPTARG%=$val}
      val=${OPTARG#$opt}
      val=${val/=/}
      case $opt in
        mount)
          [ "$val" == "" ] && usage
	  mount=$val
	;;
        umount)
          [ "$val" == "" ] && usage
	  umount=$val
	;;
        image)
          [ "$val" == "" ] && usage
	  image=$val
	;;
        part)
          [ "$val" == "" ] && usage
	  part=$val
	;;
        *)
          usage
	;;
      esac
      ;;
    h)
      usage
      ;;
    *)
      #echo "$o, ind='$OPTIND', arg='$OPTARG', err='$OPTERR'"
      usage
      ;;
  esac
done
shift $((OPTIND-1))
[ "$#" -ne 0 ] && usage
########################################
# Functions                            #
########################################
checknumber(){
  re='^[1-9]$'
  if ! [[ $1 =~ $re ]] ; then
    echo 1
  else
    echo 0
  fi
}
imagepartstart(){
  fdisk -l $1 | grep -A 20  Device | sed -e '1d' | sed -ne "${2}p" | awk '{print $2}'
}
imagepartend(){
  fdisk -l $1 | grep -A 20  Device | sed -e '1d' | sed -ne "${2}p" | awk '{print $3}'
}
imagepartsectors(){
  fdisk -l $1 | grep -A 20  Device | sed -e '1d' | sed -ne "${2}p" | awk '{print $4}'
}
getnewloopdev(){
  losetup -f
}
getsectorsize(){
  #fdisk -l build/2019-09-26-raspbian-buster-full.img  | grep "^Sector" | awk 'BEGIN{RS=":|\n";FS="/"} NR==2{print $1}' | sed -e 's/^[ \t]*\([0-9]\{1,\}\).*/\1/'
  # logical size
  [ $2 -eq 0 ] && (fdisk -l $1 | grep "^Sector" | awk 'BEGIN{RS=":|\n";FS="/"} NR==2{print $1}' | sed -e 's/^[ \t]*\([0-9]\{1,\}\).*/\1/')
  # physical size
  [ $2 -eq 1 ] && (fdisk -l $1 | grep "^Sector" | awk 'BEGIN{RS=":|\n";FS="/"} NR==2{print $2}' | sed -e 's/^[ \t]*\([0-9]\{1,\}\).*/\1/')
}
mountimage(){
  sector=$(getsectorsize $1 0)
  start=$(($(imagepartstart $1 $2)*$sector))
  size=$(($(imagepartsectors $1 $2)*$sector))
  loopdev=$(getnewloopdev)
  losetup -o $start --sizelimit $size $loopdev $1
  mkdir -p $3
  mount $loopdev $3
  echo $loopdev
}
getmountloopdev(){
  dev='/dev/'$(lsblk | grep $(realpath -m ${1}) | awk '{print $1}')
  echo $dev
}
umountimage(){
  #lsblk | grep $(realpath -m ${1}) | awk '{print $1}'
  loopdev=$(getmountloopdev $1)
  umount $loopdev
  losetup -d $loopdev
}
if [ "$mount" != "" ] ; then
  if [ "$image" == "" ] || [ "$part" == "" ] ; then 
    usage
  fi
  [ $(checknumber $part) -ne 0 ] && echo "--part <1~9>" && usage 
  mountimage $image $part $mount
  echo "done!!"
elif [ "$umount" != "" ]; then
  umountimage $umount
  echo "done!!"
else
  usage
fi
exit 0;

