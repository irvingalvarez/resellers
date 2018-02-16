#! /bin/ksh
#-----------
# . /usr/local/bin/oraenv

#. /home/opersupp/.profile

#export ORACLE_PATH=./:$ORACLE_HOME/bin:$PATH
#export PATH=$PATH:$ORACLE_PATH

. $HOME/.set_oracle_env
#. /home/jd8296/.profile

#export PATH=/tables/bin:/usr/local/bin:${PATH}

export ORACLE_PATH=./:$ORACLE_HOME/bin:$PATH
export PATH=$PATH:$ORACLE_PATH

#export TNS_ADMIN=/tables/tables/cron/bin

export TNS_ADMIN=/usr/local/oracle/.tnstbls

# Oracle Environment Variables (Should be in /etc/profile)
export ORACLE_HOME=/opt/app/oracle/client/11.1.0
#export ORACLE_HOME=/usr/local/oracle/10.2.0
export ORACLE_TERM=$TERM
export TNS_ADMIN="/usr/local/oracle/.tnstbls"
export ORACLE_SID=PMDY25A
#export TNS_ADMIN="/etc"
export ORACLE_PATH=./:$ORACLE_HOME/bin:$PATH
export PATH=$PATH:$ORACLE_PATH

# ************************************************************

for MKT in AUS COR RGV SAN LAR DLS STL TUL ARK OKC MWR WTX HCL PAC WAS SNE ILL GLR NYR BOS ALH MTZ GPL NWS IND NCA PHI MNY NBI FLP TNK GLF GAC
do

   dlcode=`whoami`

   home=`echo /home/$dlcode`

#  typeset -u cuid=$dlcode

   cuid=`echo $dlcode | tr '[:lower:]' '[:upper:]'`

   mktconn=`grep -i "^$MKT," $home/TLG_${cuid}_ConnStrings.lst`

   USER=`echo $mktconn | awk -F"," '{print $2}'`
   PSWD=`echo $mktconn | awk -F"," '{print $3}'`
   INST=`echo $mktconn | awk -F"," '{print $4}'`

   userconn=`echo $USER/$PSWD@$INST`

#sqlplus -s $userconn @/tables/home/RESELLERDEALERS/RESELLERDEALER.sql
sqlplus -s $userconn @RESELLERDEALER.sql


done
