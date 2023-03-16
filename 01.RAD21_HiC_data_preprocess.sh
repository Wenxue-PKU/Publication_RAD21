#!/bin/bash
# Rad21 Hi-C data preprocessing
# 2021.06.20 zhaowx

# trim_galore cut adaptor
cd /project/Rad21/rawdata/
ls *R1.fastq.gz > 1
ls *R2.fastq.gz > 2
paste 1 2  > config

cat config | while read config
do
arr=($config)
fq1=${arr[0]}
fq2=${arr[1]}
pkurun-cns 1 20 trim_galore --paired --core 6 --fastqc --length 20 -e 0.1 -q 20 -o . $fq1 $fq2
done

# trim_galore cut adaptor
pkurun-cns 1 20 /lustre1/lch3000_pkuhpc/zhaowx/software/HiC-Pro_2.11.4/bin/HiC-Pro -i ./rawdata/ -o hicpro_results -c config-hicpro_rad21.txt
