# frozen_string_literal: true

user = User.find_or_initialize_by(login: 'user', email: 'email@srv.com')
user.password = 'pass'
user.save

4.times.each do |days|
  day = days.days.ago
  next if user.measurements.where(date: day).any?

  3.times.each do |hour|
    time = "%d:%02d:%02d" % [Random.rand(2) + 6 + 4 * hour, Random.rand(60), Random.rand(60)]

    user.measurements.where(date: day).create(
      time: time,
      glicemy: Random.rand(100) + 50
    )
  end
end
