DIR=$(dirname $0)

# set the definitions
AGENT_COUNT=5

for agent in $(seq $AGENT_COUNT) ; do
   ./$DIR/start-agent.ksh $agent
done
