class Bank
  require 'csv'

  # Open the Contas or transactions CSV
  def self.open_csv(file, type = "contas")
    return { status: :error, data: nil, message: "The \e[31m#{type}.csv\e[39m file should be parsed as \e[1margument\e[21m\n" } if file.match(/^#{type}.csv$/).nil?
    { status: :ok, data: CSV.read(file), message: 'success' }
  end

  # Process the accounts to be possible to handle them
  # Creates a hash where the key is the account number and the value is the value in the account
  # e.g { "123": 21300 } => account 123 has balance of 213,00
  def self.process_accounts(accounts)
    processed_accounts = {}
    accounts.each do |account|
      print "Criando \e[1mconta #{account[0]}\e[0m com saldo inicial #{Bank.print_balance(account[1])}\n"
      processed_accounts["#{account[0]}"] = account[1].to_i
    end

    processed_accounts
  end

  # Process the transactions in the accounts
  def self.process_account_transactons(accounts, transactions)
    transactions.each do |transaction|
      message = "Processando transação da conta #{transaction[0]}, #{Bank.print_transaction(transaction[1])}"
      accounts["#{transaction[0]}"] += transaction[1].to_i 
      # Verifies if the transaction made the account negative
      if accounts["#{transaction[0]}"] < 0  && transaction[1].to_i < 0
        accounts["#{transaction[0]}"] -= 300
        message += " (R$ 3.00 de multa aplicado)"
      end

      print message + ", saldo: #{Bank.print_balance(accounts["#{transaction[0]}"])}\n"
    end

    accounts
  end

  # Helper method to print a formated balance of an account
  def self.print_balance(value)
    value = value.to_f / 100
    return "\e[1m\e[32mR$ #{value}\e[39m\e[0m" if value > 0
    return "\e[1m\e[31mR$ #{value}\e[39m\e[0m" if value < 0
    "\e[1m\e[34mR$ #{value}\e[39m\e[0m"
  end

  # Helper method to print a formated transaction of an account
  def self.print_transaction(value)
    value = value.to_f / 100
    return "\e[1m\e[32mdepósito de R$ #{value}\e[39m\e[0m" if value > 0
    "\e[1m\e[31mdébito de R$ #{value.abs}\e[39m\e[0m"
  end

  # Helper method to print the final result
  def self.final_account_balances(accounts)
    accounts.each do |account|
      puts "#{account[0]},#{account[1]}"
    end
  end
end