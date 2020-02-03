# frozen_string_literal: true

class Settings
  extend Sinclair::EnvSettable

  settings_prefix 'DR_MARIO'

  with_settings(
    :password_salt,
    hex_code_size: 4
  )
end