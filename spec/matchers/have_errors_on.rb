module Smartdict
  module Matchers

    class HaveErrorsOn
      def initialize(property)
	@property = property
      end

      def matches?(model)
	@model = model
	@model.valid?
	!@model.errors[@property].empty?
      end

      def failure_message
	"expected #{@model.inspect} to have errors on #{@property}"
      end

      def negative_failure_message
	"expected #{@model.inspect} to have no errors on #{@property}"
      end
    end

    def have_errors_on(property)
      HaveErrorsOn.new(property)
    end

  end
end
