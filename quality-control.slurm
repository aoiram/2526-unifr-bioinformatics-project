#!/bin/bash

#SBATCH --mail-type=end,fail
#SBATCH --job-name="QC"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=2
#SBATCH --time=2:00:00
#SBATCH --mem=25G
#SBATCH --partition=pcoursea
#SBATCH --mail-user=mario.amos@students.unibe.ch

source /data/users/lfalquet/SBC07107_25/scripts/module.sh

#create and go to the TP directory
mkdir /data/users/${USER}/QC
cd /data/users/${USER}/QC

ln -s /data/users/lfalquet/SBC07107_25/QC/*R1*.fastq.gz .
ln -s /data/users/lfalquet/SBC07107_25/QC/*R2*.fastq.gz .
ln -s /data/users/lfalquet/SBC07107_25/QC/TruSeq3-SE .

for k in `ls -1 *.fastq.gz`;
do fastqc -t 2 ${k};    
done

java -jar $EBROOTTRIMMOMATIC/trimmomatic-0.39.jar SE -phred33 -threads 4 JK2*_R1*.fastq.gz JK2_cleaned.fastq.gz ILLUMINACLIP:TruSeq3-SE:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:51

java -jar $EBROOTTRIMMOMATIC/trimmomatic-0.39.jar PE -phred33 -threads 4 D-4*_R1*.fastq.gz D-4*_R2*.fastq.gz D-4_1trim.fastq.gz D-4_1unpaired.fastq.gz D-4_2trim.fastq.gz D-4_2unpaired.fastq.gz LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:100

fastqc -t 2 JK2_cleaned.fastq.gz
fastqc -t 2 D-4_*trim.fastq.gz

multiqc .