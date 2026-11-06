# Genomic and therapeutic characterisation of lytic phages against MDR *Pseudomonas aeruginosa*

Code and analysis settings for my PhD thesis (Biomedical Science, Kisii University). The work covers sequencing and annotation of five lytic phages, in silico characterisation of their lytic proteins, in vitro three-phage cocktail design on the Omnilog platform, biofilm disruption across eight clinical isolates, and efficacy testing in the *Galleria mellonella* model.

Published work: [Microbiology Resource Announcements 2025, DOI] and [Microbiology Spectrum 2026, DOI].

## Data

Phage genomes are in GenBank:

| Phage | Accession |
|---|---|
| vB_PaePA01phi1_RS1 | PV565004 |
| vB_PaePA10145phi1_RS1 | PV565005 |
| vB_PA8132phi1_PS3 | PV565006 |
| vB_PA10145phi1_HR2 | PV565007 |
| vB_PA10145phi1_MKR2 | PV565008 |

Raw reads: [SRA / BioProject accession]. Reads are not stored in this repository.

## Folders

| Folder | Thesis sections | Contents |
|---|---|---|
| `01_reads_to_assembly` | 3.6, 3.7.2 | QC, trimming, assembly, assembly checks, termini |
| `02_annotation` | 3.7.1, 3.11.1 | Pharokka annotation, Abricate screening |
| `03_comparative_genomics` | 3.8 | Clinker; VIRIDIC and ViPTree settings |
| `04_lytic_proteins` | 3.9 | Web-server settings, PyMOL alignment, Vina docking |
| `05_cocktail_analysis` | 3.10 | Omnilog AUC, inhibition efficiency, HSA, ANOVA |
| `06_biofilm` | 3.11 | Gene matrix heatmap, biofilm statistics |
| `07_galleria` | 3.12 | Survival and health-score statistics |

## Running it

```
See WORKFLOW.md for the bioconda setup and run order.

mamba env create -f envs/phage-genomics.yml
mamba env create -f envs/phage-protein.yml
mamba env create -f envs/phage-r.yml
```

Run folders in numeric order. Each folder has its own README with inputs, outputs and the exact commands.

## Web-server steps

Several steps were run on web servers and have no code. Each is recorded in the relevant folder's `settings.md` with the server, date accessed and parameters.

## Citation

Please cite the thesis and the papers above. A Zenodo DOI will be added once the repository is archived.
