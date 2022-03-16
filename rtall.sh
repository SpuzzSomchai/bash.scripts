rm ../builds.log;
echo "BUILDING DOCS" > ../builds.log;

REPOS=("arm.docs.devserv.me" "backup.docs.devserv.me" "bash.docs.devserv.me" "dev.docs.devserv.me" "docs.devserv.me" "heepp.docs.devserv.me" "notes.devserv.me" "server.docs.devserv.me" "setup.docs.devserv.me" "tips.docs.devserv.me" "tools.docs.devserv.me")

for REPO in ${REPOS[@]}; do
  echo "$REPO START" >> ../builds.log;
  cd $REPO
  echo "$REPO BUILD" >> ../builds.log;
  rt >> ../builds.log
  echo "$REPO git add changes";
  git add . >> ../builds.log;
  echo "$REPO git commit" >> ../builds.log;
  git commit -m "Update docs" >> ../builds.log;
  echo "$REPO git push"  >> ../builds.log;
  git push >> ../builds.log;
  echo "$REPO END" >> ../builds.log;
  cd ..
done