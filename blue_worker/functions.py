import datetime
import os
from . import NAME
from . import schedule
from abcli.plugins import tags
from abcli import logging
import logging

logger = logging.getLogger(__name__)


def scheduled_command(needs_gpu=-1):
    command = ""
    for list_of_tags in schedule:
        if not schedule[list_of_tags].get("enabled", True):
            continue

        if needs_gpu != -1 and schedule[list_of_tags]["needs_gpu"] != bool(needs_gpu):
            continue

        list_of_assets, timestamp = tags.search(
            f"scheduled,{list_of_tags}",
            return_timestamp=True,
        )
        if not list_of_assets:
            command = schedule[list_of_tags]["command"]
        else:
            list_of_assets = [asset for asset in list_of_assets if asset]

            latest_asset = [
                asset
                for _, asset in sorted(
                    zip(
                        [timestamp[asset] for asset in list_of_assets],
                        list_of_assets,
                    )
                )
            ][-1]

            time_since_latest_asset = (
                datetime.datetime.utcnow() - timestamp[latest_asset]
            ).total_seconds()
            # print("latest {}: {} - {} - {}".format(list_of_tags, latest_asset, timestamp[latest_asset], string.pretty_time(time_since_latest_asset)))

            if time_since_latest_asset > schedule[list_of_tags]["period"]:
                command = schedule[list_of_tags]["command"]

        if command:
            tags.set_(
                os.getenv("abcli_object_name", ""),
                f"scheduled,{list_of_tags}",
            )
            return command

    return ""
