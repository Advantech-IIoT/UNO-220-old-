#!/bin/bash
usage(){
cat << EOF
  usage: 
    ${BASH_SOURCE[0]} <image>
EOF
exit 0;
}
[ -z "$1" ] && usage
echo 'Username?'
read user
echo 'Password?'
read -s pass
image=$1
image=$(realpath -m ${image})
imagedir=$(dirname ${image})
imagename=$(echo $image | sed -e "s%/.*/\([^/]*\)%\1%")
server=172.20.2.87
date=20200302
remotedir=/TestArea/Linux/EmbeddedLinux/UNO-220-IO
ftp -n << EOF
open $server
user $user $pass
cd $remotedir
mkdir $date
cd $date
lcd $imagedir
put $imagename.md5
put $imagename.sha1
put $imagename.sha256
put $imagename
put UNO-220_Release_Notes.txt
put host_send
put host_recv
EOF

