class RacesController < ApplicationController
  include Common
  # GET /races
  # GET /races.json
  alias_method :index, :render_basic

  # GET /races/1
  # GET /races/1.json
  alias_method :show, :render_basic

  # GET /races/new
  def new
    render_basic
  end

  # GET /races/1/edit
  def edit
    render_basic
  end

  # POST /races
  # POST /races.json
  def create
    render json: created_race.as_json
  end

  # PATCH/PUT /races/1
  # PATCH/PUT /races/1.json
  def update
    render json: updated_race.as_json
  end

  # DELETE /races/1
  # DELETE /races/1.json
  def destroy
    race.destroy
    head :no_content
  end

  private

  def new_resource
    {}
  end

  def created_race
    @created_race ||= Race.create(race_params)
  end

  def updated_race
    @updated_race ||= race.tap { |v| v.update(race_params) }
  end

  def index_resource
    Race.all
  end

  def show_resource
    race
  end

  def race
    @race ||= Race.find(race_id)
  end

  def race_id
    params.require(:id)
  end

  def race_params
    params.require(:race).permit(:code, :playable)
  end

  alias_method :edit_resource, :show_resource
end
