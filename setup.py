from setuptools import setup

from blue_worker import NAME, VERSION

setup(
    name=NAME,
    author="kamangir",
    version=VERSION,
    description="an ec2 cloud worker for awesome-bash-cli",
    packages=[NAME],
)
