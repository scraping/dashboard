#/bin/bash

# cronjob to pull the list of users from the database and store it into a CSV file accessible via okfn.org's public webserver.
INFILE=dump.members.sql
OUTREPO=gist/latest
OUTFILE=$OUTREPO/members.csv

cd ~/dashboard
# Run the query and overwrite the dump file
mysql <$INFILE >$OUTFILE

# Enter the repo and perform a commit
cd $OUTREPO

if git diff --no-ext-diff --quiet --exit-code; then
  : # no changes
else
  git commit -a -m "Committing lastest database dump." --amend 
  git push origin master -f
fi