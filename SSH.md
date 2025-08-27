# SSH

- [SSH](#ssh)
  - [SSH commands](#ssh-commands)
    - [inloggen](#inloggen)
    - [uitloggen](#uitloggen)
    - [inloggen, commando uitvoeren, uitloggen](#inloggen-commando-uitvoeren-uitloggen)
    - [Kopieer file van apparaat naar SSH](#kopieer-file-van-apparaat-naar-ssh)
    - [passwordless SSH via ssh Key](#passwordless-ssh-via-ssh-key)
    - [View public keys of people you trust](#view-public-keys-of-people-you-trust)
    - [kopieer publieke key naar apparaat](#kopieer-publieke-key-naar-apparaat)
    - [kopieer een 2de publieke key naar authorized\_keys](#kopieer-een-2de-publieke-key-naar-authorized_keys)
    - [naar iemand anders zijn ssh inloggen](#naar-iemand-anders-zijn-ssh-inloggen)
  - [SSH-AGENT](#ssh-agent)
    - [start SSH-AGENT](#start-ssh-agent)
    - [check of SSH-AGENT aan het runnen is](#check-of-ssh-agent-aan-het-runnen-is)
    - [key toevoegen met ssh-agent](#key-toevoegen-met-ssh-agent)
    - [key tonen](#key-tonen)
    - [key verwijderen](#key-verwijderen)

## SSH commands

### inloggen

```bash
ssh admin42@192.168.1.30
```

### uitloggen

```bash
exit
```

### inloggen, commando uitvoeren, uitloggen

```bash
ssh admin42@192.168.1.30 pwd
```

### Kopieer file van apparaat naar SSH

```bash
scp admin42@192.168.1.30:/etc/hosts /home/paul/serverhosts
omgekeerd
scp ~/serverhosts admin42@192.168.1.30:/etc/hosts.new
```

### passwordless SSH via ssh Key

```bash
ssh-keygen -t rsa
KEYS BEKIJKEN
ls -l .ssh/id*
IF YOU CREATE THE .SSH FILE MANUALY, YOU HAVE TO DO chmod 777
mkdir .ssh
ls -ld .ssh
chmod 700 .ssh/
```

### View public keys of people you trust

```bash
cat .ssh/authorized_keys
```

### kopieer publieke key naar apparaat

```bash
scp id_rsa.pub bob@192.168.48.92:~/.ssh/authorized_keys
```

### kopieer een 2de publieke key naar authorized_keys

```bash
cat id_rsa.pub >> ~/.ssh/authorized_keys
OF
ssh-copy-id -i .ssh/id_rsa.pub bob@192.168.48.92
```

### naar iemand anders zijn ssh inloggen

```bash
ssh bob@192.168.48.92 "ls -l .ssh"
```

## SSH-AGENT

### start SSH-AGENT

```bash
eval $(ssh-agent)
```

### check of SSH-AGENT aan het runnen is

```bash
ps -ef | grep ssh-agent
```

### key toevoegen met ssh-agent

```bash
ssh-add
```

### key tonen

```bash
ssh-add -L
```

### key verwijderen

```bash
ssh-add -D
```
