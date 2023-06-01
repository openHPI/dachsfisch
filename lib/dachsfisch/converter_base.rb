# frozen_string_literal: true

module Dachsfisch
  class ConverterBase
    def self.perform(**args)
      new(**args).execute
    end
  end
end
