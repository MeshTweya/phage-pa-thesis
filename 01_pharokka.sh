#!/usr/bin/env bash
# genome annotation, Pharokka v1.4.0, default parameters
# Usage: bash 01_pharokka.sh <genome.fasta> <output_dir>
set -euo pipefail
PHAROKKA_DB=${PHAROKKA_DB:?set PHAROKKA_DB to your Pharokka database path}
pharokka.py -i "$1" -o "$2" -t 8 -d "$PHAROKKA_DB" -f   # -f only lets it overwrite an existing output folder
