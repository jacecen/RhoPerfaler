class Sancion
  include Rhom::FixedSchema
  set :schema_version, '1.0'
  property :numOrden, :integer
  property :matricula, :string
  property :dia, :date
  property :hora, :time
  property :codCalle, :string
  property :numero, :string
  property :codSancion, :string
  property :agente, :string
  property :anyo, :string
  property :marca, :string
  property :tipoVehiculo, :string
  property :color, :string
  property :frenteJunto, :string
  property :zona, :string
  property :modelo, :string
  property :epigrafe, :string
  property :numFoto1, :string
  property :numFoto2, :string
  property :tipoMatricula, :string
  property :terminal, :integer
  property :generada, :integer
  property :idRemesa, :integer
  property :estado, :string
  property :numeroFJ, :string
  
  def nombreMarca
    self.marca.nil? || self.marca == "" || self.marca.length==0  ? "" : Marca.find(:first, :conditions => {:codMarca => self.marca}).marca 
  end
  
  def nombreTipoVehiculo
    self.tipoVehiculo.nil? || self.tipoVehiculo == "" || self.tipoVehiculo.length==0  ? "" : TipoVehiculo.find(:first, :conditions => {:codVehicul => self.tipoVehiculo}).descripcion 
  end
  
  def nombreTipoMatricula
    self.tipoMatricula.nil? || self.tipoMatricula == "" || self.tipoMatricula.length==0  ? "" : case self.tipoMatricula
    when "N"
      "Normal"
    when "E"
      "Extranjera"
    when "M"
      "Mensual"
    when "S"
      "Semestral"
    when "T"
      "Temporal"
    when "R"
      "Remolque"
    when  "O"
      "Otra"
    else
      ""
    end
  end

  def nombreCalle
    self.codCalle.nil? || self.codCalle == "" || self.codCalle.length==0  ? "" : Calle.find(:first, :conditions => {:codCalle => self.codCalle}).nombreCalle 
  end

  def nombreTipoSancion
    self.codSancion.nil? || self.codSancion == "" || self.codSancion.length == 0  ? "" : TipoSancion.find(:first, :conditions => {:codigo => self.codSancion}).descripcion 
  end
  
  def nombreColor
    self.color.nil? || self.color == "" || self.color.length == 0  ? "" : Color.find(:first, :conditions => {:codColor => self.color}).color 
  end

  def nombreTipoSancionCorto
    unless self.codSancion.nil? || self.codSancion == "" || self.codSancion.length == 0
      aux = self.nombreTipoSancion
      aux[aux.rindex("ART."), aux.length - aux.rindex("ART.")]
    else
      ""
    end
  end
  
  def fechaHora
    unless self.dia.nil? || self.dia == ""
      unless self.hora.nil? || self.hora == ""
        Time.at(self.dia).strftime("%d/%m/%Y") + " " + Time.at(self.hora).strftime("%H:%M")
      end
    end
  end
  
  def direccion
    unless self.nombreCalle.nil? || self.nombreCalle == "" || self.nombreCalle.length == 0
      unless self.numero.nil? || self.numero == "" || self.numero.length == 0
        self.nombreCalle + ", " + self.numero
      else
        self.nombreCalle
      end
    end
  end

end
