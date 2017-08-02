#!/bin/bash

file="./cscope.paths"
keep=false
paths=""

usage()
{
    echo "Usage of cscope_build.sh";
    echo "cscope_build.sh [-f <file>] [-k]";
    echo "  -f  file which contains paths for build tags";
    echo "  -k  keep tags up to date (update every 5 minute)";
    echo "  -h  print help message"
}

build()
{
    echo -n "" > ./cscope.files
    for path in $paths
    do
        if [[ $path == "#"* ]] 
        then
            echo "Skipping path: $path"
        else
            echo "start build search dir list in $path"
            find $path -name \*.h -print -o -name \*.cpp -print -o -name \*.c -print -o -name \*.cxx -print -o -name \*.hpp -print -o -name \*.hxx -print >> ./cscope.files;
        fi
    done
    echo "start build DB"
	cscope -RUbq 2>/dev/null;
    echo "finished"
}

#######################################################################################################
## Main
#######################################################################################################

while [ $# -gt 0 ]
do
    case "$1" in
    "-f") file=$2; shift 2 ;;
    "-k") keep=true; shift ;;
    "-h") usage; exit 0 ;;
    *) usage; exit 1 ;;
    esac
done

if ! [[ -r $file ]]; then
    echo "Error: File $file does not exists.";
    exit 1;
fi

buff=`cut -d' ' -f2- $file`
while read line
do
    line=`eval "echo $line"`
    if test -d $line
    then
        paths+="$line ";
    else
        echo "\"$line\" - is not a directory"
    fi
done <<< "$buff"

if [[ -z "$paths" ]]; then
    echo "Error: In the file \"$file\" there is no valid paths for building tags";
    exit 1;
fi

if $keep ; then
	while true 
    do
	    build;
	    sleep 5m;
	done
else
    build;
fi
