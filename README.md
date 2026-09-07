# GTGWF

Imagem Docker baseada no Gotenberg com as fontes necessárias para o projeto.

Imagem publicada no GitHub Container Registry:

```text
ghcr.io/renatormc/gtgwf:latest
```

## Pré-requisitos

- Docker instalado e em execução
- Uma conta GitHub com acesso ao usuário `renatormc`
- Um Personal Access Token (PAT) do GitHub com a permissão `write:packages`

## Criar o token

1. Acesse **GitHub > Settings > Developer settings > Personal access tokens**.
2. Crie um token com a permissão `write:packages`.
3. Copie o token. Ele será usado como senha do Docker.

Não use a senha normal do GitHub no `docker login`.

## Fazer login no GHCR

Execute:

```bash
docker login ghcr.io -u renatormc
```

Quando o Docker solicitar `Password`, cole o Personal Access Token.

Também é possível informar o token sem deixá-lo visível no terminal:

```bash
read -rsp "GitHub token: " CR_PAT
printf '\n'
printf '%s' "$CR_PAT" | docker login ghcr.io \
  --username renatormc \
  --password-stdin
unset CR_PAT
```

## Build da imagem

```bash
./manage.sh build
```

O comando cria diretamente a imagem com o mesmo nome usado no registro:

```text
ghcr.io/renatormc/gtgwf:latest
```

Para usar outra tag:

```bash
TAG=1.0.0 ./manage.sh build
```

## Publicar no GitHub

Depois de fazer o login e executar o build:

```bash
./manage.sh push
```

Com uma tag específica:

```bash
TAG=1.0.0 ./manage.sh push
```

## Baixar a imagem

Se o pacote for privado, faça login antes:

```bash
docker pull ghcr.io/renatormc/gtgwf:latest
```
