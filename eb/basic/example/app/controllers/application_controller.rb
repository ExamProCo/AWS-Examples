class ApplicationController < ActionController::Base
  def home
    @things = Thing.all
  end
end
