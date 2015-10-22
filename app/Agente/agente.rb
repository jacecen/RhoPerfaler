# The model has already been created by the framework, and extends Rhom::RhomObject
# You can add more methods here
class Agente
  include Rhom::FixedSchema
  
  set :schema_version, '1.0'
  property :codAgente, :string
  property :nombre, :string
  property :apellidos, :string
  
  def nombreCompleto
    unless self.nombre.nil? || self.nombre == "" || self.nombre.length == 0
      unless self.apellidos.nil? || self.apellidos == "" || self.apellidos.length == 0
        self.nombre + " " + self.apellidos
      else
        self.nombre
      end
    end
  end

end
