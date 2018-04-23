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

  def new_resource
    @new_resource ||= Race.new
  end

  def create_resource
    @create_resource ||= Race.create(race_params)
  end

  def update_resource
    @update_resource ||= race.tap { |v| v.update(race_params) }
  end

  def race
    @race ||= races.find(race_id)
  end

  def races
    @races ||= Race.all
  end

  def race_id
    params.require(:id)
  end

  def race_params
    params.require(:race).permit(:code, :playable)
  end

  alias_method :index_resource, :races
  alias_method :edit_resource, :race
  alias_method :show_resource, :race
end
