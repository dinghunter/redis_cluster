#!/bin/bash
#Init Redis env,copy redis conf to datadir and modify conf file
#Version:1.0.1
 usage ()
 { echo "usage:$0 port
  eg:$0 10000" 
 }

if [ $# != 1 ];then 
usage;exit 1
fi;

if [ -s /etc/redis.conf ];then echo "redis.conf is ok,Continue"
else echo "ERROR:redis.conf is not ok,exit" 
exit 1;
fi
 
REDISPORT=$1
REDISPATH=/redis/$REDISPORT
if [ -d $REDISPATH ];
 then echo "ERROR:$REDISPATH is exists , $0 exit";
exit 1
else
  mkdir -p  $REDISPATH && cp /etc/redis.conf $REDISPATH  && sed -i "s/6379/$REDISPORT/g" $REDISPATH/redis.conf;
  echo "Redis $REDISPORT is init ok"
fi

