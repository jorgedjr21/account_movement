require_relative 'account'

def process_accounts(accounts)
  processed_accounts = {}
  accounts.each do |account|
    processed_accounts["#{account[0]}"] = account[1].to_i
  end

  processed_accounts
end

accounts = Bank.open_csv(ARGV[0] || "")
return print accounts[:message] if accounts[:status] == :error

transactions = Bank.open_csv(ARGV[1] || "", "transacoes")
return print transactions[:message] if transactions[:status] == :error


accounts = Bank.process_accounts(accounts[:data])
accounts = Bank.process_account_transactons(accounts, transactions[:data])
