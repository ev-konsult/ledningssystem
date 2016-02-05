# Ledningssystem
[Wikin](https://github.com/ev-konsult/ledningssystem/wiki)  
[![Build Status](https://travis-ci.org/ev-konsult/ledningssystem.svg?branch=master)](https://travis-ci.org/ev-konsult/ledningssystem)

## Publicerad applikation

http://intraev.herokuapp.com/

## Arbetsflöde
[Git workflow](https://github.com/ev-konsult/ledningssystem/wiki/Git-Workflow)
[Git message convention](https://github.com/ev-konsult/ledningssystem/wiki/Git-commit-message-convention)



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
// TODO
  
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
