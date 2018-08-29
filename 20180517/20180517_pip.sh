source activate RNASeq
fastqc -o ~/Bioinformatic_Project/90.Analysis_workbench/01.QC_Output/ -t 6 ~/Bioinformatic_Project/90.Analysis_workbench/00.FASTQ/$1 
cutadapt -g file:/home/imb-n420-cll/Bioinformatic_Project/90.Analysis_workbench/95.Adapter_FASTA/$2 -q 32 -e 0 -j 6 --trim-n --no-indels -m 75 -o ~/Bioinformatic_Project/90.Analysis_workbench/02.QC_FASTQ/$1.cut.gz ~/Bioinformatic_Project/90.Analysis_workbench/00.FASTQ/$1 > ~/Bioinformatic_Project/90.Analysis_workbench/02.QC_FASTQ/$1.cut_result.txt
fastqc -o ~/Bioinformatic_Project/90.Analysis_workbench/01.QC_Output/ -t 6 ~/Bioinformatic_Project/90.Analysis_workbench/02.QC_FASTQ/$1.cut.gz
hisat2 --mp 1,0 -p 6 -x /home/imb-n420-cll/Bioinformatic_Project/90.Analysis_workbench/96.HISAT2_index/03.N420_UTR_Library/N420_UTR -U ~/Bioinformatic_Project/90.Analysis_workbench/02.QC_FASTQ/$1.cut.gz -S ~/Bioinformatic_Project/90.Analysis_workbench/03.Alignment_Output/$1.cut.sam > ~/Bioinformatic_Project/90.Analysis_workbench/03.Alignment_Output/$1.align_result.txt
salmon quant -p 6 -t /home/imb-n420-cll/Bioinformatic_Project/90.Analysis_workbench/99.Database_Fasta/Final_FASTA_w0_ds.fasta -l A -a ~/Bioinformatic_Project/90.Analysis_workbench/03.Alignment_Output/$1.cut.sam -o ~/Bioinformatic_Project/90.Analysis_workbench/05.Count_Output/$1_count
source deactivate

