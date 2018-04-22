class Serializer::Mongo
  attr_reader :resource

  def initialize(resource)
    @resource = resource
  end

  def as_json
    resource.as_json
  end
end
