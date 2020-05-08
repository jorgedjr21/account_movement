class Bank
  require 'csv'

  def self.open_csv(file, type = "contas")
    return { status: :error, data: nil, message: "The \e[31m#{type}.csv\e[39m file should be parsed as \e[1margument\e[21m\n" } if file.match(/^#{type}.csv$/).nil?
    { status: :ok, data: CSV.read(file), message: 'success' }
  end


  def self.process_accounts(accounts)
    processed_accounts = {}
    accounts.each do |account|
      print "Creating \e[1maccount #{account[0]}\e[0m with balance of #{Bank.print_balance(account[1])}\n"
      processed_accounts["#{account[0]}"] = account[1].to_i
    end

    processed_accounts
  end

  def self.process_account_transactons(accounts, transactions)
    transactions.each do |transaction|
      print "Processing transaction for account #{transaction[0]}, #{Bank.print_transaction(transaction[1])}\n"
      accounts["#{transaction[0]}"] += transaction[1].to_i
    end
  end

  def self.print_balance(value)
    value = value.to_f / 100
    return "\e[1m\e[32mR$ #{value}\e[39m\e[0m" if value > 0
    return "\e[1m\e[31mR$ #{value}\e[39m\e[0m" if value < 0
    "\e[1m\e[34mR$ #{value}\e[39m\e[0m"
  end

  def self.print_transaction(value)
    value = value.to_f / 100
    return "\e[1m\e[32mcredit of R$ #{value}\e[39m\e[0m" if value > 0
    "\e[1m\e[31mR$ debit of R$ #{value}\e[39m\e[0m"
  end
end