#!/usr/bin/env bash
# Thesis 3.8.2: gene-cluster synteny, Clinker v0.0.23
# Input: annotated GenBank files from Pharokka (one per phage) in genbank/
# The thesis lists --identity 0.3, plot size 15 x 10, output clinker_output.html.
# Flag names differ between Clinker versions: confirm with `clinker -h` and adjust.
set -euo pipefail
mkdir -p results
clinker genbank/*.gbk -i 0.3 -p results/clinker_output.html -o results/clinker_alignments.txt
