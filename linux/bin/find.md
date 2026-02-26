find / -type f -name *.conf -user root -size -28k && +25k -newermt 2020-03-03 -exec ls -al {} \; 2>/dev/null
find / -type f -name *.conf -user root -size -28k+25k -newermt 2020-03-03 -exec ls -al {} \; 2>/dev/null

answer :

Find Files and Diretories

What is the name of the config file that has been created after 2020-03-03 and is smaller than 28k but larger than 25k?
find / -iname "*.conf" -size +25k -size -28k -newermt 2020-03-03 2>/dev/null

How many files exist on the system that have the ".bak" extension?
find / -type f -iname "*.bak" 2>/dev/null | wc -l


How many files exist on the system that have the ".log" extension?
find / -type f -iname "*.log" 2>/dev/null | wc -l

