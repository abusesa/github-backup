# GitHub backup script

## Installation

Clone the repository from Bitbucket. Warn the people currently working with the repository beforehand and check that there are no e.g. pending pull requests.

```
$ pip install -r requirements.txt
```

## Configuring

### Create a token

Let's assume your token is ```0123456789abcdef0123456789abcdef```.

### Create a configuration file

Create a file ```config.json```:

```
{
    "token": "0123456789abcdef0123456789abcdef",
    "directory": "~/backups/github.com"
}
```

## Running

```
$ python backup.py config.json
```
