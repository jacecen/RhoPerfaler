# The model has already been created by the framework, and extends Rhom::RhomObject
# You can add more methods here
class MatriculaEspecial
  include Rhom::FixedSchema

  set :schema_version, '1.0'
  property :matricula, :string
  property :descripcion, :string
  unique_index :matriculaEspecialPK, [:matricula] 
end
