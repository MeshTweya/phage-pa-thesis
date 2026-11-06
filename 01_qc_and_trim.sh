#!/usr/bin/env bash
# Thesis 3.6.2-3.6.3: raw QC (FastQC v0.11.9), trimming (BBDuk, BBTools v38.18)
# Usage: bash 01_qc_and_trim.sh <sample_name>
# Expects: raw_reads/<sample>_R1.fastq(.gz) and raw_reads/<sample>_R2.fastq(.gz)
set -euo pipefail
S="$1"
RAW=raw_reads
OUT=results/$S
THREADS=8
mkdir -p "$OUT/fastqc_raw" "$OUT/fastqc_trimmed" "$OUT/trimmed"

fastqc -t $THREADS -o "$OUT/fastqc_raw" "$RAW/${S}_R1.fastq"* "$RAW/${S}_R2.fastq"*

# adapters.fa and phix174.fa ship in the BBTools resources folder; point to your copies
bbduk.sh in1="$RAW/${S}_R1.fastq" in2="$RAW/${S}_R2.fastq" \
  out1="$OUT/trimmed/${S}_R1_trimmed.fastq" out2="$OUT/trimmed/${S}_R2_trimmed.fastq" \
  ref=adapters.fa,phix174.fa ktrim=r k=23 mink=11 hdist=1 qtrim=rl trimq=20 minlen=50

fastqc -t $THREADS -o "$OUT/fastqc_trimmed" "$OUT/trimmed/${S}_R1_trimmed.fastq" "$OUT/trimmed/${S}_R2_trimmed.fastq"
