module Resourceable
  extend ActiveSupport::Concern
  include Rendereable

  class Builder < Sinclair
    delegate :resource, to: :options_object

    def build
      add_method(resource_plural,  "@#{resource_plural} ||= #{resource_class}.all")
      add_method(resource,         "@#{resource} ||= #{resource_plural}.find(#{resource}_id)")
      add_method("#{resource}_id", "params.require(:id)")

      add_method(:new_resource,    "@new_resource ||= #{resource_class}.new")
      add_method(:create_resource, "@create_resource ||= #{resource_class}.create(#{resource}_params)")
      add_method(:update_resource, "@update_resource ||= #{resource}.tap { |v| v.update(#{resource}_params) }")
      add_method(:index_resource,  resource_plural)
      add_method(:edit_resource,   resource)
      add_method(:show_resource,   resource)
      super
    end

    private

    def resource_class
      @resource_class ||= resource.camelize.constantize
    end

    def resource_plural
      resource.pluralize
    end
  end

  class_methods do
    def resource_for(name)
      Builder.new(self, resource: name.to_s).build

      %i(index show new edit create update).each do |method|
        alias_method method, :render_basic
      end
    end
  end
end
