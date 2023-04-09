#!/bin/bash

xrandr --output HDMI1 --auto
xrandr --output eDP1 --auto --output HDMI1 --left-of eDP1
