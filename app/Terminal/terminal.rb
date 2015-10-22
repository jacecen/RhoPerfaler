# The model has already been created by the framework, and extends Rhom::RhomObject
# You can add more methods here
class Terminal
  include Rhom::FixedSchema

  set :schema_version, '1.0'
  property :idEmpleado, :integer
  property :idZona, :integer
end
