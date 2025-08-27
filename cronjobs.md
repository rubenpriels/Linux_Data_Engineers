# Cronjob

- [Cronjob](#cronjob)
  - [jobs (achtergrondproces)](#jobs-achtergrondproces)
    - [job commands](#job-commands)
    - [job examples](#job-examples)
  - [at (eenmalig uitvoeren)](#at-eenmalig-uitvoeren)
    - [at commands](#at-commands)
    - [at examples](#at-examples)
  - [Cronjobs](#cronjobs)
    - [cronjob commands](#cronjob-commands)
    - [Cronjob examples](#cronjob-examples)

## jobs (achtergrondproces)

### job commands

```bash
# Lijst van achtergrondprocessen
jobs
# Idem, toon ook Process ID (PID)
jobs -l
# Breng proces op voorgrond
fg NUM
# Herstart stilgelegd proces op achtergrond
bg NUM
```

### job examples

```bash
sleep 60
CTRL + Z    # --> stopt het process
bg          # --> start het process op de achtergrond

OF

sleep 60 &  # --> combinatie van hierboven
```

## at (eenmalig uitvoeren)

### at commands

```bash
# Met watch herbekijken we elke 2s de inhoud van het doelbestand
watch cat /tmp/date.txt
# Geeft lijst van geplande taken
atq
# Verwijder taak met id NUM
atrm NUM
# Voer taak uit wanneer systeem minder belast is
batch
```

### at examples

```bash
at now + 2 minutes
at 3:03 AM
at midnight
at 1am tomorrow
at now + 3 weeks
```

## Cronjobs

### cronjob commands

```bash
# tonen
crontab -l
# bewerken
crontab -e
```

### Cronjob examples

```bash
# every minute
* * * * * date >> /tmp/date.txt

# Run a script at 2:30 AM daily:
30 2 * * * /home/user/myscript.sh

# every 2 minutes on sunday
*/2 * * * 0 /home/user/myscript.sh
```

```bash
- - - - - command-to-run
│ │ │ │ │
│ │ │ │ └─ Day of week (0–7, Sun=0 or 7)
│ │ │ └─── Month (1–12)
│ │ └───── Day of month (1–31)
│ └─────── Hour (0–23)
└───────── Minute (0–59)
```
