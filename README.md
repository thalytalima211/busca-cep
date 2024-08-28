# Busca por CEP

## Descrição do projeto
Este é um projeto simples para busca de informações sobre CEPs brasileiros, consumindo dados da [API de CEP do Awesome API](https://docs.awesomeapi.com.br/api-cep).

## Funcionalidades
✔️ Busca de informações completas sobre um CEP, incluindo bairro, cidade, estado, DDD e coordenadas.

✔️ Armazenamento de informações em banco de dados, para evitar consultas repetidas à API

✔️ Exibição de estísticas sobre quantidades de pesquisas para cada CEP em toda a plataforma e com filtros por estados.

## Pré-Requisitos
- [Ruby](https://github.com/rvm/ubuntu_rvm)

## Como rodar a aplicação
No terminal, clone o projeto:
```
git clone git@github.com:thalytalima211/busca-cep.git
```

Entre na pasta do projeto: 
```
cd busca-cep
```

Execute o comando para instalar as gems necessárias:
```
gem install bundler
bundle install
```

Execute o comando para carregar a estrutura do banco de dados da aplicação:
```
rails db:migrate
```

Execute o comando se desejar carregar dados de CEPs iniciais tirados da API, para exemplificação do uso da aplicação:
```
rails db:seed
```

Por fim, execute a aplicação:
```
bin/dev
```

Acesse a aplicação pelo link:
```
http://localhost:3000
```

## Como rodar os testes
Para executar os testes da aplicação, execute o comando:
```
rspec
```

## Casos de teste
![Tela inicial](https://github.com/user-attachments/assets/8d5172d4-75dc-4422-915e-8b7491353696)

Tela inicial da aplicação, com campo de busca para CEP.

![Detalhes de CEP](https://github.com/user-attachments/assets/ae8e071c-8ff2-4bd7-9858-d26c92e2d2b9)

Tela de detalhes de um CEP, com informações como cidade, estado e DDD.

![CEPs mais buscados](https://github.com/user-attachments/assets/7c13dd0e-cb5c-4c52-b241-bbd59916a50c)
Página de estísticas de pesquisa de CEPs, com campo para filtragem de CEPs mais buscados por estado.


