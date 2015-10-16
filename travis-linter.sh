#!/bin/bash
set -e

exitstatus=0

for file in *.Rmd
do
    outputbytes=`Rscript -e "lintr::lint(\"$file\")" | grep ^ | wc -c`
    if [ $outputbytes -gt 0 ]
    then
        exitstatus=1
    fi
done

exit $exitstatus
