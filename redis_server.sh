#!/bin/sh
# Simple Redis script conceived to work on Linux systems
# Version:1.0.1

set +x
usage ()
{ echo " $0 port action
 eg:$0 6379 start|stop|restart|status " 
}

if [ $# != 2 ];then usage;exit 1;
fi

REDISPORT=$1
REDISACTION=$2
REDISPATH=/redis/$REDISPORT
EXEC=/usr/local/bin/redis-server
CLIEXEC=/usr/local/bin/redis-cli
PIDFILE=$REDISPATH/$REDISPORT.pid
CONF=$REDISPATH/redis.conf

start()
{ if [ -f $PIDFILE ] 
  then 
     	echo "$PIDFILE exists,redis $REDISPORT ia already running,"
        exit 0
  else
	echo "Starting Redis server...."
  	$EXEC $CONF
  fi;
}

stop()
{ if [ ! -f $PIDFILE ]
  then
	echo "$PIDFILE does not exists,$REDISPORT is is not running" 
        exit 1;
  else
        PID=$(cat $PIDFILE)
	echo "$REDISPORT Stopping..."
 	$CLIEXEC -p $REDISPORT shutdown
        while  [ -x /proc/${PID} ]
        do
  	    echo "Waitting for Redis $REDISPORT to shutdown..."
        done
            echo "Redis $REDISPORT stopped"
   fi
}

restart()
{
	stop
 	start
}

status()
{  if [ -f $PIDFILE ]
      then  
	version=$($CLIEXEC -p $REDISPORT -v)
    	echo "Redis $REDISPORT is runing ,Redis version: $version"
   else 
    	echo "Redis $REDISPORT is stopped"
   fi 
}

case "$2" in 
 start)
      start
      	;; 
 stop)
      stop
	;;
 status)
      status
	;;
 restart)
       restart
	;;
   *)
    echo "Redis action is wrong,please input stop|start|restart|status" 
    exit 1
esac

