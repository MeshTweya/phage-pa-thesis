#!/usr/bin/env bash
# Thesis 3.9.8: ligand preparation. Five peptidoglycan ligands from PubChem
# (NAG, NAM, NAG-NAM, NAM-L-Ala, NAM-L-Ala-D-isoGln), minimised with Open Babel v3.1.1,
# converted to PDBQT with AutoDock Tools.
# Put the PubChem SDF files in ligands/raw/ (e.g. NAG.sdf).
set -euo pipefail
mkdir -p ligands/min ligands/pdbqt
for f in ligands/raw/*.sdf; do
  n=$(basename "$f" .sdf)
  obabel "$f" -O "ligands/min/$n.pdb" --minimize --ff MMFF94 --steps 1000
  # prepare_ligand4.py comes with AutoDock Tools (MGLTools)
  prepare_ligand4.py -l "ligands/min/$n.pdb" -o "ligands/pdbqt/$n.pdbqt"
done
