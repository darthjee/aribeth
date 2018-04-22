class RacesController < ApplicationController
  include Common
  # GET /races
  # GET /races.json
  alias_method :index, :render_basic

  # GET /races/1
  # GET /races/1.json
  alias_method :show, :render_basic

  # GET /races/new
  alias_method :new, :render_basic

  # GET /races/1/edit
  alias_method :edit, :render_basic

  # POST /races
  # POST /races.json
  alias_method :create, :render_basic

  # PATCH/PUT /races/1
  # PATCH/PUT /races/1.json
  alias_method :update, :render_basic

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
