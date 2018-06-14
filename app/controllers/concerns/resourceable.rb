module Resourceable
  extend ActiveSupport::Concern
  include Rendereable

  class_methods do
    def resource_for(name, **options)
      Builder.new(self, name, **options).build
    end
  end
end
