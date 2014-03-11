require 'spec_helper'

describe NiftyScope do

  before(:all) do
    params = { name: 'cunt' }

    create_list(:deer, 3)
    create(:deer, :name => 'cunt')

    @deers = Deer.nifty_scope(params,
      mapping: {
        name: ->(name) { with_name(name) }
      }, only: [:name]
    )
  end

  it 'calls appropriate scope method' do
    expect(@deers.count).to eq(1)
  end
end
