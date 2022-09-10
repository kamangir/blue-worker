import os
from abcli import file

NAME = "blue_worker"

VERSION = "2.56.1"

_, schedule = file.load_json(
    os.path.join(
        os.getenv("abcli_path_git"),
        "blue-worker/assets/schedule.json",
    ),
    civilized=True,
)


from .functions import *
