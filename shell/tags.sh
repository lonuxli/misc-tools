#!/bin/sh

set -x

ctags -R 

find `pwd` -name '*.h' -o -name '*.c' -o -name '*.s' -o -name '*.S' -o -name '*.cpp' -o -name '*.go'> cscope.files
cscope -bkq -i cscope.files

#generate tag file for lookupfile plugin
echo -e "!_TAG_FILE_SORTED\t2\t/2=foldcase/" > filenametags
#find . -not -regex '.*\.\(png\|gif\)' -type f -printf "%f\t%p\t1\n" | sort -f >> filenametags 
find `pwd` \
	-regex '.*\(\.c\|\.h\|\.C\|\.H\|\.S\|\.s\|\.asm\|\.ASM\|\.go\|\.cpp\|\.CPP\|\.dts\.dtsi\|\.sh\|\.txt\|\.rst\|Makefile\|\.defconfig\)' \
	-type f -printf "%f\t%p\t1\n" \
	| sort -f >> filenametags
