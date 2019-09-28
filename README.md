# reproducibleANTsExample
Demonstrate how to create reproducible registration results with ANTs.

primarily, make sure you set:

```
export ITK_GLOBAL_DEFAULT_NUMBER_OF_THREADS=1
export ANTS_RANDOM_SEED=1
```

in your environment.  this will work for ANTs, ANTsR or ANTsPy.
make sure these are instantiated before you call R or python.

in R, these will be over-ridden but whatever is set in .Renviron.

Currently, the mutual information metric is the "most" stochastic.

This is intrinsic to the nature of the metric.
