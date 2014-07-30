require 'pry-byebug'
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

  context 'with mappings to boolean scope' do
    let!(:paramsless_deers) do
      Deer.nifty_scope(params, mapping: {
        is_alive: -> { alive }
      })
    end
    let!(:paramsfull_deers) do
      Deer.nifty_scope(params, mapping: {
        is_alive: ->(value) { value ? alive : dead }
      })
    end

    describe 'show me alive deers' do
      let!(:params) { { is_alive: true } }

      it 'should return two alive deers with parameterfull mapping' do
        expect(paramsfull_deers.count).to eq(2)
      end

      it 'should return two alive deers with parameterless mapping' do
        expect(paramsless_deers.count).to eq(2)
      end
    end

    describe 'show me dead deers' do
      let!(:params) { { is_alive: false} }

      it 'should return two alive deers with parameterfull mapping' do
        expect(paramsfull_deers.count).to eq(1)
      end

      it 'should return two alive deers with parameterless mapping' do
        expect(paramsless_deers.count).to eq(3)
      end
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
