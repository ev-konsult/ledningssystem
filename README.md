﻿Becci provar :>
# Ledningssystem
[Wikin](https://github.com/ev-konsult/ledningssystem/wiki)  
[![Build Status](https://travis-ci.org/ev-konsult/ledningssystem.svg?branch=master)](https://travis-ci.org/ev-konsult/ledningssystem)

## Publicerad applikation

http://intraev.herokuapp.com/

## Arbetsflöde
[Följ detta dokument](https://docs.google.com/document/d/1HEOjPrNU2Y5KXCUPT_Sb9oeAtMeMfUrbswxkRRi-7f8/edit?pref=2&pli=1)  
Tack till Rasmus Eneman som delade detta dokument.

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
