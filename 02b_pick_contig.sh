#!/usr/bin/env bash
# Takes the longest SPAdes contig as the phage genome and writes results/<sample>/<sample>.fasta
# Check this against the assembly graph in Bandage and the QUAST output, especially if a
# sample gives more than one large contig.
# Usage: bash 02b_pick_contig.sh <sample_name>
set -euo pipefail
S="$1"
OUT=results/$S
seqkit sort -l -r "$OUT/assembly_output/contigs.fasta" | seqkit head -n 1 | seqkit replace -p '.*' -r "$S" > "$OUT/$S.fasta"
seqkit stats "$OUT/$S.fasta"
