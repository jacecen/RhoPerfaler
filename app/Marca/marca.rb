# The model has already been created by the framework, and extends Rhom::RhomObject
# You can add more methods here
class Marca
  include Rhom::FixedSchema

  set :schema_version, '1.0'
  property :codMarca, :string
  property :marca, :string
  unique_index :marcaPK, [:codMarca] 
end
