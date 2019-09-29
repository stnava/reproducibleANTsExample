import ants

fi = ants.image_read(ants.get_data("r16"))
mi = ants.image_read(ants.get_data("r64"))
tx = "Affine"
pnum = 0
tx = "SyN"
pnum = 1
metrics = ["MeanSquares", "GC", "Mattes"]
asr = 1
for m in range(0, len(metrics)):
    mytx1 = ants.registration(
        fixed=fi,
        moving=mi,
        type_of_transform=tx,
        aff_metric=metrics[m],
        aff_random_sampling_rate=asr,
    )
    p1 = ants.read_transform(mytx1["fwdtransforms"][pnum])
    p1 = ants.get_ants_transform_parameters(p1)
    for k in range(0, 2):
        mytx2 = ants.registration(
            fixed=fi,
            moving=mi,
            type_of_transform=tx,
            aff_metric=metrics[m],
            aff_random_sampling_rate=asr,
        )
        p2 = ants.read_transform(mytx2["fwdtransforms"][pnum])
        p2 = ants.get_ants_transform_parameters(p2)
        metval = ants.image_mutual_information(fi, mytx2["warpedmovout"])
        chg = abs(p2 - p1).sum()
        print(
            metrics[m]
            + " Change: try "
            + str(k)
            + " Is "
            + str(chg)
            + " Similarity= "
            + str(metval)
        )
