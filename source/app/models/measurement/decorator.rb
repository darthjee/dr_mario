# frozen_string_literal: true

class Measurement
  class Decorator < Azeroth::Decorator
    expose :id
    expose :glicemy
    expose :time
    expose :date
    expose :errors, if: :invalid?

    def errors
      object.errors.messages
    end
  end
end

