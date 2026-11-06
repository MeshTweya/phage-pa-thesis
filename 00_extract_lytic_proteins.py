"""Pull lytic-protein candidates out of the Pharokka GenBank files (thesis 3.9.1).
Candidates = endolysins / peptidoglycan hydrolases, holins, spanins, lytic transglycosylases,
picked by keyword from the annotation. This only builds the candidate list. The thesis then
prioritised proteins by catalytic domain, predicted activity and standalone potential, which
is a manual step (use InterProScan / CD-Search results).

Usage: python 00_extract_lytic_proteins.py ../03_comparative_genomics/genbank results
Output: results/lytic_candidates.faa and results/lytic_candidates.tsv
"""
import sys, os, glob
from Bio import SeqIO

KEYWORDS = ["endolysin", "lysozyme", "lysin", "holin", "spanin", "transglycosylase",
            "muramidase", "peptidoglycan", "amidase", "glycoside hydrolase", "lytic"]

gbk_dir, out_dir = sys.argv[1], sys.argv[2]
os.makedirs(out_dir, exist_ok=True)
recs, rows = [], []
for gbk in sorted(glob.glob(os.path.join(gbk_dir, "*.gbk"))):
    phage = os.path.splitext(os.path.basename(gbk))[0]
    for rec in SeqIO.parse(gbk, "genbank"):
        for f in rec.features:
            if f.type != "CDS":
                continue
            q = f.qualifiers
            text = " ".join(q.get("product", []) + q.get("function", [])).lower()
            if any(k in text for k in KEYWORDS) and "translation" in q:
                tag = q.get("locus_tag", ["NA"])[0]
                product = q.get("product", ["NA"])[0]
                seq = q["translation"][0]
                recs.append(f">{phage}|{tag}|{product.replace(' ', '_')}\n{seq}\n")
                rows.append((phage, tag, product, len(seq)))

with open(os.path.join(out_dir, "lytic_candidates.faa"), "w") as fh:
    fh.writelines(recs)
with open(os.path.join(out_dir, "lytic_candidates.tsv"), "w") as fh:
    fh.write("phage\tlocus_tag\tproduct\tlength_aa\n")
    for r in rows:
        fh.write("\t".join(map(str, r)) + "\n")
print(f"{len(rows)} candidate proteins written to {out_dir}")
