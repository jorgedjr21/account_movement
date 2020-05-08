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
end