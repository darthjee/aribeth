module Resourceable
  extend ActiveSupport::Concern
  include Rendereable

  class_methods do
    def resource_for(name)
      Builder.new(self, name).build
    end
  end
end
