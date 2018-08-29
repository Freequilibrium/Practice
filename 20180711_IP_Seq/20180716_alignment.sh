#!/usr/bin/sh
projectPath=/home/imb-n420-cll/Bioinformatic_Project/90.Analysis_workbench/
readPath=${projectPath}02.QC_FASTQ/
indexPath=${projectPath}96.HISAT2_index/04.20180712_IP/
outputPath=${projectPath}03.Alignment_Output/00.SAM/
recordPath=${projectPath}93.Command_Record/20180712_IP_testSeq/
list1=(${readPath}*R1_001.Paired.fastq.gz)
list2=(${readPath}*.UnPaired.fastq.gz)

for R1 in ${list1[@]}
do 
  R2=${R1%%R1_001.Paired.fastq.gz}R2_001.Paired.fastq.gz
  hisat2 \
    --mp 1,1 \
      -x ${indexPath}20180712_IP \
      -1 $R1 \
      -2 $R2 \
      -S ${outputPath}$(basename ${R1%%R1_001.Paired.fastq.gz})Paired.sam \
      >& ${recordPath}$(basename ${R1%%R1_001.Paired.fastq.gz}).record
done

for U1 in ${list2[@]}
  do 
    hisat2 \
     --mp 1,1 \
       -x ${indexPath}20180712_IP \
       -U $U1 \
       -S ${outputPath}$(basename ${U1%%_UnPaired.fastq.gz}).sam \
       >& ${recordPath}$(basename ${U1%%_UnPaired.fastq.gz}).record
done

