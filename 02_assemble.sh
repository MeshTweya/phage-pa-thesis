#!/usr/bin/env bash
# Thesis 3.6.4: de novo assembly, SPAdes v4.0.0 metaviral mode
# Usage: bash 02_assemble.sh <sample_name>
set -euo pipefail
S="$1"
OUT=results/$S
spades.py --metaviral --only-assembler \
  -1 "$OUT/trimmed/${S}_R1_trimmed.fastq" -2 "$OUT/trimmed/${S}_R2_trimmed.fastq" \
  -o "$OUT/assembly_output" -t 8 -m 16
# Use the phage contig (the complete, circular/linear genome) as results/<sample>/<sample>.fasta
# Select it after checking contig lengths and the assembly graph in Bandage.
