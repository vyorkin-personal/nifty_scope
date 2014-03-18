class Deer < ActiveRecord::Base
  scope :over_21,   -> { where('age > 21') }
  scope :with_name, ->(name) { where(name: name) }

  scope :dead,  -> { where(dead: true) }
  scope :alive, -> { where(dead: false) }
end
