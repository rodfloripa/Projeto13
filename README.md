# Projeto13

## 1. Introdução

Este projeto demonstra a implantação de um algoritmo simples de
Processamento de Linguagem Natural (NLP) utilizando Docker, Apache,
mod_wsgi e Flask. O algoritmo emprega K-Means para agrupar frases
semanticamente semelhantes a partir de um arquivo CSV denominado
`input.cluster`, retornando um arquivo `.xls` compactado contendo a
classificação de cada frase.

## 2. Objetivo

O objetivo é disponibilizar o modelo como uma API web executando em um
contêiner Docker, permitindo o envio de um arquivo CSV para
processamento e o recebimento do resultado automaticamente.

## 3. Funcionamento

O usuário envia um arquivo CSV contendo frases. O algoritmo realiza a
vetorização dos textos, executa o agrupamento utilizando K-Means e
devolve um arquivo XLS compactado contendo o cluster atribuído a cada
frase.

## 4. Arquitetura

A aplicação utiliza Flask hospedado pelo Apache através do mod_wsgi
dentro de um contêiner Docker.

## 5. Como Executar

Clone o repositório:

``` bash
git clone https://github.com/rodfloripa/Projeto13.git
cd Projeto13
```

Construa a imagem:

``` bash
docker build -t projeto13 .
```

Execute o container:

``` bash
docker run -p 8000:8000 projeto13
```

Teste:

``` text
http://localhost:8000
```

## 6. Como Utilizar a API

**Endpoint**

``` text
POST /
Content-Type: multipart/form-data
```

Envie o arquivo `input.cluster` pelo campo `file`.

``` bash
curl -X POST -F "file=@input.cluster" http://localhost:8000/
```

``` python
import requests

with open("input.cluster", "rb") as f:
    r = requests.post(
        "http://localhost:8000/",
        files={"file": f}
    )

with open("resultado.zip", "wb") as out:
    out.write(r.content)
```

## 7. Observações

A imagem utiliza Python 3.6 (`continuumio/anaconda3:4.4.0`). Caso o
Dockerfile utilize `COPY ./flask_demo` e a pasta do projeto possua outro
nome, ajuste o Dockerfile ou renomeie a pasta correspondente.

## 8. Encerrando

``` bash
docker stop <container_id>
```
