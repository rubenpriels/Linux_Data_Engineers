# Permissies

- [Permissies](#permissies)
  - [chmod](#chmod)
    - [check permissions](#check-permissions)
    - [change permissions](#change-permissions)
  - [umask](#umask)
    - [check umask](#check-umask)
    - [change umask](#change-umask)
  - [beheer groepen](#beheer-groepen)
    - [nieuwe groep toevoegen, naam veranderen en verwijderen](#nieuwe-groep-toevoegen-naam-veranderen-en-verwijderen)
    - [group memberships](#group-memberships)
    - [primaire groep aanpassen](#primaire-groep-aanpassen)
    - [gebruiker toevoegen aan groep](#gebruiker-toevoegen-aan-groep)
    - [gebruiker toevoegen aan groep en verwijderen uit andere](#gebruiker-toevoegen-aan-groep-en-verwijderen-uit-andere)
  - [beheer gebruikers](#beheer-gebruikers)
    - [nieuwe gebruiker toevoegen en verwijderen](#nieuwe-gebruiker-toevoegen-en-verwijderen)
    - [Toont de groepen waar de gebruiker toe behoort](#toont-de-groepen-waar-de-gebruiker-toe-behoort)
    - [eigen wachtwoord aanpassen](#eigen-wachtwoord-aanpassen)
    - [wachtwoord veranderen](#wachtwoord-veranderen)
    - [eigenaar/groep veranderen](#eigenaargroep-veranderen)
    - [wie is ingelogd](#wie-is-ingelogd)
    - [wie is ingelogd en wat doen ze?](#wie-is-ingelogd-en-wat-doen-ze)
    - [Toont de UID (User ID), GID (Group ID) en de groepen van een gebruiker](#toont-de-uid-user-id-gid-group-id-en-de-groepen-van-een-gebruiker)

## chmod

### check permissions

```bash
ls -l
```

### change permissions

```bash
chmod u+rw,g=rx,o-r bestand.txt
chmod 775 bestand.txt
```

## umask

### check umask

```bash
umask
```

### change umask

```bash
umask 0027
# files = 666
# directories = 777
```

## beheer groepen

### nieuwe groep toevoegen, naam veranderen en verwijderen

```bash
sudo groupadd groupname
sudo groupmod -n newgroupname oldgroupname
sudo groupdel groupname
```

### group memberships

```bash
# Sets serena as the administrator of the group sports.
gpasswd -A serena sports
# Adds harry as a member of the group sports
gpasswd -a harry sports
# Removes serena from the membership of the sports group.
gpasswd -d serena sports
```

### primaire groep aanpassen

```bash
sudo usermod -g groep gebruiker
```

### gebruiker toevoegen aan groep

```bash
sudo usermod -aG groep gebruiker
```

### gebruiker toevoegen aan groep en verwijderen uit andere

```bash
sudo usermod -G groep1,groep2 gebruiker
```

## beheer gebruikers

### nieuwe gebruiker toevoegen en verwijderen

```bash
sudo useradd username
sudo useradd -m -c 'Serena Williams' serena
sudo userdel username
sudo userdel -r testuser
```

### Toont de groepen waar de gebruiker toe behoort

```bash
groups username
```

### eigen wachtwoord aanpassen

```bash
passwd
```

### wachtwoord veranderen

```bash
sudo passwd <username>
```

### eigenaar/groep veranderen

```bash
chown user file
chown user:group file
chgrp group file
```

### wie is ingelogd

```bash
who
```

### wie is ingelogd en wat doen ze?

```bash
w
```

### Toont de UID (User ID), GID (Group ID) en de groepen van een gebruiker

```bash
id username
```
