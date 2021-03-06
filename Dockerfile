FROM ruby:2.6-alpine

RUN mkdir /scripts
WORKDIR /scripts
COPY . /scripts

RUN bundle install

CMD ["ruby", "account_movement.rb", "contas.csv", "transacoes.csv"]