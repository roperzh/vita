require "ohm"
require "ohm/timestamps"
require "ohm/datatypes"

class Profile < Ohm::Model

  include Ohm::Timestamps
  include Ohm::DataTypes

  attribute :avatar
  attribute :full_name
  attribute :headline
  attribute :skills,     Type::Array
  attribute :educations, Type::Array
  attribute :skills,     Type::Array
  attribute :educations, Type::Array
  attribute :positions,  Type::Array
  attribute :projects,   Type::Array
  attribute :courses,    Type::Array

end
