# frozen_string_literal: true

user = User.find_or_initialize_by(login: 'user', email: 'email@srv.com')
user.password = 'pass'
user.save

4.times.each do |days|
  day = days.days.ago
  next if user.measurements.where(date: day).any?

  3.times.each do |hour|
    time = format(
      '%<hours>d:%<minutes>02d:%<seconds>02d',
      hours: Random.rand(6..7) + 4 * hour,
      minutes: Random.rand(60),
      seconds: Random.rand(60)
    )

    user.measurements.where(date: day).create(
      time: time,
      glicemy: Random.rand(50..149)
    )
  end
end
