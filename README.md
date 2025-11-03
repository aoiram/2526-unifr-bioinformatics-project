# UNIBE - Bioinformatics project - Group I

Strains : A2c3 E20c1 H35c2 K49c1

## Run any slurm file on the cluster

```bash
sbatch *.slurm
```

Note : `#SBATCH --partition=pcoursea` prevents us of running  anything on the loggin node. Do not remove


## Reference location

```bash
scp -r studentXX@login8.hpc.binf.unibe.ch:/data/users/lfalquet/SBC07107_25/YEAST/reference/ YOUR_FOLDER
```