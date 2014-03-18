require 'spec_helper'

describe NiftyScope do
  before(:all) do
    create(:deer)
    create(:deer, :dead => true)
    create(:deer, :name => 'cunt')
  end

  context 'with parametrized scope' do
    let!(:params) { { name: 'cunt' } }
    let!(:deers) do
      Deer.nifty_scope(params,
        mapping: {
          name: ->(name) { with_name(name) }
        }, only: [:name]
      )
    end

    it 'calls appropriate scope method' do
      expect(deers.count).to eq(1)
    end
  end

  context 'with parameterless scope' do
    let!(:params) { { :dead => true } }

    context 'when mapping is specified' do
      let!(:deers) { Deer.nifty_scope(params, only: [:dead]) }

      it 'calls appropriate scope method' do
        expect(deers.count).to eq(1)
      end
    end

    context 'when mapping is not specified' do
      let!(:deers) { Deer.nifty_scope(params) }

      it 'calls appropriate scope method' do
        expect(deers.count).to eq(1)
      end
    end
  end
end
