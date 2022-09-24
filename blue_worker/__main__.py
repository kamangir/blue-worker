import argparse
from . import *
from abcli import logging
import logging

logger = logging.getLogger(__name__)

parser = argparse.ArgumentParser(NAME, description=f"{NAME}-{VERSION}")

parser.add_argument(
    "task",
    type=str,
    default="",
    help="scheduled_command",
)
parser.add_argument(
    "--needs_gpu",
    type=int,
    default=-1,
    help="0|1|-1",
)
args = parser.parse_args()

success = False
if args.task == "scheduled_command":
    print(scheduled_command(args.needs_gpu))
    success = True
else:
    logger.error(f"-{NAME}: {args.task}: command not found.")

if not success:
    logger.error(f"-{NAME}: {args.task}: failed.")
