# frozen_string_literal: true

class DayPopulator
  attr_reader :days_ago, :user, :times

  def self.populate(*args)
    new(*args).populate
  end

  def initialize(days_ago, user, times)
    @days_ago = days_ago
    @user = user
    @times = times
  end

  def populate
    return if user.measurements.where(date: day).any?

    times.times.each do |hour|
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

  private

  def day
    @day ||= days_ago.days.ago
  end
end

class UserPopulator
  attr_reader :user_attributes, :days, :times, :password

  def self.populate(**args)
    new(**args).populate
  end

  def initialize(user:, days: 4, times: 3)
    @password = user.delete(:password)
    @user_attributes = user
    @days = days
    @times = times
  end

  def populate
    days.times.each do |days|
      DayPopulator.populate(days, user, times)
    end
  end

  private

  def user
    @user ||= create_user
  end

  def create_user
    User.find_or_initialize_by(user_attributes).tap do |user|
      user.password = password
      user.save
    end
  end
end

UserPopulator.populate(
  user: { name: 'User Name', login: 'user', email: 'email@srv.com', password: 'pass' }
)
