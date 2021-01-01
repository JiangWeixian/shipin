# main script
# install scripts list in cron

# set crontab editor
export EDITOR=vim

# save current crontab
crontab -l > exitedcron

# get current scripts path 
SCRIPT_EXE_PATH=${PWD}
BASEDIR=$(dirname $0)

echo "0 11 * * * sh $PWD/$BASEDIR/greet.sh" >> exitedcron
echo "0 21 * * * sh $PWD/$BASEDIR/offwork.sh" >> exitedcron
echo "* * * * * sh $PWD/$BASEDIR/drinkwater.sh" >> exitedcron

# uniq cron
sort exitedcron | uniq > uniqcron

# save new cron
crontab uniqcron
rm exitedcron
rm uniqcron

# check crontab
crontab -l
