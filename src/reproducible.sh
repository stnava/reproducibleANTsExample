#!/bin/bash
export ANTSPATH=~/code/ants-src/build/bin/
export ANTS_RANDOM_SEED=1234
export ITK_GLOBAL_DEFAULT_NUMBER_OF_THREADS=1
f=../data/r16slice.jpg
m=../data/r64slice.jpg
for i in 1 2; do
  antsRegistrationSyNQuick.sh -d 2 -f $f -m $m -t a -o ../results/run${i}FixSeed -n 1 -e 1234567
done

Rscript -e 'library(ANTsR)
  print(getAntsrTransformParameters( readAntsrTransform( "../results/run1FixSeed0GenericAffine.mat" ) ) )
  print(getAntsrTransformParameters( readAntsrTransform( "../results/run2FixSeed0GenericAffine.mat" ) ) )'


