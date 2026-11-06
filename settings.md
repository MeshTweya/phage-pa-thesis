# Web-server settings (thesis 3.9)

Fill in the date accessed and version for each. Parameters below are from the thesis.

| Step | Tool | URL | Date accessed | Parameters |
|---|---|---|---|---|
| Physicochemical | ExPASy ProtParam | | | FASTA input |
| B-cell epitopes | BepiPred-3.0 (IEDB) | | | threshold 0.1512 |
| MHC I | NetMHCpan-4.1 | | | 9-mers; HLA-A*01:01, A*02:01, A*03:01, B*07:02, B*08:01 |
| MHC II | NetMHCIIpan-4.0 | | | 15-mers; DRB1*01:01, 03:01, 04:01, 07:01, 11:01, 13:01, 15:01 |
| Allergenicity | AllerTOP 2.1 | | | |
| Allergenicity | AllergenFP | | | |
| Allergenicity | AlgPred | | | SVM, amino acid composition |
| Allergenicity | SDAP (BLASTp) | | | FAO/WHO: >35% identity over >80 aa |
| Secondary structure | PSIPRED v4.0 | | | |
| 3D structure | AlphaFold3 Server | | | no templates; rank 1 model by pLDDT and pTM |
| Validation | VADAR | | | Ramachandran, omega, buried charges |
| Domains | InterProScan v5.55-88.0 (web) | | | default, all databases; SignalP 6.0, TMHMM v2.0; CD-Search |
