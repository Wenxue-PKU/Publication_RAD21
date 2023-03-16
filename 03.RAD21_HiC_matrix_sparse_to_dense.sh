#!/bin/bash
# Convert to dense format whole genome
# 2021.06.20 zhaowx


# 150k for calculate AB/(AA+BB) ratio 
abs="/hic_results/matrix/WT/raw/150000/WT_150000_abs.bed"
mat="WT_150000_iced.matrix"

/usr/bin/python2.7 /lustre/user/liclab/zhaowx/tools/HiC-Pro_2.11.4/bin/utils/sparseToDense.py -b $abs $mat -o WT_150000_dense_iced.matrix -c &

abs="/hic_results/matrix/OE/raw/150000/OE_150000_abs.bed"
mat="OE_150000_iced.matrix"

/usr/bin/python2.7 /lustre/user/liclab/zhaowx/tools/HiC-Pro_2.11.4/bin/utils/sparseToDense.py -b $abs $mat -o OE_150000_dense_iced.matrix -c &

# 500k for matrix plot
abs="/hic_results/matrix/WT/raw/500000/WT_500000_abs.bed"
mat="WT_500000_iced.matrix"

nohup /usr/bin/python2.7 /lustre/user/liclab/zhaowx/tools/HiC-Pro_2.11.4/bin/utils/sparseToDense.py -b $abs $mat -o WT_500000_iced_dense.matrix &

abs="/hic_results/matrix/OE/raw/500000/OE_500000_abs.bed"
mat="OE_500000_iced.matrix"

nohup /usr/bin/python2.7 /lustre/user/liclab/zhaowx/tools/HiC-Pro_2.11.4/bin/utils/sparseToDense.py -b $abs $mat -o OE_500000_iced_dense.matrix &

# 1M for trans/cis interaction ratio 
abs="/hic_results/matrix/OE/raw/40000/OE_40000_abs.bed"
mat="OE_40000_iced.matrix"

nohup /usr/bin/python2.7 /lustre/user/liclab/zhaowx/tools/HiC-Pro_2.11.4/bin/utils/sparseToDense.py -b $abs $mat -o OE_40000_iced_dense.matrix &

abs="/hic_results/matrix/WT/raw/40000/WT_40000_abs.bed"
mat="WT_40000_iced.matrix"

nohup /usr/bin/python2.7 /lustre/user/liclab/zhaowx/tools/HiC-Pro_2.11.4/bin/utils/sparseToDense.py -b $abs $mat -o WT_40000_iced_dense.matrix &



  
  