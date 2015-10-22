# The model has already been created by the framework, and extends Rhom::RhomObject
# You can add more methods here
class NumeroPersonal
  include Rhom::FixedSchema

  set :schema_version, '1.0'
  property :codPersonal, :string
  property :nombre, :string
  unique_index :numeroPersonalPK, [:codPersonal] 
end
