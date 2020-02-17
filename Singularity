BootStrap: library
From: granek/default/singularity-rstudio-base:3.6.1

%labels
    Maintainer Josh Granek
    Image_Name mar1
    Image_Version mar1_0005

%environment
  export PATH=/usr/lib/rstudio-server/bin:${PATH}
  export CONDA_DIR=/opt/conda
  export PATH=$PATH:$CONDA_DIR/bin
  export SHELL=/bin/bash
  export LC_ALL=en_US.UTF-8
  export LANG=en_US.UTF-8
  export LANGUAGE=en_US.UTF-8

%post
  # Install extra stuff
  apt-get update
  apt-get install -y --no-install-recommends \
    curl \
    wget \
    bzip2 \
    parallel \
    bwa \
    samtools \
    ncbi-blast+ \
    mafft \
    git \
    ssh \
    emacs \
    less \
    make \
    libxml2-dev \
    libgsl0-dev \
    libglu1-mesa \
    libmariadb-client-lgpl-dev \
    seqtk \
    rna-star \
    sra-toolkit \
    bcftools \
    htop
   apt-get clean
   rm -rf /var/lib/apt/lists/*

#--------------------------------------------------------------------------------
Rscript -e "install.packages(pkgs = c('argparse','R.utils','fs','here','foreach'), \
    repos='https://cran.revolutionanalytics.com/', \
    dependencies=TRUE, \
    clean = TRUE)"

Rscript -e "if (!requireNamespace('BiocManager')){install.packages('BiocManager')}; \
    BiocManager::install(); \
    BiocManager::install(c('ggbio','GenomicRanges','rtracklayer', 'DESeq2', 'Gviz'))"

##------------------------------------------------------------
# install fastq-mcf and fastq-multx from source since apt-get install causes problems
mkdir -p /usr/bin && \
    cd /tmp && \
	  wget https://github.com/ExpressionAnalysis/ea-utils/archive/1.04.807.tar.gz && \
	  tar -zxf 1.04.807.tar.gz &&  \
    	  cd ea-utils-1.04.807/clipper &&  \
    	  make fastq-mcf fastq-multx &&  \
    	  cp fastq-mcf fastq-multx /usr/bin &&  \
    	  cd /tmp &&  \
    	  rm -rf ea-utils-1.04.807

#--------------------------------------------------------------------------------
pip install DukeDSClient
#--------------------------------------------------------------------------------

mkdir -p /data
mkdir -p /workspace

# Helpful:
#------------------
# https://gitlab.oit.duke.edu/mccahill/jupyter-HTS-2017/blob/master/Dockerfile
# https://github.com/nickjer/singularity-r/blob/master/Singularity.3.4.3
# https://github.com/nickjer/singularity-rstudio/blob/master/Singularity
# https://www.singularity-hub.org/collections/174
# https://www.singularity-hub.org/collections/463

# sudo singularity build canu_rstudio.simg singularity_canu_rstudio

