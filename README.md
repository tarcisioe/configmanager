configmanager
=============

A nice set of scripts for managing and sharing configuration files under VCS between multiple Linux user accounts.

# Installing

Installing can easily be done by cloning the repository and running the install script.

    git clone https://github.com/tarcisioe/configmanager
    cd configmanager
    bash install.sh [optional directory]
    
The **optional directory** will be created by *install.sh* and must not exist before (If the directory already exists,
*install.sh* will refuse to install.).

If the directory is omitted, *install.sh* installs to `~/.gitconfigs/`.

# Using

On first use, you will need to register the config files that will be managed. This is done by **register.sh**.

(You might want to chmod +x the scripts, or optionally call them with bash.)

Usage is simple:

    ./register.sh <file> <storage name>
    
*register.sh* will then move *file* to the *files* directory inside the directory where you installed, under
*storage name*, create a link to the stored file and then register it on the mapping.

Note: files under your homedir will have your $HOME substituted by ~. The other scripts deal with that. This
way, you can use this independently of username.

**IMPORTANT**: Filenames with spaces are basically guaranteed not to work. Configuration files don't normally have
spaces in their names, though. Also, no file should. Really.

When done, you can then put the directory under version control and send it to a remote repository. (Github is quite
cool!)

## Migrating a new system

Migration is also simple. Just obtain a copy of your installation folder on the first system (Git will help you here
on getting everything always synced.).

Run *migrate.sh*:

    ./migrate.sh
    
It takes no arguments. It will migrate any file registered on the mapping by removing it and linking it back with
the version stored.

## Linking files that don't yet exist

If for example, you are using a new system and haven't even created some config files, *link.sh* will create links for
files that are mapped but don't yet exist.

Usage is just:

    ./link.sh
    
## Undoing

Just run *undo.sh*

   ./undo.sh
   
It will replace every mapped file with the version stored.

# Updating

If this repository is updated, just run *update.sh* pointing at your installation directory. It will replace every
script with the new version.

   bash update.sh [optional directory]
