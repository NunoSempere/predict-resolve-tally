#!/bin/bash

pendingPredictions=/home/nuno/Documents/core/forecasting/past/PredictResolveTally/pendingPredictions.txt
pendingPredictionsTemp="${pendingPredictions}.t"
resolvedPredictions=/home/nuno/Documents/core/forecasting/past/PredictResolveTally/resolvedPredictions.txt

function predict(){
        read -p "> Statement: " statement
        read -p "> Probability (%): " probability
        read -p "> Date of resolution (year/month/day): " date
        echo UNRESOLVED	$date	$probability	$statement >> $pendingPredictions
}

function resolve(){
        while IFS= read -r -u9 line || [[ -n "$line" ]]; do

                resolutionState="$(cut -d'	' -f1 <<<"$line")"
                date="$(cut -d'	' -f2 <<<"$line")"
                probability="$(cut -d'	' -f3 <<<"$line")"
                statement="$(cut -d'	' -f4 <<<"$line")"
                
                today=$(date +"%Y/%m/%d") 
                if [[ "$today" > "$date" ]]; 
                then
                        # Already passed
                        echo $statement "("$date")"
                        read -p "> (TRUE/FALSE) " resolutionState
                        echo -e "$resolutionState\t$date\t$probability\t$statement" >> $resolvedPredictions
                else
                        # Not yet passed 
                        echo $line >> $pendingPredictionsTemp   
                fi
        done 9< "$pendingPredictions"
        mv $pendingPredictionsTemp $pendingPredictions
}

function tally(){
        
        numTRUEtens=0
        numFALSEtens=0
        for i in {0..100}
        do

                regExPatternTRUE="^TRUE.*	${i}	"
                regExPatternFALSE="^FALSE.*	${i}	"
                numTRUE="$(grep -c -e "$regExPatternTRUE" $resolvedPredictions)"
                numFALSE="$(grep -c -e "$regExPatternFALSE" $resolvedPredictions)"

                numTRUEtens=$((numTRUEtens+numTRUE))
                numFALSEtens=$((numFALSEtens+numFALSE))
                if [ $(( $i % 10 )) -eq 0 ]  && [ $i -ne 0 ] ; then
                        echo $((i-10)) to $i : $numTRUEtens TRUE and $numFALSEtens FALSE
                        numTRUEtens=0
                        numFALSEtens=0
                fi
        done

}
