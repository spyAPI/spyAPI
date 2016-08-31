class WelcomeController < ApplicationController

  def index
    @apis = Api.all
  end

end
