# jq en AWK

- [jq en AWK](#jq-en-awk)
  - [AWK](#awk)
    - [AWK voorbeelden](#awk-voorbeelden)
  - [jq](#jq)
    - [jq als pretty printer](#jq-als-pretty-printer)
    - [Toon enkel eerste element](#toon-enkel-eerste-element)
    - [Toon enkel specifieke velden](#toon-enkel-specifieke-velden)

## AWK

### AWK voorbeelden

```bash
awk '{ som += $3 } END { print som }' data.txt

awk -F, '{ print $2, $3 }' data.csv

awk -F, '$3 > 25 { print $2, $3 }' data.csv

awk '/error/ { print }' logfile.txt
```

## jq

### jq als pretty printer

```bash
curl -s 'https://api.github.com/repositories/5101141/commits?per_page=5' | jq
OF
jq . parkings.json
```

### Toon enkel eerste element

```bash
curl -s 'https://api.github.com/repositories/5101141/commits?per_page=5' | jq '.[0]'
```

### Toon enkel specifieke velden

```bash
jq '.[0] | {message: .commit.message, name: .commit.committer.name}'
```
