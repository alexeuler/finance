class HomeController < ApplicationController
  skip_before_action :require_admin
  def show
  end
end
