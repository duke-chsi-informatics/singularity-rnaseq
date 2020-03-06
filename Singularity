BootStrap: library
From: granek/default/singularity-rstudio-base:3.6.1

%labels
    Maintainer Hang(Dylan) Yang	
    Image_Name RNASeq
    Image_Version RNASeq_03

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
    # pandoc is installed to support embedding of images generated from the R package plotly
   apt-get install -y pandoc
   apt-get clean
   rm -rf /var/lib/apt/lists/*


   #--------------------------------------------------------------------------------
   pip3 install notebook
   pip3 install bash_kernel
   python3 -m bash_kernel.install
   #--------------------------------------------------------------------------------
   Rscript -e "install.packages(c('IRkernel','repr', 'IRdisplay', 'pbdZMQ', 'devtools'), repos = 'https://cloud.r-project.org/')"
   Rscript -e "IRkernel::installspec(user = FALSE)"

   Rscript -e "install.packages(pkgs = c('argparse','R.utils','fs','here','foreach'), repos='https://cran.revolutionanalytics.com/', dependencies=TRUE, clean = TRUE)"
   Rscript -e "if (!requireNamespace('BiocManager')){install.packages('BiocManager')}; BiocManager::install(); BiocManager::install(c('ggbio','GenomicRanges','rtracklayer', 'DESeq2', 'Gviz'))"
   #-------------------------------------------------------------------------------
   # Visualization packages for 3D TSNE plot, Venn Diagram and heat map 
   Rscript -e "install.packages(pkgs=c('Rtsne','plotly','pheatmap'), repos ='https://cran.revolutionanalytics.com/', dependencies=TRUE, clean=TRUE)"
   Rscript -e "if (!requireNamespace('BiocManager')){install.packages('BiocManager')}; BiocManager::install(); BiocManager::install('limma')"

   # Pathway Analysis Toolkit
   Rscript -e "if (!requireNamespace('BiocManager')){install.packages('BiocManager')}; BiocManager::install(); BiocManager::install(c('gage','gageData','pathview'))"
    
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
