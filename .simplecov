require 'simplecov'
require 'simplecov-vim/formatter'


module SimpleCov::Formatter
  class MergedFormatter
    def initialize
      @formatters = [HTMLFormatter, VimFormatter].map{|frmt| frmt.new}
    end

    def format(result)
      @formatters.each{|frmt| frmt.format(result)}
    end
  end
end

SimpleCov.start do
  formatter SimpleCov::Formatter::MergedFormatter
end
