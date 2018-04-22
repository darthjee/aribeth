class Serializer::Mongo
  attr_reader :resource

  def initialize(resource)
    @resource = resource
  end

  def as_json
    return criteria_as_json if resource.respond_to?(:map)
    document_as_json
  end

  private

  def document_as_json
    resource.as_json.tap do |hash|
      hash['id'] = resource.to_param
    end
  end

  def criteria_as_json
    resource.map do |entry|
      Serializer::Mongo.new(entry).as_json
    end
  end
end
