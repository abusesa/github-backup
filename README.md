# GitHub backup script

This container contains a script, `backup.py`, for backing up GitHub repositories.

The script requires a GitHub token and a destination directory. It then uses the token to populate the destination directory with clones of all the repositories the token can access.

It is possible to set it to run on a schedule, and repeated runs only update the already existing backups and add new repositories, if any.

## Installation

Installation can be completed via CA on Unraid.

## Configuring

### Create a token

For authorization you need to create a new personal GitHub token. You can do this from [this](https://github.com/settings/tokens) page.

![Step 1](https://raw.githubusercontent.com/lnxd/docker-github-backup/master/images/new-token-1.png)

When you click the **Generate new token** button you enter the token creation screen. Here you should give the token a descriptive name and choose its *scopes*, which basically determine what the token is allowed to do.

![Step 2](https://raw.githubusercontent.com/lnxd/docker-github-backup/master/images/new-token-2.png)

To backup public and private repositories you need to select only the **repo** scope. If you have no need for private repositories just choose the **public_repo** scope.

![Step 3](https://raw.githubusercontent.com/lnxd/docker-github-backup/master/images/new-token-3.png)

After clicking the **Generate token** button you're presented with the generated token. Remember to store it now, as GitHub won't show it to you anymore!

## Final notes
If you notice any bugs, feel free to open an Issue or a pull request. For support with using this on Unraid, you can reach me best via the [support thread](https://forums.unraid.net/topic/104589-support-lnxd-phoenixminer-amd/) on the Unraid Community Forums.