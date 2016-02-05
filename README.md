# Ledningssystem
[Wikin](https://github.com/ev-konsult/ledningssystem/wiki)  
[![Build Status](https://travis-ci.org/ev-konsult/ledningssystem.svg?branch=master)](https://travis-ci.org/ev-konsult/ledningssystem)

## Publicerad applikation

http://intraev.herokuapp.com/

## Arbetsflöde
[Git workflow](https://github.com/ev-konsult/ledningssystem/wiki/Git-Workflow)
[Git message convention](https://github.com/ev-konsult/ledningssystem/wiki/Git-commit-message-convention)

## Installation

1. Navigera in i mappen IntraEV med railskonsollen 
2. Skriv "bundle install --without production" för att installera alla gems
3. Skriv "rake db:setup" för att skapa databasen och populera den med testdata. Dessa konton skapas:
 
| Användarnamn | Lösenord |
|----:|:-------|
| Admin | adminpassword |
| First User | firstpassword |
| Second User | secondpassword |

4. Skriv "rails s" för att starta servern
5. Nu hittar du applikationen på localhost:3000
  
## Tester

Skriv "rake test" för att köra alla tester. Lägg på ett ord för att köra specifika testgrupper, tex "rake test:models".
