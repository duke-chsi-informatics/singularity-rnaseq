BootStrap: library
From: granek/default/singularity-rstudio-base:3.6.1

%labels
    Maintainer Josh Granek
    Image_Name rnaseq
    Image_Version rnaseq_0002

%post
  # Install extra stuff
  export DEBIAN_FRONTEND=noninteractive
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
    htop \
    jupyter-notebook 
   apt-get clean
   rm -rf /var/lib/apt/lists/*

   #--------------------------------------------------------------------------------
   Rscript -e "install.packages(pkgs = c('argparse','R.utils','fs','here','foreach'), repos='https://cran.revolutionanalytics.com/', dependencies=TRUE, clean = TRUE)"

   Rscript -e "if (!requireNamespace('BiocManager')){install.packages('BiocManager')}; BiocManager::install(); BiocManager::install(c('ggbio','GenomicRanges','rtracklayer', 'DESeq2', 'Gviz'))"
   #--------------------------------------------------------------------------------
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

%apprun rscript
  exec Rscript "${@}"

%apprun jupyter
  export JUPYTER_RUNTIME_DIR="$HOME/.local/share/jupyter/runtime"
  mkdir -p $JUPYTER_RUNTIME_DIR
  jupyter notebook
