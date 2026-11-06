"""Thesis 3.9.6.3: superpose AlphaFold3 models onto PDB homologues and report RMSD.
Run with:  pymol -cq 01_pymol_superposition.py
Input: pairs.csv with columns protein,model_file,reference_file (local files you downloaded).
Output: results/superposition_rmsd.csv
The thesis treats RMSD < 2.0 A over aligned C-alpha atoms as high similarity.
"""
import csv, os
from pymol import cmd

os.makedirs("results", exist_ok=True)
rows = []
with open("pairs.csv") as fh:
    for r in csv.DictReader(fh):
        cmd.reset()
        cmd.delete("all")
        cmd.load(r["model_file"], "model")
        cmd.load(r["reference_file"], "ref")
        # align returns (RMSD after refinement, aligned atoms, cycles, RMSD before, atoms before, score, residues)
        res = cmd.align("model and name CA", "ref and name CA")
        rows.append({"protein": r["protein"], "rmsd_A": round(res[0], 3), "aligned_atoms": res[1]})
        cmd.save(f"results/{r['protein']}_superposed.pse")

with open("results/superposition_rmsd.csv", "w", newline="") as out:
    w = csv.DictWriter(out, fieldnames=["protein", "rmsd_A", "aligned_atoms"])
    w.writeheader(); w.writerows(rows)
