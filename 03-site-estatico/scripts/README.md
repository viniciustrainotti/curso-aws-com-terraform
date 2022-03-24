# Steps to exec modules

Inicialmente, deve ser criado o S3 da aula 02-terraform-intermediario/01-remote-state/00-remote-state-bucket com o dynamodb, para remote state que será configurado no backend.hcl

## website

Para executar na AWS será necessário realizar o build da aplicação. Provavelmente você tenha o docker instalado, execute os comandos abaixo, no diretório do website:

```
$ docker run -itd --name webapp -v ${PWD}:/opt/app-root/src -p 3000:3000 node:14-alpine
$ docker exec -it -u root webapp sh
$ cd /opt/app-root/src
$ npm install
$ npm build 
$ exit
```

## S3

Será executado os S3 na seguinte arquitetura: logging, website e redirect; mantendo a arquiteura apresenta na imagem 03-site-estatico/diagram.png

## CDN (Cloudfront)

Será criado para fazer a parte de cache em relação a todos os lugares do mundo, não se limitando por exemplo a eu-central-1

## Route53

Direcionar o cloudfront, certificado e o www do bucket

```
$ terraform plan -var="domain=viniciustrainotti.com"
```

## ACM 

Criar certificado para o domain, obrigatório ser em us-east-1, por isso adicionado o alias em main.tf

## Restrição S3 e script deploy.sh

será arrumado o this do cloudfront access e a policy do S3 com o CDN


