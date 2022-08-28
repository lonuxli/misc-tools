#!/bin/sh

# 批量page内存泄漏统计脚本, 如日志中混有大量/proc/meminfo信息，可借助该脚本批量统计
# Long Li <lonuxli.64@gmail.com>
# memanlay.sh $1 $2
#  $1: 参数1表示合有meminfo信息的log文件
#  $2: 参数2表示该meminfo的有效行数

#set -x

if [-z $1 ] ;then
	ANALYFILE=meminfos.log
else
	ANALYFILE=$1 
fi

if [-z $2 ] ;then
	SPLITNUM=36
else
	SPLITNUM=$2
fi

FILEPRE=.__meminfo_
INFOOUT=_infosout.txt

grep -r -A SSPLITNUM "MemTotal:" $ANALYFILE > $INFOOUT 
#通过split工具生成meminfo临时隐藏文件
SPLITNUM="$(( $SPLITNUM + 2 ))"
split -l $SPLITNUM $INFOOUT -d -a 6 $FILEPRE

OUTFILE=__leakout.txt

echo > $OUTFILE
for n in {1..999999}
do
	NUM=`printf "%0*d" 6 $n`
	if [ ! -f $FILEPRE$NUM ] ;then
		break
	fi

	echo "---------------------ANALYSE $NUM---------------------" >> $OUTFILE
	./pageleak.sh $FILEPRE$NUM >> $OUTFILE
done

#删除split生成的临时文件
rm $FILEPRE*
