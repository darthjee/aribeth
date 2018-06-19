class RacesController < ApplicationController
  include Common
  include Azeroth::Resourceable

  resource_for :race

  private

  def race_params
    params.require(:race).permit(:code, :playable)
  end
end
