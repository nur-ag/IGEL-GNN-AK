GNN_TYPE=${1:-GINEConv}

# PROBLEM should be out of "zinc"
PROBLEM=${2:-zinc}

# MAX_MEMORY is the memory threshold after which this script sleeps before submitting new jobs
MAX_MEMORY=${3:-30000}

# IGEL_DISTANCES is a list of encoding distances that we will check through
IGEL_DISTANCES=${4:-0 1 2}

# MINI_SETUPS are the mini-layer configurations for GNN-AK, where -1 just uses the default
MINI_SETUPS=${5:-0 -1}

# EXTRA_PARAMS is a list of extra parameters to append to all jobs
EXTRA_PARAMS=${6:-igel.use_edge_encodings True}

# DELAY_BETWEEN_JOB_RUNS is the time in seconds to wait until a successful submission (where the job appears in nvidia-smi)
DELAY_BETWEEN_JOB_RUNS=${7:-120}

# Define the number of 'classic' GNN layers used in the GNN-AK paper
# We will run each experiment with the original configuration, and with half.
declare -A PROBLEM_LAYERS
PROBLEM_LAYERS["zinc"]="6"
PROBLEM_LAYERS["pattern"]="6"

# We run a version of the problem with half of the layers
PROBLEM_KEY=$(echo $PROBLEM | cut -d" " -f1)
GNN_AK_LAYERS=${PROBLEM_LAYERS["$PROBLEM_KEY"]}

for IGEL_DISTANCE in $IGEL_DISTANCES
do
  for MINI_LAYERS in $MINI_SETUPS
  do
    MINI_LAYER_CFG="model.mini_layers $MINI_LAYERS"
    if [ $MINI_LAYERS -lt 0 ]; then
      MINI_LAYER_CFG=""
    fi

    JOB_COMMAND="python -m train.${PROBLEM} model.num_layers ${GNN_AK_LAYERS} model.gnn_type ${GNN_TYPE} igel.distance $IGEL_DISTANCE igel.use_relative_degrees False $MINI_LAYER_CFG"
    ./runCommandOnGPUMemThreshold.sh "${JOB_COMMAND} ${EXTRA_PARAMS}" ${MAX_MEMORY}

    # Sleep after submitting the job to wait until memory gets allocated
    echo "[$(date '+%Y-%m-%d %H:%M')] Sleeping for ${DELAY_BETWEEN_JOB_RUNS} seconds after submission."
    sleep ${DELAY_BETWEEN_JOB_RUNS}
  done
done
