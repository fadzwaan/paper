Filter Contents

How many services are listening on the target system on all interfaces? (Not on localhost and IPv4 only)
ss -l -4 | grep -v "127\.0\.0" | grep "LISTEN" | wc -l