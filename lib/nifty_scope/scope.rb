require 'nifty_scope/irresponsible_scope'

module NiftyScope
  class Scope
    def initialize(scope, params, options)
      @scope = scope
      @mapping = options[:mapping] || {}
      @params = filter(params, options)
    end

    def apply
      @params.each do |key, value|
        scope_method = scope_method_for(key.to_sym)
        ensure_scope_responds_to(scope_method)

        @scope = eval_scope(scope_method, scope_args(value))
      end

      @scope
    end

    private

    def eval_scope(method, args)
      if method.is_a?(Proc)
        @scope.instance_exec(*args, &method)
      else
        @scope.send(method, *args)
      end
    end

    def scope_args(*args)
      args.delete_if { |arg| !!arg == arg }
    end

    def scope_method_for(key)
      @mapping[key] || key
    end

    def ensure_scope_responds_to(method)
      if method.is_a?(Symbol) && !@scope.respond_to?(method)
        raise IrresponsibleScope, "#{@scope.name} can't respond to ##{method} method"
      end
    end

    def filter(params, options)
      return params.slice(*options[:only])    if options.has_key?(:only)
      return params.except(*options[:except]) if options.has_key?(:except)
      params
    end
  end
end
