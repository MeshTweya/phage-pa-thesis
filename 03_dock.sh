#!/usr/bin/env bash
# Thesis 3.9.8: AutoDock Vina v1.2.0, exhaustiveness 32, nine poses, ~25 A cubic box on the active site.
# Inputs:
#   receptors/<protein>.pdbqt   AlphaFold3 model prepared in AutoDock Tools
#                               (water/heteroatoms removed, polar H, Kollman charges)
#   ligands/pdbqt/*.pdbqt       from 02_prepare_ligands.sh
#   sites.csv                   protein,center_x,center_y,center_z  (active-site centres you defined)
# Output: results/<protein>_<ligand>.pdbqt and results/docking_scores.csv (top pose per ligand)
set -euo pipefail
mkdir -p results
echo "protein,ligand,affinity_kcal_mol" > results/docking_scores.csv
tail -n +2 sites.csv | while IFS=, read -r P CX CY CZ; do
  for L in ligands/pdbqt/*.pdbqt; do
    N=$(basename "$L" .pdbqt)
    vina --receptor "receptors/$P.pdbqt" --ligand "$L" \
      --center_x "$CX" --center_y "$CY" --center_z "$CZ" \
      --size_x 25 --size_y 25 --size_z 25 \
      --exhaustiveness 32 --num_modes 9 \
      --out "results/${P}_${N}.pdbqt" > "results/${P}_${N}.log"
    SCORE=$(grep -m1 -E '^ +1 ' "results/${P}_${N}.log" | awk '{print $2}')
    echo "$P,$N,$SCORE" >> results/docking_scores.csv
  done
done
