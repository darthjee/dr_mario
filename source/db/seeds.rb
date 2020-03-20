# frozen_string_literal: true

module Seed
  class DayBuilder
    attr_reader :user, :day, :index

    def self.create(*args)
      new(*args).create
    end

    def initialize(user, day, index)
      @user  = user
      @day   = day
      @index = index
    end

    def create
      user.measurements.where(date: day).create(
        time: time,
        glicemy: Random.rand(50..149)
      )
    end

    private

    def time
      @time ||= format(
        '%<hours>d:%<minutes>02d:%<seconds>02d',
        hours: Random.rand(6..7) + 4 * index,
        minutes: Random.rand(60),
        seconds: Random.rand(60)
      )
    end
  end

  class Day
    attr_reader :days_ago, :user, :times

    def self.populate(*args)
      new(*args).populate
    end

    def initialize(user, days_ago, times)
      @days_ago = days_ago
      @user = user
      @times = times
    end

    def populate
      return if user.measurements.where(date: day).any?

      times.times.each do |hour|
        DayBuilder.create(user, day, hour)
      end
    end

    private

    def day
      @day ||= days_ago.days.ago
    end
  end

  class User
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
        Day.populate(user, days, times)
      end
    end

    private

    def user
      @user ||= create_user
    end

    def create_user
      ::User.find_or_initialize_by(user_attributes).tap do |user|
        user.password = password
        user.save
      end
    end
  end
end

Seed::User.populate(
  user: {
    name: 'User Name',
    login: 'user',
    email: 'email@srv.com',
    password: 'pass'
  }
)

Seed::User.populate(
  user: {
    name: 'Other User',
    login: 'other_user',
    email: 'email2@srv.com',
    password: 'password'
  }
)
