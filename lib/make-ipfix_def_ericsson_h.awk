#!/usr/bin/awk -f

BEGIN {
	FS = ","
	i=0
	print "/*\n * ERICSSON IPFIX defines\n *\n * This is a generated file. Do not edit! \n *\n * The real ERICSSON ENO is 2352. However, there is no ENO in NFV9 packet data format, hence using 0 \n *\n */\n#ifndef IPFIX_ERICSSON_DEF_H\n#define IPFIX_ERICSSON_DEF_H\n\n#define IPFIX_ENO_ERICSSON\t0\n\n"
}


NF==0 { next }
/#/   { next }


match ($0, /\/\/|\*|\/\*/) {
	split($0, aux, substr($0, RSTART, RLENGTH))
	print substr($0, RSTART, RLENGTH)" "aux[2] }

/\*\// {
	print "*/"
}


NF==6 {
	print "#define "$2" \t "$1

	gsub("_FT_", "_CN_")
	var[i]="#define "$2" \t "$5
	i++
}

END {
	printf "\n/*\n * column name definitions\n */"
	while(i > 0) {
		print var[i]
		i--
	}
	print "\n#endif\n"
}
