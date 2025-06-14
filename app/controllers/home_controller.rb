class HomeController < ApplicationController
  before_action :authenticate_user!, only: %i[index]

  def index
    puts "Current user: #{current_user.inspect}" if Rails.env.development?
    @current_user = current_user
  end
end
