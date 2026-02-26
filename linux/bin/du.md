check disk usage

human readable format
`du -h /path/to/directory`

summarize disk usage
`du -sh /path/to/directory`

check disk usage for specific depth
`du -h --max-depth=1 /path/to/directory`

sort disc usage in desc order
`du -ah /path/to/directory | sort -rh`

check disk usage of specific type
`find /path/to/directory -type f -name '*.log' -exec du -h {} +`

generate report using tee
`du -sh /path/to/directory | tee disk_usage_report.txt`

format output using awk
`du -ah /path/to/directory | awk '{print $1, $2}'`

use together with xargs




