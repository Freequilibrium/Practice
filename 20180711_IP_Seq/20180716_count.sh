#!/usr/bin/sh
projectPath=/home/imb-n420-cll/Bioinformatic_Project/90.Analysis_workbench/
SAMPath=${projectPath}03.Alignment_Output/00.SAM/
fastaPath=${projectPath}99.Database_Fasta/
outputPath=${projectPath}05.Count_Output/

SAMList=(${SAMPath}*.sam)

for sam in ${SAMList[@]}
do
  salmon \
   quant \
      -t ${fastaPath}20180712_IP.fa \
      -l A \
      -a $sam \
      -o ${outputPath}$(basename $sam) \
      >& ${outputPath}$(basename $sam).record 
  echo "$(basename $sam) Done"
done
