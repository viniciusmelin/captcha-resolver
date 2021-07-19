# Processo para quebrar captcha versão v1

Softwares necessários para executar o sistema de reconhecimento de captcha:

-   Node (v10.15.3) ou superior e NPM
-   Python3 e Pip3
-   R (Linguagem R)
-   Browserless

### Instalação

1 - Pacotes necessários no Linux

```sh
$ sudo apt install libcurl4-openssl-dev
$ sudo apt install libssl-dev
$ sudo apt install curl
$ sudo apt install libxml2-dev
$ sudo apt install libmagick++-dev
$ sudo apt install libnss3
```

2 - Instalando o Python3 e o Pip3.

```sh
$ sudo apt install python3
$ sudo apt install python3-pip
$ pip3 install h5py
$ pip3 install keras
$ pip3 install tensorflow
```

3 - Instalando o R

```sh
$ sudo apt install r-base
```

4 - Instalando o Redis

```sh
$ sudo apt install redis-server
```

5 - Instalando o Mongo

```sh
$ sudo apt install mongodb
```

6 - Após instalar o R é necessário instalar os pacotes do R, abra o terminal é execute os comandos abaixo:

```sh
> R
> install.packages("curl")
> install.packages("xml2")
> install.packages(c("roxygen2","abind", "magrittr", "stringr", "httr", "jpeg", "png", "purrr", "keras", "progress","magick"))
> install.packages("devtools")

> install.packages("reticulate")
> install.packages("tensorflow")
> devtools::install_github("decryptr/decryptrModels")
> devtools::install_github("decryptr/decryptr")
```

Para validar toda instalação do R e seus pacotes,entre na diretório test. E abra o terminal na pasta onde os arquivos se encontram e digite o comando:

```sh
 Rscript quebra.R
```
