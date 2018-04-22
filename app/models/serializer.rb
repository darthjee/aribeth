module Serializer
  def self.serialize(object)
    case object
    when Mongoid::Document
      Serializer::Mongo.new(object).as_json
    when Mongoid::Criteria
      object.map { |o| Serializer::Mongo.new(o).as_json }
    when ActiveRecord::Base
      object.as_json
    when Hash
      object
    else
      object.as_json
    end
  end
end
