module Rendereable
  extend ActiveSupport::Concern

  def render_basic
    action = params[:action]
    respond_to do |format|
      format.json do
        render json: Serializer.serialize(send("#{action}_resource"))
      end
      format.html { cached_render action }
    end
  end

  def cached_render(view)
    Rails.cache.fetch "render:#{params[:controller]}:#{view}" do
      render view
    end
  end
end
