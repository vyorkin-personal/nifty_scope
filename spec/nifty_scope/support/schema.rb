ActiveRecord::Schema.define do
  self.verbose = true

  create_table :deers, force: true do |t|
    t.string :name
    t.integer :age
    t.integer :weight
    t.boolean :dead, null: false, default: false

    t.timestamps
  end
end
