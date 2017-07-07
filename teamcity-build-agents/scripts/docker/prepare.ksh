rm -fr build-deploy-scripts > /dev/null 2>&1
git clone git@github.com:uvalib/build-deploy-scripts.git
chmod g-r build-deploy-scripts/keys/dev_deploy
chmod o-r build-deploy-scripts/keys/dev_deploy
chmod g-r build-deploy-scripts/keys/teamcity_deploy
chmod o-r build-deploy-scripts/keys/teamcity_deploy
