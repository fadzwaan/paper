timedatectl set-ntp false

timedatectl set-time "2024-6-6 18:00:00"

timedatectl status

timeadetctl show

timedatectl list-timezones

```bash
└─$ timedatectl timesync-status 
       Server: 60.50.221.91 (0.debian.pool.ntp.org)
Poll interval: 34min 8s (min: 32s; max 34min 8s)
         Leap: normal
      Version: 4
      Stratum: 2
    Reference: AFF20F0
    Precision: 1us (-22)
Root distance: 8.208ms (max: 5s)
       Offset: -1.548ms
        Delay: 16.153ms
       Jitter: 5.161ms
 Packet count: 10
    Frequency: +0.925ppm
```


```bash
└─$ timedatectl show-timesync 
FallbackNTPServers=0.debian.pool.ntp.org 1.debian.pool.ntp.org 2.debian.pool.ntp.org 3.debian.pool.ntp.org         
ServerName=0.debian.pool.ntp.org                                                                                   
ServerAddress=60.50.221.91                                                                                         
RootDistanceMaxUSec=5s                                                                                             
PollIntervalMinUSec=32s                                                                                            
PollIntervalMaxUSec=34min 8s                                                                                       
PollIntervalUSec=34min 8s                                                                                          
NTPMessage={ Leap=0, Version=4, Mode=4, Stratum=2, Precision=-22, RootDelay=396us, RootDispersion=8.010ms, Reference=AFF20F0, OriginateTimestamp=Thu 2024-09-12 17:16:23 +08, ReceiveTimestamp=Thu 2024-09-12 17:16:23 +08, TransmitTimestamp=Thu 2024-09-12 17:16:23 +08, DestinationTimestamp=Thu 2024-09-12 17:16:23 +08, Ignored=no, PacketCount=10, Jitter=5.161ms }                                                                                                   
Frequency=60649
```
