require_relative '../bank'

RSpec.describe Bank do
  describe '#open_csv' do
    context 'with valid params' do
      it 'reading accounts csv' do
        read_csv = Bank.open_csv('contas.csv')
        expect(read_csv[:status]).to eq(:ok)
        expect(read_csv[:data]).to eq(
          [
            ['123', '13052'],
            ['456', '20000'],
            ['10', '-10000'],
            ['11', '000']
          ]
        )
      end

      it 'reading transactions csv' do
        read_csv = Bank.open_csv('transacoes.csv', 'transacoes')
        expect(read_csv[:status]).to eq(:ok)
        expect(read_csv[:data]).to eq(
          [
            ['123', '-5300'],
            ['11', '2571'],
            ['456', '-100'],
            ['123', '-5300'],
            ['123', '-5352'],
            ['123', '350000'],
          ]
        )
      end
    end

    context 'with invalid params' do
      it 'must not read the csv' do
        read_csv = Bank.open_csv('wrong.csv')
        expect(read_csv[:status]).to eq(:error)
        expect(read_csv[:data]).to be_nil
      end
    end
  end

  describe '#process_accounts' do
    context 'with loaded csv' do
    let(:accounts) { Bank.open_csv('contas.csv')[:data] }

      it 'must process them' do
        acc = Bank.process_accounts(accounts)
        expect(acc["123"]).to eq(13052)
        expect(acc["10"]).to eq(-10000)
      end
    end
  end

  describe '#process_account_transactons' do
    context 'with load csvs' do
    let(:accounts) { Bank.process_accounts(Bank.open_csv('contas.csv')[:data]) }
    let(:transactions) { Bank.open_csv('transacoes.csv','transacoes')[:data] }

      it 'must process them' do
        acc = Bank.process_account_transactons(accounts, transactions)
        expect(acc["123"]).to eq(346800)
        expect(acc["10"]).to eq(-10000)
        expect(acc["11"]).to eq(2571)
      end
    end
  end

  describe '#final_account_balances' do
    context 'with processed files' do
      let(:accounts) { Bank.process_accounts(Bank.open_csv('contas.csv')[:data]) }
      let(:transactions) { Bank.open_csv('transacoes.csv','transacoes')[:data] }

      it 'must print the final result formated' do
        acc = Bank.process_account_transactons(accounts, transactions)
        expect { Bank.final_account_balances(acc) }.to output.to_stdout
        expect { Bank.final_account_balances(acc) }.to output(/123,346800/).to_stdout
        expect { Bank.final_account_balances(acc) }.to output(/456,19900/).to_stdout
        expect { Bank.final_account_balances(acc) }.to output(/10,-10000/).to_stdout
        expect { Bank.final_account_balances(acc) }.to output(/11,2571/).to_stdout
      end
    end
  end
end