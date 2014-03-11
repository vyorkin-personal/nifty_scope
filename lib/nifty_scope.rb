require "nifty_scope/version"

module NiftyScope
  extend ActiveSupport::Concern

  module ClassMethods
    def nifty_scope(params, options = {})
      if options.has_key?(:only)
        options[:only] = Array(options[:only])
        params.slice!(*options[:only])
      elsif options.has_key?(:except)
        options[:except] = Array(options[:except])
        params.except!(*options[:except])
      end

      mapping ||= options[:mapping] || {}
      scope = where(nil)

      params.each do |(key, value)|
        key = key.to_sym
        scope_method = if mapping.has_key?(key)
          mapping[key]
        else
          key
        end
        if scope_method.is_a?(Symbol) && !scope.respond_to?(scope_method)
          raise IrresponsibleScope, "#{scope.name} can't respond to ##{scope_method} method"
        end

        scope = if scope_method.is_a?(Proc)
          scope.instance_exec(value, &scope_method)
        else
          scope.send(scope_method, value)
        end
      end
      scope
    end
  end

  class IrresponsibleScope < Exception
  end
end

ActiveRecord::Base.class_eval do
  include NiftyScope
end
