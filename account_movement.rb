require_relative 'bank'

accounts = Bank.open_csv(ARGV[0] || "")
return print accounts[:message] if accounts[:status] == :error

transactions = Bank.open_csv(ARGV[1] || "", "transacoes")
return print transactions[:message] if transactions[:status] == :error

accounts = Bank.process_accounts(accounts[:data])
print "--------\n"
accounts = Bank.process_account_transactons(accounts, transactions[:data])
print "--------\n\e[1mResultado:\e[0m\n\n"
Bank.final_account_balances(accounts)