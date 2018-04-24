class ResourceController < ApplicationController
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
end
