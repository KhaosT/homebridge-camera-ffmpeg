#!/bin/bash

INSTANCE=$1
FILENAME=$2

OS=`uname -s`
if [[ "$OS" == 'Darwin' ]]; then
  # OPTIONS=
  echo "Mac"
elif [[ "$OS" == 'Linux' ]]; then
  # OPTIONS="-c:v h264_omx -profile:v high -b:v 3000000"
  OPTIONS="-c:v h264_omx -b:v 3000000"
  echo "Linux"
fi

(cd /var/tmp
#rm *mp4
ls -tr ${INSTANCE}/* | tail -61 | head -60 | awk '{ print "file "$1 }' > ${INSTANCE}.txt
#ffmpeg -f concat -c:v h264_mmal -i ${INSTANCE}.txt -c:v h264_omx -profile:v high -b:v 3000000 -y ${FILENAME}
~/npm/lib/node_modules/ffmpeg-for-homebridge/ffmpeg -f concat -i ${INSTANCE}.txt ${OPTIONS} -vf "select=gt(scene\,0.01),setpts=0.5*PTS" -y ${FILENAME}
)
