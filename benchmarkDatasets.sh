# Execute all experiments on benchmark datasets
echo "[$(date '+%Y-%m-%d %H:%M')] Running ZINC."
./runIGELExperiment.sh GINEConv zinc 32000 "0 1 2" "0 -1"

echo "[$(date '+%Y-%m-%d %H:%M')] Running PATTERN."
./runIGELExperiment.sh GINEConv pattern 400 "0 1 2" "0"
