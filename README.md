# Ledningssystem
[Wikin](https://github.com/ev-konsult/ledningssystem/wiki)

## Publicerad applikation

http://intraev.herokuapp.com/

## Installation

1. Navigera in i mappen IntraEV med railskonsollen 
2. Skriv "bundle install" för att installera alla gems
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
