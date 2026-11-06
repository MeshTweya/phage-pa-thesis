# Workflow: reads to genomes to proteins

```
raw reads (R1/R2)
  -> FastQC                          01_reads_to_assembly/01_qc_and_trim.sh
  -> BBDuk trimming, FastQC again    01_reads_to_assembly/01_qc_and_trim.sh
  -> SPAdes --metaviral              01_reads_to_assembly/02_assemble.sh
  -> pick phage contig               01_reads_to_assembly/02b_pick_contig.sh   (check in Bandage)
  -> QUAST, Bowtie2, SAMtools, CheckV  01_reads_to_assembly/03_assembly_qc.sh
  -> PhageTerm (termini)             01_reads_to_assembly/04_phageterm.sh
  -> Pharokka annotation             02_annotation/01_pharokka.sh
  -> Abricate (isolate genomes)      02_annotation/02_abricate_screen.sh
  -> Clinker synteny                 03_comparative_genomics/01_clinker.sh
  -> VIRIDIC, ViPTree + iTOL         web servers; record in 03_comparative_genomics/settings.md
  -> lytic protein candidates        04_lytic_proteins/00_extract_lytic_proteins.py
  -> ProtParam, epitope, allergenicity, PSIPRED, AlphaFold3, InterProScan   web servers; settings.md
  -> PyMOL superposition             04_lytic_proteins/01_pymol_superposition.py
  -> Vina docking                    04_lytic_proteins/02_prepare_ligands.sh, 03_dock.sh
```

## Set up with bioconda

```
conda config --add channels conda-forge
conda config --add channels bioconda
conda config --set channel_priority strict

mamba env create -f envs/phage-genomics.yml
mamba env create -f envs/phage-protein.yml
mamba env create -f envs/phage-r.yml
```

Databases (one-off):

```
checkv download_database ./checkv_db        # then: export CHECKV_DB=$(pwd)/checkv_db/<db_folder>
install_databases.py -o ./pharokka_db       # then: export PHAROKKA_DB=$(pwd)/pharokka_db
```

## Run

```
conda activate phage-genomics
bash run_genomics.sh
```

Phylogeny in the thesis (VIRIDIC, ViPTree) and most protein predictions ran on web servers, so those steps are manual and recorded in the `settings.md` files.
