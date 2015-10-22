require 'rho/rhocontroller'
require 'helpers/browser_helper'
require 'helpers/application_helper'
require 'date'

class SancionController < Rho::RhoController
  include BrowserHelper
  include ApplicationHelper

  def index
    @sanciones = Sancion.find_by_sql("SELECT * FROM sancion ORDER BY numOrden DESC limit 10")
#    if @sanciones.count > 10
#      @sanciones = @sanciones.last(10)
#    end
    @pagina = "index"
    render(:back => "/app")
  end

  def indexAll
    @sanciones = Sancion.find(:all, :order => [:numOrden], :orderdir => ["DESC"])
    @pagina = "indexAll"
    render(:action => :index, :back => "/app")
  end

  def show
    @sancion = Sancion.find(@params['id'])
    if @sancion
      render(:action => :show, :back => url_for(:action => :index))
    else
      redirect(:action => :index)
    end
  end

  def new
    $sancion = Sancion.new
    $numOrden = Rho::RhoConfig.exist?("numOrden") ? (Rho::RhoConfig.numOrden.to_i + 1 <= 99999 ? Rho::RhoConfig.numOrden.to_i + 1 : 1) : 1
    $sancion.numOrden = sprintf("%0.2d", $terminal.to_i) + sprintf("%0.5d", $numOrden.to_i)
    $sancion.estado = ""
    render(:action => :new, :back => url_for(:action => :index))
  end

  def create
    $sancion.matricula = @params["sancion-matricula"].upcase
    $sancion.tipoMatricula = @params["sancion-tipoMatricula"]
    $sancion.tipoVehiculo = @params["sancion-tipoVehiculo"]
    $sancion.marca = @params["sancion-marca"]
    $sancion.modelo = @params["sancion-modelo"]
    $sancion.color = @params["sancion-color"]
    $sancion.codCalle = @params["sancion-codCalle"]
    $sancion.numero = @params["sancion-numero"]
    $sancion.codSancion = @params["sancion-codSancion"]
    $sancion.dia = Date.today.to_time.to_i
    $sancion.hora = Time.now.to_i
    $sancion.agente = $usuario
    $sancion.terminal = $terminal
    $sancion.save
    Rho::RhoConfig.numOrden = $numOrden
    redirect(:action => :index)
  end

  def update
    @sancion = Sancion.find(@params['id'])
    @sancion.update_attributes(@params['sancion']) if @sancion
    redirect(:action => :index)
  end

  def delete
    @sancion = Sancion.find(@params['id'])
    @sancion.destroy if @sancion
    redirect(:action => :index)  
  end

  def cargaModelos
    aux = Modelo.find(:all, :conditions => {:codMarca => @params["marca"]}, :order => [:modelo], :select => [:modelo]).inject([]) do |resultado, elemento|
      resultado.push(elemento.modelo)
      resultado
    end
    @response["headers"]["Content-Type"] = "application/json; charset=utf-8"  
    return render(:string => aux.to_json, :layout => false)
  end
  
  def verificaMatricula
    if MatriculaEspecial.find(:first, :conditions => {{:func => 'UPPER', :name => 'matricula'} => @params["matricula"]})
      return render(:string => ::JSON.generate({:especial => true}), :layout => false)
    end
    aux = MatriculaReincidente.find_by_sql("SELECT * FROM MatriculaReincidente WHERE RTRIM(UPPER(matricula)) ='" + @params["matricula"] +"'")
    if aux.length>0
      return render(:string => ::JSON.generate({:especial => false, :reincidente => true, :numApariciones => aux[0].numApariciones, :ultimaSancion => aux[0].fechaUltimaSancion}), :layout => false)
    else
      return render(:string => ::JSON.generate({:especial => false, :reincidente => false}), :layout => false)
    end
  end
  
end
