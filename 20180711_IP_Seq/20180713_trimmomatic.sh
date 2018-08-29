#!/usr/bin/sh
for R1 in EGFP3*R1_001.fastq.gz
do 
  R2=${R1%%R1_001.fastq.gz}"R2_001.fastq.gz"
  trimmomatic \
           PE \
          -trimlog /home/imb-n420-cll/Bioinformatic_Project/90.Analysis_workbench/93.Command_Record/$R1.log \
          -summary /home/imb-n420-cll/Bioinformatic_Project/90.Analysis_workbench/93.Command_Record/$R1.summary \
          $R1 \
          $R2 \
          /home/imb-n420-cll/Bioinformatic_Project/90.Analysis_workbench/02.QC_FASTQ/${R1%%.fastq.gz}.Paired.fastq.gz \
          /home/imb-n420-cll/Bioinformatic_Project/90.Analysis_workbench/02.QC_FASTQ/${R1%%.fastq.gz}.UnPaired.fastq.gz \
          /home/imb-n420-cll/Bioinformatic_Project/90.Analysis_workbench/02.QC_FASTQ/${R2%%.fastq.gz}.Paired.fastq.gz \
          /home/imb-n420-cll/Bioinformatic_Project/90.Analysis_workbench/02.QC_FASTQ/${R2%%.fastq.gz}.UnPaired.fastq.gz \
          ILLUMINACLIP:/home/imb-n420-cll/Bioinformatic_Project/90.Analysis_workbench/95.Adapter_FASTA/NextEra.fa:0:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:25 MINLEN:87
done


for R1 in EGFP5*R1_001.fastq.gz
do 
  R2=${R1%%R1_001.fastq.gz}"R2_001.fastq.gz"
  trimmomatic \
           PE \
          -trimlog /home/imb-n420-cll/Bioinformatic_Project/90.Analysis_workbench/93.Command_Record/$R1.log \
          -summary /home/imb-n420-cll/Bioinformatic_Project/90.Analysis_workbench/93.Command_Record/$R1.summary \
          $R1 \
          $R2 \
          /home/imb-n420-cll/Bioinformatic_Project/90.Analysis_workbench/02.QC_FASTQ/${R1%%.fastq.gz}.Paired.fastq.gz \
          /home/imb-n420-cll/Bioinformatic_Project/90.Analysis_workbench/02.QC_FASTQ/${R1%%.fastq.gz}.UnPaired.fastq.gz \
          /home/imb-n420-cll/Bioinformatic_Project/90.Analysis_workbench/02.QC_FASTQ/${R2%%.fastq.gz}.Paired.fastq.gz \
          /home/imb-n420-cll/Bioinformatic_Project/90.Analysis_workbench/02.QC_FASTQ/${R2%%.fastq.gz}.UnPaired.fastq.gz \
          ILLUMINACLIP:/home/imb-n420-cll/Bioinformatic_Project/90.Analysis_workbench/95.Adapter_FASTA/NextEra.fa:0:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:25 MINLEN:93
done

