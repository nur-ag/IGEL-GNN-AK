# IGEL: Beyond 1-WL with Local Ego-Network Encodings

Based on the Official code for [**GNN-As-Kernel**](https://github.com/LingxiaoShawn/GNNAsKernel) for evaluation consistency. 

We introduce IGEL encodings on GNN-AK.

This code is sufficient to reproduce all the results reported in our paper. Using our configurations 
and scripts, you may also reproduce results from the original GNN-AK.

## Setup

This section follows the installation guide for GNN-As-Kernel, as we do not introduce new dependencies for consistency.

```
# environment name
export ENV=igel-gnnak

# create env 
conda create --name $ENV python=3.10 -y
conda activate $ENV

# install pytorch 
conda install pytorch==1.12.1 torchvision==0.13.1 torchaudio==0.12.1 cudatoolkit=11.3 -c pytorch -y

# install pyg
conda install pyg -c pyg -y

# install ogb 
pip install ogb -y

# install rdkit
conda install -c conda-forge rdkit -y

# update yacs and tensorboard
pip install yacs==0.1.8 --force  # PyG currently use 0.1.6 which doesn't support None argument. 
pip install tensorboard
pip install matplotlib

# install jupyter and ipython 
conda install -c conda-forge nb_conda -y

# clone the IGEL dependency
git clone git@github.com:nur-ag/IGEL.git ../IGEL

# install igraph for IGEL and missing networkx
conda install -c conda-forge python-igraph -y
pip install networkx dill

# install torch-scatter, torch-cluster and torch-sparse
# note: this is hard to automate, and requires finding the appropriate version for your system
# using conda makes it easier, but your mileage may vary
conda install pytorch-scatter -c pyg -y
conda install pytorch-sparse -c pyg -y
conda install pytorch-cluster -c pyg -y
```

Note that we provide a `setup.sh` for convenience. However, we recommend that this script be executed manually line by line to ensure that each installation step executes correctly.

## Code structure

We introduce IGEL in the GNN-AK codebase. See:
* `core/igel_utils.py` — contains the implementation of IGEL.
  * The IGEL repository is required and pulled by the setup script.

## Hyperparameters

See ``core/config.py`` for all the extended IGEL options.

## Reproducibility

We provide a bash script to reproduce the results of the benchmark. 
See: `benchmarkDatasets.sh`.
