#!/usr/bin/env bash
# QC -> assembly -> annotation -> synteny, then lytic protein candidate list.
# Activate the environments first:
#   conda activate phage-genomics   (for the first part)
#   conda activate phage-protein    (for the last line)
# Needs: CHECKV_DB and PHAROKKA_DB set; reads in 01_reads_to_assembly/raw_reads/.
set -euo pipefail
ROOT=$(pwd)
( cd 01_reads_to_assembly && bash run_all.sh )

while read -r S; do
  [ -z "$S" ] && continue
  bash 02_annotation/01_pharokka.sh "01_reads_to_assembly/results/$S/$S.fasta" "02_annotation/results/$S"
  cp "02_annotation/results/$S/pharokka.gbk" "03_comparative_genomics/genbank/$S.gbk"
done < 01_reads_to_assembly/samples.txt

( cd 03_comparative_genomics && bash 01_clinker.sh )

echo "VIRIDIC and ViPTree are web servers: upload the FASTA files from 01_reads_to_assembly/results/*/ and note settings in 03_comparative_genomics/settings.md"
echo "Next, in the phage-protein env: python 04_lytic_proteins/00_extract_lytic_proteins.py 03_comparative_genomics/genbank 04_lytic_proteins/results"
