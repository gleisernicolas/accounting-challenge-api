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

## Motivos de algumas decisões
### Event sourcing
Achei interessante aplicar alguns conceitos de event-sourcing nesse projeto pois entendi que um sistema que tem transferencias de valores entre contas iria se benificiar de um histórico completo e de nuncar perder nenhuma informação, o "framework" usado (app/models/lib/base_event, event_dispatcher, command) foram retirados de uma talk sobre o d.rip do kickstarder, (video da talk)[https://www.youtube.com/watch?v=ulF6lEFvrKo] e (repo de exemplo)[https://github.com/kickstarter/event-sourcing-rails-todo-app-demo].
Como ainda estou começando a estudar esse design pattern, ainda não consegui implementar todo seu ecossistema, mas esse é pra onde pretendo evoluir a aplicação

### Symmetric encryption
Como são dados sensiveis decidir usar a gem (symmetric-encryption)[https://github.com/rocketjob/symmetric-encryption] para encriptar dados sensiveis como nome, numero da conta e token, para ter um nivel melhor se segurança eu encriptei os dados serializados que é salvo nos eventos, como esse projeto é só um desafio eu deixei todas as chaves na pasta `config/symmetric-encryption-keys` mas eu sei que o ideal é que cada chave seja inclusa no servidor por algum job de deploy e não fique no repositório

### File base authentication
Já trabalhei em alguns projetos que usam esse tipo de autenticação, e me parece ser bem sólido, contanto que o arquivo não esteja no repo, porém como é um simples desafio creio que não tenha problema

## Futuros passos
Pretendo usar esse sistema como base para estudos sobre event driven design, então provavelmente vai mudar bastante no futuro.

