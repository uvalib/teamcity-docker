rm -fr build-deploy-scripts > /dev/null 2>&1
git clone git@gitlab.com:uvalib/build-deploy-scripts.git
chmod 600 build-deploy-scripts/keys/dev_deploy
chmod 600 build-deploy-scripts/keys/teamcity_deploy
chmod 600 build-deploy-scripts/keys/bamboo_deploy
