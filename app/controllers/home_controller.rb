class HomeController < ApplicationController
  before_action :authenticate_user!, only: %i[home]

  def home
    puts "Current user: #{current_user.inspect}" if Rails.env.development?
    @current_user = current_user
  end
end
