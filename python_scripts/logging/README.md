# Logging

Linux can into logs (apparently!?)

``` bash
man syslog
```

For python there's Structlog, which looks to be a VERY promising lib for logging.

It can use colors, if you `pip install colorama`.

[Processors](https://www.structlog.org/en/stable/standard-library.html#processors) looks very promising.

**[filter_by_level](https://www.structlog.org/en/stable/api.html#structlog.stdlib.filter_by_level):**  
    Checks the log entry’s log level against the configuration of standard library’s logging. Log entries below the threshold get silently dropped. Put it at the beginning of your processing chain to avoid expensive operations from happening in the first place.

[Performance](https://www.structlog.org/en/stable/performance.html#performance)


[SysLog](https://en.wikipedia.org/wiki/Syslog)
https://www.structlog.org/en/15.0.0/logging-best-practices.html
[Logrotate](https://manpages.ubuntu.com/manpages/impish/en/man8/logrotate.8.html)
[Centralized logs blog](https://www.revsys.com/tidbits/centralized-logging-fun-and-profit/)