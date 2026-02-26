Use cURL from your Pwnbox (not the target machine) to obtain the source code of the "https://www.inlanefreight.com" website and filter all unique paths of that domain. Submit the number of these paths as the answer.

curl https://www.inlanefreight.com> htb.txt && cat htb.txt | tr " " “\n” | cut -d"‘" -f2 | cut -d’"’ -f2 | grep “www.inlanefreight.com” | sort -u | wc -l 2>/dev/null

Determine what user the ProFTPd server is running under. Submit the username as the answer.
cat /etc/proftpd/proftpd.conf 
ps aux | grep proftpd

cat /etc/passwd
more /etc/passwd
less /etc/passwd
grep -v "v means not including word inside here"

cat /etc/passwd | grep -v "false\no|login" | tr ":" " " | column -t
cat /etc/passwd | grep -v "false\no|login" | tr ":" " " | awk '{print $1, $NF}'
fadzwn@htb[/htb]$ cat /etc/passwd | grep -v "false\|nologin" | tr ":" " " | awk '{print $1, $NF}' | 
fadzwn@htb[/htb]$ cat /etc/passwd | grep -v "false\|nologin" | tr ":" " " | awk '{print $1, $NF}' | wc -l
sed 's/bin/HTB/g'
ss -l -4 used to list all listening sockets on a Linux system. The -l option tells the ss command to list all listening sockets, and the -4 option tells the ss command to only list IPv4 sockets.


why 'which' work on /usr/bin only?
refer : https://dev.to/kcdchennai/demystifying-linux-the-purpose-of-bin-usrbin-and-usrlocalbin-5a8e


Regular Expressions

curl https://www.inlanefreight.com/ > htb.txt

grep -E "(my.*false)" /etc/passwd
same as
grep -E "my" /etc/passwd | grep -E "false"
(grep two times , filter same effect as AND operator above)
