# frozen_string_literal: true

require_relative "candy/version"
require_relative "candy/formatter"
require_relative "candy/coverage"

module RSpec
  module Candy
    class Error < StandardError; end
  end
end
