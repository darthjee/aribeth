module Resourceable
  extend ActiveSupport::Concern
  include Rendereable

  class Builder
    attr_reader :clazz

    def initialize(clazz)
      @clazz = clazz
    end
  end

  class_methods do
    def resource_for(name)
      %i(index show new edit create update).each do |method|
        alias_method method, :render_basic
      end
    end
  end
end
