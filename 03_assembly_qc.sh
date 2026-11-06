#!/usr/bin/env bash
# Thesis 3.6.5 and 3.7.2: QUAST, Bowtie2 mapping, SAMtools coverage, CheckV
# Usage: bash 03_assembly_qc.sh <sample_name>
# Expects results/<sample>/<sample>.fasta (the phage genome you picked after assembly)
set -euo pipefail
S="$1"
OUT=results/$S
G="$OUT/$S.fasta"
CHECKV_DB=${CHECKV_DB:?set CHECKV_DB to your CheckV database path}
mkdir -p "$OUT/quast" "$OUT/mapping" "$OUT/checkv"

quast.py -o "$OUT/quast" "$G"

bowtie2-build "$G" "$OUT/mapping/$S"
bowtie2 -x "$OUT/mapping/$S" \
  -1 "$OUT/trimmed/${S}_R1_trimmed.fastq" -2 "$OUT/trimmed/${S}_R2_trimmed.fastq" \
  -p 8 2> "$OUT/mapping/${S}_bowtie2_summary.txt" \
  | samtools sort -o "$OUT/mapping/$S.sorted.bam" -
samtools index "$OUT/mapping/$S.sorted.bam"
samtools depth -a "$OUT/mapping/$S.sorted.bam" > "$OUT/mapping/${S}_depth.tsv"
samtools flagstat "$OUT/mapping/$S.sorted.bam" > "$OUT/mapping/${S}_flagstat.txt"

checkv end_to_end "$G" "$OUT/checkv" -d "$CHECKV_DB" -t 8
# Bandage (v0.8.1) is a GUI tool: open results/<sample>/assembly_output/assembly_graph*.fastg
