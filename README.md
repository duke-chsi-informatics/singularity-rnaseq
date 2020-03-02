# singularity-rnaseq

## Running Jupyter
Run the following to start Jupyter:
```
singularity shell library://dylanyang/default/adjuvant_singularity_image:latest

jupyter notebook
```
Replace 'latest' with the latest version of image

## Running Rstudio
Run this to start Rstudio:
```
singularity exec library://dylanyang/default/adjuvant_singularity_image:latest /usr/local/bin/run_singularity_rstudio.sh
```
Replace 'latest' with the latest version of image

## Directories Bind-mounting
Shell in the container with directories bind-mounting
```
singularity shell --bind /absolute_local_path1:/absolute_container_path1,/absolute_local_path2:/absolute_container_path2 library://dylanyang/default/adjuvant_singularity_image:latest
```
Replace 'latest' with the latest version of image


Then follow the instructions that Jupyter printed to the terminal when you started it up to access Jupyter in your web browser


### Accessing Jupyter on a remote server
If you are running the container on a remote server, you will need to set up port forwarding with ssh to be able to access Jupyter.  Run this command to forward the default Jupyter port (8888)

```
ssh -L 8888:localhost:8888 bug
```
> Note if the default Jupyter port is not available, Jupyter will choose a different port.  In this case you will need to substitute the port that Jupyter outputs for 8888 in the ssh port forwarding command above.



