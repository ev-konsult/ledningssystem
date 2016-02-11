# Ledningssystem
[Wikin](https://github.com/ev-konsult/ledningssystem/wiki)  
[![Build Status](https://travis-ci.org/ev-konsult/ledningssystem.svg?branch=master)](https://travis-ci.org/ev-konsult/ledningssystem)

## Publicerad applikation

http://intraev.herokuapp.com/

## Arbetsflöde
[Git workflow](https://github.com/ev-konsult/ledningssystem/wiki/Git-Workflow)
[Git message convention](https://github.com/ev-konsult/ledningssystem/wiki/Git-commit-message-convention)

Testar/martin

## Ruby version
* Ruby 2.1.5
* Rails 4.2.5

## Installation
```bash
    git clone https://github.com/ev-konsult/ledningssystem.git 
    bundle install --without production
    rake db:setup
    rails s 
```  
Applikationen hittas nu på localhost:3000

| Användarnamn | Lösenord |
|----:|:-------|
| Admin | adminpassword |
| First User | firstpassword |
| Second User | secondpassword |

## Deployment
  
Vi använder [Heroku](https://id.heroku.com/login) för att publicera applikationen. Man behöver ett konto på Heroku för att publicera.
  
Om man vill publicera applikationen själv behöver man installera [Heroku Toolbar](https://toolbelt.heroku.com/) på sin dator, detta finns för alla operativsystem. När det är installerat, öppna exempelvis Git Bash eller någon annan command shell och skriv detta följt av dina inloggningsuppgifter på Heroku:

```bash
    heroku login
``` 
  
Om du inte redan har ett git-repositorie i mappen, skriv 

```bash
    git init
    git add .
    git commit -am "Hello Heroku world! :sob: :sob:"
``` 

Sedan för att skapa applikationen och publicera den:

```bash
    heroku create --stack cedar
    git push heroku master
``` 

För att skapa databasens tabeller och populera dem med data:

```bash
    heroku run rake db:migrate
    heroku run rake db:seed
``` 

Om du vill byta ut herokus slumpade applikationsnamn mot ett eget namn på applikationen:

```bash
    heroku apps:rename namnetduvillha
``` 
  
## Tester
För att köra skriv
```bash
    rake test
```

För att köra tester specifika till en del av applikationen, skriv ex:
```bash
    rake test:models
    rake test:controllers
```
