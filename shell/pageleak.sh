#!/bin/sh

if [ -z $1 ] ;then
	MEMINFO=/proc/meminfo
else
	MEMINFO=$1 
fi

#—e是模式的意思，常用来保护以破折号开头的模式
#-w是全字匹配
#-i忽略大小写
#—d指定分割符，—f为按照分割符取出的域，2—指的是域2及以后

#Buffers=`grep -we 'Buffers' $MEMINFO | cut- d' ' -f2- | tr -d "[A-Z][a-z] \r"`
#Cached='grep -we 'Cached' $MEMINFO | cut -d' ' -f2- | tr -d "[A-Z][a-z] \r"`

MemFree=`grep -ie 'MemFree' $MEMINFO | cut -d' ' -f2- | tr -d "[A-Z][a-z] \r"`
MemTotal=`grep -ie 'MemTotal' $MEMINFO | cut -d' ' -f2- | tr -d "[A-Z][a-z] \r"`
ActiveAnon=`grep -e 'Active(anon)' $MEMINFO | cut -d' ' -f2- | tr -d "[A-Z][a-z] \r"`
InactiveAnon=`grep -e 'Inactive(anon)' $MEMINFO | cut -d' ' -f2- | tr -d "[A-Z][a-z] \r"`
ActiveFile=`grep -e 'Active(file)' $MEMINFO | cut -d' ' -f2- | tr -d "[A-Z][a-z] \r"`
InactiveFile=`grep -e 'Inactive(file)' $MEMINFO | cut -d' ' -f2- | tr -d "[A-Z][a-z] \r"`
Slab=`grep -ie 'Slab' $MEMINFO | cut -d' ' -f2- | tr -d "[A-Z][a-z] \r"`
KernelStack=`grep -ie 'KernelStack' $MEMINFO | cut -d' ' -f2- | tr -d "[A-Z][a-z] \r"`
PageTables=`grep -ie 'PageTables' $MEMINFO | cut -d' ' -f2- | tr -d "[A-Z][a-z] \r"`

if [ -z $PageTables ] ;then
	PageTables=0
fi

VmallocUsed=`grep -ie 'VmallocUsed' $MEMINFO | cut -d' ' -f2- | tr -d "[A-Z][a-z] \r"`
Percpu=`grep -ie 'Percpu' $MEMINFO | cut -d' ' -f2- | tr -d "[A-Z][a-z] \r"`

if [ -z $Percpu ] ;then
	Percpu=0
fi

Memused="$(($ActiveAnon + $InactiveAnon + $ActiveFile + $InactiveFile + $Slab + $KernelStack + $PageTables))"
MemLeak="$(( $MemTotal - $MemFree - $Memused ))"
MEMLEAK="$(($MemLeak / 1024))"
MEMFREE="$(($MemFree / 1024))"
MEMTOTAL="$(($MemTotal / 1024))"
MEMUSED="$(($Memused / 1024))"

# display the information
echo
echo "Memory Analyse:"
echo "Used:$MEMUSED MB/$Memused KB"
echo "Free:$MEMFREE MB/$MemFree KB"
echo "Total:$MEMTOTAL MB / $MemTotal KB"
echo "Leak:$MEMLEAK MB/$MemLeak KB"
echo 
