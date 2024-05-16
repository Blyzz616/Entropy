# Entropy

This script will take a string and display it's entropy. It will then dispaly a graph showing all the characters used.

```
NAME
       entropy - Display entropy of a particular string with a bar chart displaying character usage.

SYNOPSIS
       ./entropy.sh [OPTION]... [STRING]...

DESCRIPTION
       Display entropy for the entire STRING with a breakdown of character usage, writing to standard output.

       As of now, only standard input is read.

       -l, --letters
              exclude all alpha characters from the parsed string

       -n, --numbers
              exclude all numeric characters from the parsed string

       -s, --special
              exclude all special/punctuation characters from the parsed string

       -w, --white-space
              exclude all white-space characters from the parsed string

       -i, --ignore-case
              parse the string, ignoring upper case and lower case

       -p, --period
              exclude all period characters from the parsed string

       -a, --ascend
              parse the string, with the count of the lowest number of characters at the top

       -d, --descend
              parse the string, with the count of the highest number of characters at the top

       -h, --help display this help and exit

       --version
              output version information and exit

AUTHOR
       Written by Jim Sher.
```

Output for "Hello World!"

![image](https://github.com/Blyzz616/Entropy/assets/19424317/5df2099a-8d24-4b20-b093-d111ebd8eaf8)



