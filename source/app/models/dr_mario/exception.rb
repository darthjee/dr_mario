# frozen_string_literal: true

module DrMario
  class Exception < StandardError
    class LoginFailed < DrMario::Exception; end
  end
end
