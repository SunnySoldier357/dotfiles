#! /bin/sh

sleep 1 && killall trayer
trayer --edge top \
       --align right \
       --widthtype request \
       --height 22 \
       --transparent true \
       --alpha 0 \
       --tint 0x282c34 \
       --distance 2 \
       --distancefrom right \
       --padding 6 \
       --monitor primary
       --iconspacing 6