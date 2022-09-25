import os
from abcli import file

NAME = "blue_worker"

VERSION = "2.89.1"

_, schedule = file.load_json(
    os.path.join(
        os.getenv("abcli_path_git", ""),
        "blue-worker/schedule.json",
    ),
    civilized=True,
)


from .jobs import *
from .schedule import *
