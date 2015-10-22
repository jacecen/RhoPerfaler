# The model has already been created by the framework, and extends Rhom::RhomObject
# You can add more methods here
class TipoSancion
  include Rhom::FixedSchema

  set :schema_version, '1.0'
  property :codigo, :string
  property :descripcion, :string
  property :importe, :float
  unique_index :tipoSancionPK, [:codigo] 

  def descripcionCorta
    unless self.codigo.nil? || self.codigo == "" || self.codigo.length==0
      aux = self.descripcion
      aux[aux.rindex("ART."), aux.length - aux.rindex("ART.")]
    else
      ""
    end
  end

end
