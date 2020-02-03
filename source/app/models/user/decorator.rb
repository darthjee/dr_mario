# frozen_string_literal: true

class User < ApplicationRecord
  class Decorator < Azeroth::Decorator
    expose :email
    expose :login

    expose :errors, if: :invalid?

    def errors
      object.errors.messages.stringify_keys
    end
  end
end
