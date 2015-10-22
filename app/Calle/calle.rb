class Calle
  include Rhom::FixedSchema

  set :schema_version, '1.0'
  property :codCalle, :string
  property :nombreCalle, :string
  property :zona, :string
  unique_index :callePK, [:codCalle] 

end
