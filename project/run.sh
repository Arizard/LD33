#!/bin/sh


#zip files into .love
zip -r ../${PWD##*/}.love *

#run .love
loveFile="${PWD}.love"
cd ..
love $loveFile
