# The model has already been created by the framework, and extends Rhom::RhomObject
# You can add more methods here
class Color
  include Rhom::FixedSchema

  set :schema_version, '1.0'
  property :codColor, :string
  property :color, :string
  unique_index :colorPK, [:codColor] 

end
