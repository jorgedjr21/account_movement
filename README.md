# ACCOUNT MOVEMENT challange

An application that reads the csv files and process the account transactions.

**Developed with Ruby 2.6.6**

## How to Run

### Localy
1 - Download the zip file [here](https://github.com/jorgedjr21/account_movement/archive/1.0.1.zip)
2 - Extract the zip content in some folder and access it
3 - Run:
```sh
ruby account_movement.rb contas.csv transacoes.csv
```

### Docker

1 - Just run: 
```
docker run --rm jorgedjr21/account_movement_challenge:latest
```

## Runing the tests

Was used the lib [rspec](https://github.com/rspec/rspec) to testing the app.

You can run the tests in `docker` with:

```sh
docker run -e APP_ENV=test -it jorgedjr21/account_movement_challenge:latest rspec
```

**OR**

Locally runing directly:

```sh
APP_ENV=test bundle exec rspec       
```

