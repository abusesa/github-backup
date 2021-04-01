from setuptools import setup

setup(
    name='github-backup',
    version='1.0.0',
    description='',
    url='https://github.com/lnxd/docker-github-backup',
    author='lnxd',
    install_requires=['requests'],
    scripts=['github-backup.py'],
    zip_safe=True
)
