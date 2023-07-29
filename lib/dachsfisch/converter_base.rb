# frozen_string_literal: true

module Dachsfisch
  class ConverterBase
    def self.perform(**)
      new(**).execute
    end
  end
end
