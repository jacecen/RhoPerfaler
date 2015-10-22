class Modelo
  include Rhom::FixedSchema
  set :schema_version, '1.0'
  property :modelo, :string
  property :codMarca, :string
end
