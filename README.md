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



