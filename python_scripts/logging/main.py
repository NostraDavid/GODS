# pip install structlog colorama
from structlog import get_logger

log = get_logger()
log.info("key_value_logging", out_of_the_box=True, effort=0)

from structlog.processors import format_exc_info
try:
    raise ValueError
except ValueError:
    format_exc_info(None, None, {"exc_info": True})

import structlog
log = structlog.get_logger()
log.msg("greeted", whom="world", more_than_a_string=[1, 2, 3])

# Using the defaults, as above, is equivalent to:
import logging
import structlog

structlog.configure(
    processors=[
        structlog.processors.add_log_level,
        structlog.processors.StackInfoRenderer(),
        structlog.dev.set_exc_info,
        structlog.processors.format_exc_info,
        structlog.processors.TimeStamper(),
        structlog.dev.ConsoleRenderer()
    ],
    wrapper_class=structlog.make_filtering_bound_logger(logging.NOTSET),
    context_class=dict,
    logger_factory=structlog.PrintLoggerFactory(),
    cache_logger_on_first_use=False
)
log = structlog.get_logger()

structlog.configure(processors=[structlog.processors.JSONRenderer()])
structlog.get_logger().msg("hi")
