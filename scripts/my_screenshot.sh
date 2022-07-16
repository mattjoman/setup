#!/bin/bash
mkdir -p ~/Pictures
flameshot full -p ~/Pictures/$(date +%Y_%m_%d_%H_%M).png
