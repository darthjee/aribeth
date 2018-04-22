module Serializer
  def self.serialize(object)
    case object
    when Mongoid::Document
      Serializer::Mongo.new(object).as_json
    when ActiveRecord::Base
      object.as_json
    when Hash
      object
    else
      object.as_json
    end
  end
end
