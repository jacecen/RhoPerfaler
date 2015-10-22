# The model has already been created by the framework, and extends Rhom::RhomObject
# You can add more methods here
class TipoVehiculo
  include Rhom::FixedSchema

  set :schema_version, '1.0'
  property :codVehicul, :string
  property :descripcion, :string
  unique_index :tipoVehiculoPK, [:codVehicul] 
end
