class Race
  include Mongoid::Document
  field :code, type: String
  field :playable, type: Boolean

  validates_presence_of :code
end
