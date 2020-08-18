# singularity-rnaseq

## Running Jupyter
Run this to start Jupyter:
```
singularity run --app jupyter library://granek/duke-chsi-informatics/singularity-rstudio:latest
```

Then follow the instructions that Jupyter printed to the terminal when you started it up to access Jupyter in your web browser


### Accessing Jupyter on a remote server
If you are running the container on a remote server, you will need to set up port forwarding with ssh to be able to access Jupyter.  Run this command to forward the default Jupyter port (8888)

```
ssh -L 8888:localhost:8888 bug
```
> Note if the default Jupyter port is not available, Jupyter will choose a different port.  In this case you will need to substitute the port that Jupyter outputs for 8888 in the ssh port forwarding command above.

## Running on a SLURM Cluster

You can use this image interactively on a SLURM-managed cluster by running launching RStudio or Jupyter. The following instructions work on the Duke Compute Cluster (DCC).  Doing this on other cluster will require some modification and may not work, depending on how the cluster is configured.

### RStudio

1.  ssh to DCC login node: `ssh NETID@dcc-slogin-01.oit.duke.edu`
2.  run tmux on login node: `tmux new -s container_demo`
3.  Run this on login node: `srun -A chsi -p chsi --mem=100G -c 30 --pty bash -i`
4.  Run `hostname -A` on compute node and record results
5.  Run on the following on a compute node and note the port, username, and password that the command prints:

```
mkdir -p /scratch/josh/rnaseq_demo/rawdata /scratch/josh/rnaseq_demo/workspace

singularity run \
	--bind /scratch/josh/rnaseq_demo/rawdata:/data \
	--bind /scratch/josh/rnaseq_demo/workspace:/workspace \
	library://granek/duke-chsi-informatics/singularity-rnaseq
```

6.  Run on local machine: `ssh -L PORT:COMPUTE_HOSTNAME:PORT NETID@dcc-slogin-01.oit.duke.edu`
    -   Where PORT is the port returned but the "singularity run" commmand
    -   Where COMPUTE_HOSTNAME is the hostname returned by running "hostname -A" on the compute node
    -   Where NETID is your NetID
7.  Go to "localhost:PORT" in a webrowser and enter the username and password printed by the "singularity run" commmand
8.  Have fun!!
9. At the end of an analysis you will probably want to copy results to your directory in `/work` or `/hpc/group`

### Jupyter

1.  ssh to dcc-slogin-01.oit.duke.edu
2.  run tmux on login node: `tmux new -s container_demo`
3.  Run this on login node: `srun -A chsi -p chsi --mem=100G -c 30 --pty bash -i`
5.  Run on compute node:

```
mkdir -p /scratch/josh/rnaseq_demo/rawdata /scratch/josh/rnaseq_demo/workspace

singularity run \
	--app jupyter \
	--bind /scratch/josh/rnaseq_demo/rawdata:/data \
	--bind /scratch/josh/rnaseq_demo/workspace:/workspace \
	library://granek/duke-chsi-informatics/singularity-rnaseq
```
	
6.  Run on local machine: `ssh -L PORT:COMPUTE_HOSTNAME:PORT NETID@dcc-slogin-01.oit.duke.edu`
    -   Where PORT is the number after `http://127.0.0.1:` in the URL given by Jupyter (defaults to 8888, but Jupyter will use a different one if the default is in use, or if a different port is supplied as an argument using `--port` when running the singularity container
    -   Where COMPUTE_HOSTNAME is the hostname returned by running "hostname -A" on the compute node
    -   Where NETID is your NetID
7.  Copy the URL supplied by jupyter that starts `http://127.0.0.1:` and paste it in a webbrowser
8.  Have fun!!
9. At the end of an analysis you will probably want to copy results to your directory in `/work` or `/hpc/group`

### Jupyter on GPU node

Same as above, but the srun command should use the `chsi-gpu` partition and request a gpu, but less CPUs and Memory:

`srun -A chsi -p chsi-gpu --gres=gpu:1 --mem=15866 -c 2 --pty bash -i`


