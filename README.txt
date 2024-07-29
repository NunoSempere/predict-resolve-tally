# PRT: Predict, Resolve & Tally

57 lines of code which allow you to make predictions, resolve, and tally them,
without many user niceties. Name inspired by PRT, from the Worm serial

## Example of use

Open a terminal, with Ctrl+Alt+T

The command predict creates a new prediction:

$ predict
> Statement: Before 1 July 2020 will SpaceX launch its first crewed mission into orbit?
> Probability (%): 50
> Date of resolution (year/month/day): 2020/07/01

The command resolve resolves all predictions whose dates have passed.

$ resolve
Before 10 April 2020 will former Catalan President Carles Puigdemont return to Spain? (2020/04/10)
> (TRUE/FALSE) TRUE

The command tally tallies how you did for all resolved predictions.

$ tally
0 to 10 : 0 TRUE and 10 FALSE
10 to 20 : 0 TRUE and 5 FALSE
20 to 30 : 1 TRUE and 3 FALSE
30 to 40 : 2 TRUE and 7 FALSE
40 to 50 : 10 TRUE and 11 FALSE
50 to 60 : 10 TRUE and 10 FALSE
60 to 70 : 7 TRUE and 0 FALSE
70 to 80 : 10 TRUE and 2 FALSE
80 to 90 : 10 TRUE and 1 FALSE
90 to 100 : 1 TRUE and 0 FALSE

## Installation

### 1. Add the following to your .bashrc

Copy the contents or source the PRT file to your .bashrc file. For example:

```
[ -f /home/nuno/Documents/PRT ] && source /home/nuno/Documents/PRT
```

### 2. Change the directory.

Change the first 3 lines so that the program uses the directory of your choice. 
For example, in my system they might be:

```
pendingPredictions=/home/nuno/Documents/Forecasting/pendingPredictions.txt
pendingPredictionsTemp="${pendingPredictions}.t"
resolvedPredictions=/home/nuno/Documents/Forecasting/resolvedPredictions.txt
```

## Gotchas

CSV
- Statements, predictions and probabilities are saved, internally, as a csv
  file.
- This requires not using commas in your statements

Dates: 
- Dates are in the year/month/day format, so that they can be compared 
  alphanumerically as strings. That is, an earlier date, in this format, would 
  come earlier in a dictionary than a later date. 
- 2020/7/1 is not a valid date, because it would come after 2020/10/01. Write 
  dates using two digits for both month and dates, like: 2020/07/01.

Runs using bash. <https://en.wikipedia.org/wiki/Bash_(Unix_shell)>

Windows and Mac are not supported, though you could get this to run there if
you wanted to, through various bash for Windows interpreters, like the one that 
comes with git for Windows <https://git-scm.com/download/win>

The tally function only accepts predictions with 1% granularity, and it
aggregates them with 10% granularity.
