class HomeController < ApplicationController
  before_action :authenticate_user!, only: %i[home]

  def home
    @current_user = current_user
  end
end
