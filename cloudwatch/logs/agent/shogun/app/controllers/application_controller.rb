class ApplicationController < ActionController::API
  def john_blackthorne
    render json: {name: "John Blackthrone"}
  end 

  def lord_toranaga
    render json: {name: "Lord Toranaga"}
  end

  def mariko
    render json: {name: "Markio"}
  end

  def father_alvito
    render json: {name: "Falter Alvito"}
  end

  def lady_fujiko
    render json: {name: "Lady Fujiko"}
  end

  def omi
    render json: {name: "Omi"}
  end

  def ishido
    render json: {name: "Ishido"}
  end

  def lord_yabu
    render json: {name: "Log Yabu"}
  end

  def buntaro
    render json: {name: "Buntaro"}
  end

  def kiku
    render json: {name: "Kiku"}
  end
end