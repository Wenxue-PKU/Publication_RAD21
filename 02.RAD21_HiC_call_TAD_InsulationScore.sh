#!/bin/bash
# Rad21 call TAD insulation score
# zhaowx 2021.06.24

abs=/hic_results/matrix/OE_rep1/raw/40000/OE_rep1_40000_abs.bed
for i in `ls /hic_results/matrix/`
do
{
  mkdir -p $i
  cd $i
  mat="/hic_results/matrix/"$i"/iced/40000/"$i"_40000_iced.matrix"
  echo $mat
  nohup /usr/bin/python2.7 /lustre/user/liclab/zhaowx/tools/HiC-Pro_2.11.4/bin/utils/sparseToDense.py -b $abs $mat -c -o dense.matrix &
  cd ..
}
done


# matrix2insulation.pl 
# -is insulation squire size 
# -ids insulation delta size
# the custom python script add_header.py will add the genome version to the matrix
for i in `ls */*matrix`
do
{
  bn=`basename $i`
  chr=${bn%_*}
  dn=`dirname $i`
  cd $dn
  /usr/bin/python2.7 /scripts/add_header.py $bn 40000 $chr > $bn".header" &
  perl /lustre/user/liclab/biotools/cworld-dekker/scripts/perl/matrix2insulation.pl -i $bn".header" --is 500000 --ids 200000 --nt 0 --ss 160000 --yb 1.5 --nt 0 --bmoe 0 &
  cd ..
}
done


# merge chromsome
for i in OE_rep1 WT_rep1
do
{
  cat $i/*_dense.matrix--is520001--nt0--ids240001--ss160001--immean.insulation.bedGraph | grep -v track | grep -v NA | grep -v "==" | grep -v "^$" | sort -k1,1 -k2,2n > $i/$i".allChr.insulation.bedGraph"
  cat $i/*_dense.matrix--is520001--nt0--ids240001--ss160001--immean.insulation.boundaries.bed | grep -v track | grep -v NA | cut -f 1,2,3 | sort -k1,1 -k2,2n > $i/$i".merge.bed"
  bedGraphToBigWig $i/$i".allChr.insulation.bedGraph" /lustre/user/liclab/zhaowx/tools/HiC-Pro_2.11.4/annotation/chrom_hg19.sizes $i/$i".allChr.insulation.bw"
  bedtools merge -d 200000 -i $i/$i".merge.bed" > $i/$i".allChr.insulation.boundaries.merged.bed" 
}
done
