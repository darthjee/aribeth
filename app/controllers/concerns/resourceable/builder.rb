module Resourceable
  class Builder < Sinclair
    delegate :resource, to: :options_object

    def initialize(clazz, resource)
      super(clazz, resource: resource.to_s)
    end

    def build
      add_resource
      add_resource_for_routes
      super
    end

    private

    def add_resource
      add_method(resource_plural,  "@#{resource_plural} ||= #{resource_class}.all")
      add_method(resource,         "@#{resource} ||= #{resource_plural}.find(#{resource}_id)")
      add_method("#{resource}_id", "params.require(:id)")
    end

    def add_resource_for_routes
      add_method(:new_resource,    "@new_resource ||= #{resource_class}.new")
      add_method(:create_resource, "@create_resource ||= #{resource_class}.create(#{resource}_params)")
      add_method(:update_resource, "@update_resource ||= #{resource}.tap { |v| v.update(#{resource}_params) }")
      add_method(:index_resource,  resource_plural)
      add_method(:edit_resource,   resource)
      add_method(:show_resource,   resource)
    end

    def resource_class
      @resource_class ||= resource.camelize.constantize
    end

    def resource_plural
      resource.pluralize
    end
  end
end
