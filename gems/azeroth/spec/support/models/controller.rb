require 'action_controller'

class Controller
  def initialize(params = {})
    @params = ActionController::Parameters.new(params)
  end

  def get(action)
    send("#{action}_resource")
  end

  private

  attr_reader :params
end
