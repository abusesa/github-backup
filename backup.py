from __future__ import print_function

import os
import re
import json
import errno
import argparse
import urlparse
import requests
import subprocess


def check_name(name):
    if not re.match(r"^\w[-\.\w]*$", name):
        raise RuntimeError("invalid name '{0}'".format(name))
    return name


def mkdir(path):
    try:
        os.makedirs(path, 0770)
    except OSError as ose:
        if ose.errno != errno.EEXIST:
            raise
        return False
    return True


def mirror(repo_name, repo_url, to_path, token):
    parsed = urlparse.urlparse(repo_url)
    modified = list(parsed)
    modified[1] = token + "@" + parsed.netloc
    repo_url = urlparse.urlunparse(modified)

    repo_path = os.path.join(to_path, repo_name)
    mkdir(repo_path)

    # git-init manual:
    # "Running git init in an existing repository is safe."
    subprocess.call(["git", "init", "--bare"], cwd=repo_path)

    # https://github.com/blog/1270-easier-builds-and-deployments-using-git-over-https-and-oauth:
    # "To avoid writing tokens to disk, don't clone."
    subprocess.call(["git", "fetch", "--tags", repo_url, "refs/heads/*:refs/heads/*"], cwd=repo_path)


def main():
    parser = argparse.ArgumentParser(description="Backup GitHub repositories")
    parser.add_argument("config", metavar="CONFIG", help="a configuration file")
    args = parser.parse_args()

    with open(args.config, "rb") as f:
        config = json.loads(f.read())

    token = config["token"]
    path = os.path.expanduser(config["directory"])
    if mkdir(path):
        print("Created directory {0}".format(path))

    response = requests.get("https://api.github.com/user/repos", headers={
        "Authorization": "token {0}".format(token)
    })
    response.raise_for_status()

    for repo in response.json():
        name = check_name(repo["name"])
        owner = check_name(repo["owner"]["login"])
        clone_url = repo["clone_url"]

        owner_path = os.path.join(path, owner)
        mkdir(owner_path)
        mirror(name, clone_url, owner_path, token)


if __name__ == "__main__":
    main()
