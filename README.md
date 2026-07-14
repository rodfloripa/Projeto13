# Projeto13

## 1. Introdução

<p align="justify">
Este projeto demonstra a implantação de um algoritmo simples de Processamento de Linguagem Natural (NLP) utilizando Docker, Apache, mod_wsgi e Flask. O algoritmo emprega K-Means para agrupar frases semanticamente semelhantes a partir de um arquivo CSV denominado <code>input.cluster</code>, retornando um arquivo <code>.xls</code> compactado contendo a classificação de cada frase.
</p>

## 2. Objetivo

<p align="justify">
O objetivo é disponibilizar o modelo como uma API web executando em um contêiner Docker, permitindo o envio de um arquivo CSV para processamento e o recebimento do resultado automaticamente.
</p>

## 3. Funcionamento

<p align="justify">
O usuário envia um arquivo CSV contendo frases. O algoritmo realiza a vetorização dos textos, executa o agrupamento utilizando K-Means e devolve um arquivo XLS compactado contendo o cluster atribuído a cada frase.
</p>

## 4. Arquitetura

<p align="justify">
A aplicação utiliza Flask hospedado pelo Apache através do módulo <code>mod_wsgi</code> dentro de um contêiner Docker. O servidor Apache é responsável por receber as requisições HTTP e encaminhá-las para a aplicação Flask, que executa o algoritmo de classificação baseado em K-Means e retorna o arquivo contendo os resultados.
</p>

## 5. Como Executar

<p align="justify">
Clone o repositório:
</p>

```bash
git clone https://github.com/rodfloripa/Projeto13.git
cd Projeto13
```

<p align="justify">
Construa a imagem Docker:
</p>

```bash
docker build -t projeto13 .
```

<p align="justify">
Execute o container:
</p>

```bash
docker run -p 8000:8000 projeto13
```

<p align="justify">
Verifique se a aplicação está em execução acessando:
</p>

```text
http://localhost:8000
```

## 6. Como Utilizar a API

<p align="justify">
Após iniciar o container, a aplicação ficará disponível na porta <code>8000</code>. A API recebe requisições HTTP do tipo <strong>POST</strong> contendo um arquivo CSV chamado <code>input.cluster</code>, no formato <code>multipart/form-data</code>. Esse arquivo deve conter as frases que serão agrupadas pelo algoritmo K-Means.
</p>

<p align="justify">
O endpoint da aplicação é:
</p>

```text
POST http://localhost:8000/
```

<p align="justify">
O envio do arquivo pode ser realizado utilizando o comando <code>curl</code>:
</p>

```bash
curl -X POST \
     -F "file=@input.cluster" \
     http://localhost:8000/
```

<p align="justify">
Também é possível consumir a API utilizando Python e a biblioteca <code>requests</code>:
</p>

```python
import requests

url = "http://localhost:8000/"

with open("input.cluster", "rb") as arquivo:
    resposta = requests.post(
        url,
        files={"file": arquivo}
    )

with open("resultado.zip", "wb") as saida:
    saida.write(resposta.content)

print("Arquivo salvo com sucesso!")
```

<p align="justify">
Após o processamento, a API retorna um arquivo compactado contendo uma planilha no formato <code>.xls</code>. Cada linha da planilha corresponde a uma frase do arquivo de entrada e apresenta o identificador do cluster atribuído pelo algoritmo, indicando o grupo semântico ao qual a frase pertence.
</p>
