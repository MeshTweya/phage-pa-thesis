#!/usr/bin/env bash
# Steps 1-4 for every sample in samples.txt. Run from inside this folder, in the phage-genomics env.
# Needs raw_reads/<sample>_R1.fastq and _R2.fastq, and CHECKV_DB set.
set -euo pipefail
while read -r S; do
  [ -z "$S" ] && continue
  bash 01_qc_and_trim.sh "$S"
  bash 02_assemble.sh "$S"
  bash 02b_pick_contig.sh "$S"
  bash 03_assembly_qc.sh "$S"
  bash 04_phageterm.sh "$S"
done < samples.txt
