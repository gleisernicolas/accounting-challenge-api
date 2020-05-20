# Accounting Challenge API
Projeto feito como parte do seguinte desafio [Sistema de Contas bancárias](https://github.com/iugu/accounting_challenge).
Projeto foi feito usando Ruby on Rails e banco de dados Mysql

## Requisitos
Pra rodar o projeto você vai precisar do seguinte:

- `Ruby 2.7.0`, a forma mais simples de instalar é usando o [RVM](https://rvm.io/rvm/install)
- [postgresql](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-postgresql-on-ubuntu-18-04-pt)
- Nodejs, pode usar o [NVM](https://github.com/nvm-sh/nvm)
- [Yarn](https://classic.yarnpkg.com/pt-BR/docs/install/#debian-stable)

## Rodando o projeto

Pra rodar o projeto basta seguir os passos:
- `bundle install`
- Ir em database.yml e alterar `username` e `password` para as credenciais do banco instalado.
- `bundle exec rails db:setup`


Depos disso você pode rodar `bundle exec rspec` para rodar a suite de testes ou `bundle exec rails s` pra subir o projeto.

