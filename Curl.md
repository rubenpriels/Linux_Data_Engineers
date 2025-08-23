# Curl

- [Curl](#curl)
  - [Downloaden naar een bestand](#downloaden-naar-een-bestand)
  - [Downloaden naar een bestand met zelfde naam](#downloaden-naar-een-bestand-met-zelfde-naam)
  - [Headers mee ophalen](#headers-mee-ophalen)
  - [Alleen headers ophalen](#alleen-headers-ophalen)
  - [Headers toevoegen](#headers-toevoegen)
  - [Volgt redirects](#volgt-redirects)
  - [Post](#post)

## Downloaden naar een bestand

```bash
curl -s -o bestand.txt 'https://api.coinlore.net/api/ticker/?id=90'
```

## Downloaden naar een bestand met zelfde naam

```bash
curl -s -O https://www.google.com/robots.txt
```

## Headers mee ophalen

```bash
curl -i http://google.com
```

## Alleen headers ophalen

```bash
curl -I http://google.com
```

## Headers toevoegen

```bash
curl -H 'User-Agent: Mozilla/4.0 (compatible; MSIE 5.0; Windows 98; DigExt)' \
    https://httpbin.org/anything
```

## Volgt redirects

```bash
curl -L https://www.twitter.com
```

## Post

```bash
curl -X POST -d 'penguin=tux&color=blue' https://httpbin.org/anything
```
