require 'nifty_scope/scope'
require 'nifty_scope/version'

module NiftyScope
  extend ActiveSupport::Concern

  module ClassMethods
    def nifty_scope(params, options = {})
      Scope.new(where(nil), params, options).apply
    end
  end
end

ActiveRecord::Base.class_eval do
  include NiftyScope
end
