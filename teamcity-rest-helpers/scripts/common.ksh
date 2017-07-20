#
# Prechecks before running team city scripts
#

#
# check the supplied error code and exist with an appropriate message if non-zero
#
function exit_on_error {
   local RES=$1
   if [ $RES -ne 0 ]; then
      echo "Terminating with error $RES"
      exit $RES
   fi
   return
}

if [ -z "$TEAMCITY_API" ]; then
   echo "ERROR: no TEAMCITY_API defined, aborting"
   exit 1
fi 

if [ -z "$TEAMCITY_PROJECT" ]; then
   echo "ERROR: no TEAMCITY_PROJECT defined, aborting"
   exit 1
fi 

if [ -z "$TEAMCITY_USER" ]; then
   echo "ERROR: no TEAMCITY_USER defined, aborting"
   exit 1
fi 

if [ -z "$TEAMCITY_PASSWORD" ]; then
   echo "ERROR: no TEAMCITY_PASSWORD defined, aborting"
   exit 1
fi 

export BASIC_AUTH_OPTION="-u $TEAMCITY_USER:$TEAMCITY_PASSWORD"
export ACCEPT_JSON_OPTION="Accept: application/json"

#
# end of file
#
