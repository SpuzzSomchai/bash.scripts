# Bash Scripts

A small collection of `bash` scripts I created and use on a daily basis to perform tedious tasks. 

One I use the most if the `service-menu` script or `sm` for short to:

- start
- restart
- status
- inspect Linux services and docker containers

## Creating a new global script

- Whenever I'm done with a script and I want to use it globally on my server I create a symbolic link in the `/usr/bin` directory to execute the script where I create them in the `/srv/scripts` directory
- But before you do that, first make the script executable by running the following command

## Make script executable

```sh
chmod +x [filename]
```

## Create Symbolic link

To create a new symbolic link, use the following command

```sh
ln -s /srv/scripts/[script file] /usr/bin/[command]
```

So for the the service menu that I use to much the command would look like this:

```sh
ln -s /srv/scripts/service-menu.sh /usr/bin/sm
```
