#!/usr/bin/sh
projectPath=/home/imb-n420-cll/Bioinformatic_Project/90.Analysis_workbench/
alignmentPath=${projectPath}03.Alignment_Output/00.SAM/
sampleList=(${alignmentPath}*.sam)
outputPath=${projectPath}03.Alignment_Output/02.Sorted_BAM/

#Sorting
for sam in ${sampleList[@]}
do
  samtools \
      view \
        -b \
      $sam \
| samtools \
      sort \
         > ${outputPath}$(basename ${sam%%.sam})_sorted.bam
  echo "$(basename $sam) DONE"
done

echo "Sorting Done"

cd ${outputPath}
finalList=$(ls | cut -d "_" -f1 | sort | uniq)

echo "Making finalList"

#merge
for sp in ${finalList[@]}
do 
  samtools \
     merge \
     ${outputPath}${sp}_merge.bam \
     ${outpurPath}${sp}*
  echo "$(basename $sp) Done"   
done

echo "Merging File"

cd ${outputPath}
ls | grep -v _merge | xargs rm

echo "Done"
