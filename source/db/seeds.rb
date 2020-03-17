# frozen_string_literal: true

user = User.find_or_initialize_by(login: 'user', email: 'email@srv.com')
user.password = 'pass'
user.save
