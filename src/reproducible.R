library( ANTsR )
fi <- antsImageRead(getANTsRData("r16") )
mi <- antsImageRead(getANTsRData("r64") )
tx = 'SyN'
metrics = c( 'MeanSquares','GC',"Mattes")
for ( metric in metrics ) {
  mytx1 <- antsRegistration(fixed=fi, mi, typeofTransform = tx, affMetric=metric )
  p1=getAntsrTransformParameters( readAntsrTransform( mytx1$fwdtransforms[2] ))
  for ( k in 1:1 ) {
    mytx2 <- antsRegistration(fixed=fi, mi, typeofTransform = tx, affMetric=metric  )
    p2=getAntsrTransformParameters( readAntsrTransform( mytx2$fwdtransforms[2] ))
    print( paste( metric, "Change", sum( abs( p1 - p2 ) ), "Similarity", antsImageMutualInformation( fi,mytx2$warpedmovout) ) )
  }
}
