#!/bin/sh
make
if [ ! -e text8 ]; then
  wget -Nc http://mattmahoney.net/dc/text8.zip -O text8.zip
  unzip text8.zip && rm text8.zip
fi
time ./word2vec -train text8 -output vectors.bin -cbow 1 -size 200 -window 8 -negative 25 -hs 0 -sample 1e-4 -threads 20 -binary 1 -iter 15
./distance vectors.bin
