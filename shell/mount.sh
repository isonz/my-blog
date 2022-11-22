#!/bin/bash

mount -t cifs  -o username=ison,password=zhang //192.168.16.143/ison/back /media/back

mount -t cifs  -o username=ison,password=zhang //192.168.16.143/Public/gigi /media/gigi
