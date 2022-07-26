#!/bin/sh
#generate tag file for lookupfile plugin
echo -e "!_TAG_FILE_SORTED\t2\t/2=foldcase/" > filenametags
#find . -not -regex '.*\.\(png\|gif\)' -type f -printf "%f\t%p\t1\n" | sort -f >> filenametags 
find `pwd` \
	-regex '.*\(\.c\|\.h\|\.C\|\.H\|\.S\|\.s\|\.asm\|\.ASM\|\.go\|\.cpp\|\.CPP\|\.txt\|\.rst\|\.dts\|\.dtsi\|\.sh\|Makefile\|\.defconfig\)' \
	-type f -printf "%f\t%p\t1\n" \
	| sort -f >> filenametags
