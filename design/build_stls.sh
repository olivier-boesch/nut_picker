#!/usr/bin/bash

echo "#########################################################"
echo "# Nut Picker                                            #"
echo "# Olivier Boesch (c) 2021                               #"
echo "# published under CC BY-NC-SA v4 Licence                #"
echo "# https://creativecommons.org/licenses/by-nc-sa/4.0/    #"
echo "#########################################################"

echo "exporting Nut Picker parts to stl"

echo "* exporting nut/bolt test for 3d printing to stl"
# export test
openscad -D 'export="test_nut_bolt"' scad/nut_picker.scad -o stl/test_nut_bolt.stl

echo "* exporting nut to stl"
# export nut
openscad -D 'export="nut"' scad/nut_picker.scad -o stl/nut.stl

echo "* exporting box parts to stl"
# export box parts
echo "** exporting box (up side) to stl"
openscad -D 'export="up"' scad/nut_picker.scad -o stl/up.stl
echo "** exporting box (down side) to stl"
openscad -D 'export="down"' scad/nut_picker.scad -o stl/down.stl
echo "** exporting box (left side) to stl"
openscad -D 'export="left"' scad/nut_picker.scad -o stl/left.stl
echo "** exporting box (right side) to stl"
openscad -D 'export="right"' scad/nut_picker.scad -o stl/right.stl
echo "** exporting box (front side) to stl"
openscad -D 'export="front"' scad/nut_picker.scad -o stl/front.stl
echo "** exporting box (rear side) to stl"
openscad -D 'export="rear"' scad/nut_picker.scad -o stl/rear.stl

echo "* exporting dice parts to stl"
# export dice parts
echo "** exporting dice body to stl"
openscad -D 'export="body"' scad/nut_picker_dice.scad -o stl/dice_body.stl
echo "** exporting dice round to stl"
openscad -D 'export="round"' scad/nut_picker_dice.scad -o stl/dice_round.stl
echo "** exporting dice cross to stl"
openscad -D 'export="cross"' scad/nut_picker_dice.scad -o stl/dice_cross.stl

echo "done."
