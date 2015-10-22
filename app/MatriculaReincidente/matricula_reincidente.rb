# The model has already been created by the framework, and extends Rhom::RhomObject
# You can add more methods here
class MatriculaReincidente
  include Rhom::FixedSchema

  set :schema_version, '1.0'
  property :matricula, :string
  property :descripcion, :string
  property :numApariciones, :integer
  property :ultimaSancion, :date
  unique_index :matriculaReincidentePK, [:matricula] 

  def fechaUltimaSancion
    unless self.ultimaSancion.nil? || self.ultimaSancion == ""
      self.ultimaSancion[0,10]
    end
  end
  
end
