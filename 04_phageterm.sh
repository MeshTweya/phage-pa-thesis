#!/usr/bin/env bash
# Thesis 3.7.2: genome termini and packaging, PhageTerm v1.0.12
# Usage: bash 04_phageterm.sh <sample_name>
# The thesis gives: --report_title "Phage_name" --seed 50 --threshold 0.85
# Check the exact flag names for your installed version with: PhageTerm.py -h
set -euo pipefail
S="$1"
OUT=results/$S
mkdir -p "$OUT/phageterm"
cd "$OUT/phageterm"
PhageTerm.py \
  -f "../trimmed/${S}_R1_trimmed.fastq" -p "../trimmed/${S}_R2_trimmed.fastq" \
  -r "../$S.fasta" -n "$S" --report_title "$S" --seed 50 --threshold 0.85
