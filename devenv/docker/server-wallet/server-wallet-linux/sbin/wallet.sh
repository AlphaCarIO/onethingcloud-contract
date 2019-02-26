#!/bin/bash

proc_list='server-wallet'

base_dir=`dirname $0`
cd $base_dir
SCRIPTPATH="$( pwd -P )"

proc_bin_path=$SCRIPTPATH'/../bin'
proc_log_path=$SCRIPTPATH'/../log'

help(){
    echo "help:"
    echo "bin path:" $proc_bin_path
    echo "log path:" $proc_log_path
    echo ""
    echo "usage: ./wallet.sh cmd"
    echo "cmd: start | stop | restart | check"
    echo "eg: ./wallet.sh start"
    echo ""
}
start(){
    echo "start"
    for proc in $proc_list ;do
        arrm=$(ps -ef | grep "`echo $proc_bin_path/$proc`" | grep -v 'grep' |grep -v $0 | wc -l)
        if [ ${arrm:-0} = 0 ];then
            echo $proc_bin_path

            cd $proc_bin_path
            nohup $proc_bin_path/$proc -p passwd.json 2>&1 >> $proc_log_path/panic-$proc.log &
            echo  `date "+%Y-%m-%d %H:%M:%S> "` "$proc 进程已经重启"
        else
            echo `date "+%Y-%m-%d %H:%M:%S> "` "$proc 进程已经存在"
        fi
    done
}
stop(){
    echo "stop"
    for proc in $proc_list ;do
        arrproc=$(ps -ef | grep "`echo $proc_bin_path/$proc`" | grep -v 'grep' |grep -v $0 | awk '{print $2}')
        for p in $arrproc; do
            kill $p;
            echo `date "+%Y-%m-%d %H:%M:%S> "` $p " 进程已杀死！"
        done
    done
    echo `date "+%Y-%m-%d %H:%M:%S> "` "服务已停止！"
}
restart(){
    echo "restart"
    stop
    sleep 1
    start
}
check(){
    echo "check"
    for proc in $proc_list ;do
        arrspar=$(ps -ef | grep "`echo $proc_bin_path/$proc`" | grep -v 'grep' |grep -v $0)
        echo `date "+%Y-%m-%d %H:%M:%S> "`"目前运行的服务监控进程($proc)：" ${arrspar:-"无"}
    done
}

if [ $# -eq 0 ]; then
    help
    exit
fi

while true;do
    case $1 in
        help)
            help
            break
            ;;
        start)
            start
            break
            ;;
        stop)
            stop
            break
            ;;
        restart)
            restart
            break
            ;;
        check)
            check
            break
            ;;
        *)
            help
            break
            ;;
    esac
    shift
done
