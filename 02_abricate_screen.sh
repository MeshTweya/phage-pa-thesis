#!/usr/bin/env bash
# Thesis 3.11.1: screen assembled isolate genomes against VFDB, Abricate v1.0.1
# Usage: bash 02_abricate_screen.sh <dir_with_isolate_fastas> <output_dir>
set -euo pipefail
IN="$1"; OUT="$2"
mkdir -p "$OUT"
abricate --list > "$OUT/abricate_databases.txt"
for f in "$IN"/*.fasta; do
  n=$(basename "$f" .fasta)
  abricate --db vfdb "$f" > "$OUT/$n.vfdb.tab"
done
abricate --summary "$OUT"/*.vfdb.tab > "$OUT/vfdb_summary.tsv"
# The summary table is the input for 06_biofilm/01_gene_heatmap.R
