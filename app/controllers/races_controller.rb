class RacesController < ApplicationController
  include Common
  include Resourceable

  resource_for :race

  # DELETE /races/1
  # DELETE /races/1.json
  def destroy
    race.destroy
    head :no_content
  end

  private

  def race_params
    params.require(:race).permit(:code, :playable)
  end
end
