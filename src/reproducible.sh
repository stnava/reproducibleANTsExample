#!/bin/bash
export ANTSPATH=/home/avants/code/ants-src/build/install/bin/
export ANTS_RANDOM_SEED=1234
export ITK_GLOBAL_DEFAULT_NUMBER_OF_THREADS=1
f=../data/r16slice.jpg
m=../data/r64slice.jpg
for i in 1 2; do
  ${ANTSPATH}antsRegistrationSyNQuick.sh -d 2 -f $f -m $m -t a -o ../results/run${i}FixSeed -n 1 -e 1234567
done

Rscript -e 'library(ANTsR)
  print(getAntsrTransformParameters( readAntsrTransform( "../results/run1FixSeed0GenericAffine.mat" ) ) )
  print(getAntsrTransformParameters( readAntsrTransform( "../results/run2FixSeed0GenericAffine.mat" ) ) )'

# another approach - no sampling
${ANTSPATH}antsRegistration --verbose 1 --random-seed 1234567 --dimensionality 2 --float 0 --collapse-output-transforms 1 --output [../results/run1FixSeed,../results/run1FixSeedWarped.nii.gz,../results/run1FixSeedInverseWarped.nii.gz] --interpolation Linear --use-histogram-matching 0 --winsorize-image-intensities [0.005,0.995] --initial-moving-transform [../data/r16slice.jpg,../data/r64slice.jpg,1] --transform Rigid[0.1] --metric MI[../data/r16slice.jpg,../data/r64slice.jpg,1,32] --convergence [1000x500x250x0,1e-6,10] --shrink-factors 8x4x2x1 --smoothing-sigmas 3x2x1x0vox --transform Affine[0.1] --metric MI[../data/r16slice.jpg,../data/r64slice.jpg,1,32] --convergence [1000x500x250x0,1e-6,10] --shrink-factors 8x4x2x1 --smoothing-sigmas 3x2x1x0vox
${ANTSPATH}antsRegistration --verbose 1 --random-seed 1234567 --dimensionality 2 --float 0 --collapse-output-transforms 1 --output [../results/run2FixSeed,../results/run2FixSeedWarped.nii.gz,../results/run2FixSeedInverseWarped.nii.gz] --interpolation Linear --use-histogram-matching 0 --winsorize-image-intensities [0.005,0.995] --initial-moving-transform [../data/r16slice.jpg,../data/r64slice.jpg,1] --transform Rigid[0.1] --metric MI[../data/r16slice.jpg,../data/r64slice.jpg,1,32] --convergence [1000x500x250x0,1e-6,10] --shrink-factors 8x4x2x1 --smoothing-sigmas 3x2x1x0vox --transform Affine[0.1] --metric MI[../data/r16slice.jpg,../data/r64slice.jpg,1,32] --convergence [1000x500x250x0,1e-6,10] --shrink-factors 8x4x2x1 --smoothing-sigmas 3x2x1x0vox

Rscript -e 'library(ANTsR)
  print(getAntsrTransformParameters( readAntsrTransform( "../results/run1FixSeed0GenericAffine.mat" ) ) )
  print(getAntsrTransformParameters( readAntsrTransform( "../results/run2FixSeed0GenericAffine.mat" ) ) )'
