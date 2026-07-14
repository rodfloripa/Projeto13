# Projeto13

## 1. Introdução

```{=html}
<p align="justify">
```
Este projeto demonstra a implantação de um algoritmo simples de
Processamento de Linguagem Natural (NLP) utilizando Docker, Apache,
mod_wsgi e Flask. O algoritmo emprega K-Means para agrupar frases
semanticamente semelhantes a partir de um arquivo CSV denominado
`<code>`{=html}input.cluster`</code>`{=html}, retornando um arquivo
`<code>`{=html}.xls`</code>`{=html} compactado contendo a classificação
de cada frase.
```{=html}
</p>
```
## 2. Objetivo

```{=html}
<p align="justify">
```
O objetivo é disponibilizar o modelo como uma API web executando em um
contêiner Docker, permitindo o envio de um arquivo CSV para
processamento e o recebimento do resultado automaticamente.
```{=html}
</p>
```
## 3. Funcionamento

```{=html}
<p align="justify">
```
O usuário envia um arquivo CSV contendo frases. O algoritmo realiza a
vetorização dos textos, executa o agrupamento utilizando K-Means e
devolve um arquivo XLS compactado contendo o cluster atribuído a cada
frase.
```{=html}
</p>
```
## 4. Arquitetura

```{=html}
<p align="justify">
```
A aplicação utiliza Flask hospedado pelo Apache através do mod_wsgi
dentro de um contêiner Docker.
```{=html}
</p>
```
## 5. Como Executar

```{=html}
<p align="justify">
```
Clone o repositório:
```{=html}
</p>
```
``` bash
git clone https://github.com/rodfloripa/Projeto13.git
cd Projeto13
```

```{=html}
<p align="justify">
```
Construa a imagem:
```{=html}
</p>
```
``` bash
docker build -t projeto13 .
```

```{=html}
<p align="justify">
```
Execute o container:
```{=html}
</p>
```
``` bash
docker run -p 8000:8000 projeto13
```

```{=html}
<p align="justify">
```
Teste:
```{=html}
</p>
```
``` text
http://localhost:8000
```

## 6. Como Utilizar a API

```{=html}
<p align="justify">
```
Endpoint:
```{=html}
</p>
```
``` text
POST /
Content-Type: multipart/form-data
```

```{=html}
<p align="justify">
```
Envie o arquivo `<code>`{=html}input.cluster`</code>`{=html} pelo campo
`<code>`{=html}file`</code>`{=html}.
```{=html}
</p>
```
``` bash
curl -X POST -F "file=@input.cluster" http://localhost:8000/
```

``` python
import requests

with open("input.cluster","rb") as f:
    r = requests.post(
        "http://localhost:8000/",
        files={"file": f}
    )

with open("resultado.zip","wb") as out:
    out.write(r.content)
```

## 7. Observações

```{=html}
<p align="justify">
```
A imagem utiliza Python 3.6 (continuumio/anaconda3:4.4.0). Caso o
Dockerfile utilize `<code>`{=html}COPY ./flask_demo`</code>`{=html} e a
pasta do projeto possua outro nome, ajuste o Dockerfile ou renomeie a
pasta correspondente.
```{=html}
</p>
```
## 8. Encerrando

``` bash
docker stop <container_id>
```
