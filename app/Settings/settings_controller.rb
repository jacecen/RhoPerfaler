require 'rho'
require 'rho/rhocontroller'
require 'rho/rhoerror'
require 'helpers/browser_helper'

class SettingsController < Rho::RhoController
  include BrowserHelper
  
  def index
    @msg = @params['msg']
    render
  end

    
  def reset
    render :action => :reset
  end
  
  def do_reset
    Rhom::Rhom.database_full_reset
    @msg = "Todos los datos se han borrado"
    redirect(:action => :index, :query => {:msg => @msg})
  end
  
  def comunica
    unless Rho::RhoConfig.exists?("remotePath")
      Rho::Notification.showStatus("Comunicaciones","No hay configurado un equipo remoto","Cancelar")
      WebView.navigate(Rho::Application.startURI)
    else 
      unless Rho::Network.hasNetwork()
        Rho::Notification.showStatus("Comunicaciones","No hay conexión de red","Cancelar")
        WebView.navigate(Rho::Application.startURI)
      else
        @remote = Rho::RhoConfig.remotePath
        resultado = Rho::Network.get({:url => @remote + "/Test"}) 
        unless resultado["status"] == "ok"
          Rho::Notification.showStatus("Comunicaciones","No hay conexión con servidor","Cancelar")
          WebView.navigate(Rho::Application.startURI)
        else
          data = Sancion.find(:all, :conditions => {:estado => ""}, :order => [:numOrden])
          if (data ? data.count > 0 : nil)
            options = {
              :url => @remote + "/PutData/?data="+data.to_json,
              :header => {
                "Content-Type" => "application/json; charset=utf-8",
                "Accept" => "application/json"
              },
              :httpVerb => "GET"
            }
            Rho::Network.get(options, url_for(:action => :putData_callback))
          end
#          Rho::Network.get({:url => @remote + "/GetData"}, url_for(:action => :getData_callback))
          render(:action => :comunica)
        end
      end
    end
  end
  
  def putData_callback
    @params["body"]
  end
  
  def getData_callback
    unless @params["status"] == "ok"
      Rho::WebView.executeJavascript('ponDatos(' + @params["error"] + ', "", "", "")')
      sleep 5
    else       
      datos = @params["body"].sub(
        "<?xml version=\"1.0\" encoding=\"utf-8\"?>",""
      ).sub(
        "<string xmlns=\"http://tempuri.org/\">",""
      ).sub(
        "</string>",""
      ).sub(
        "\n",""
      ).sub(
        "\r","")
      resultado = Rho::JSON.parse(datos)
      numTablas = resultado.count
      resultado.each_index do |k|
        nomtabla = resultado[k][0]
        case nomtabla
          when "agente"
            Agente.delete_all()
          when "calle"
            Calle.delete_all()
          when "color"
            Color.delete_all()
          when "marca"
            Marca.delete_all()
          when "matriculaEspecial"
            MatriculaEspecial.delete_all()
          when "matriculaReincidente"
            MatriculaReincidente.delete_all()
          when "modelo"
            Modelo.delete_all()
          when "numeroPersonal"
            NumeroPersonal.delete_all()
          when "terminal"
            Terminal.delete_all()
          when "tipoSancion"
            TipoSancion.delete_all()
          when "tipoVehiculo"
            TipoVehiculo.delete_all()
        end
        numRegistros = resultado[k][1].count
        intervalo = numRegistros / 50
        intervalo = 2 if intervalo < 2
        resultado[k][1].each_index do |j|
          record = Hash.new
          resultado[k][1][j].each_index do |i|
            if i > 0
              record[resultado[k][1][j][i][0].to_sym] = resultado[k][1][j][i][1]
            end
          end
          case nomtabla
            when "agente"
              Agente.create(record)
            when "calle"
              Calle.create(record)
            when "color"
              Color.create(record)
            when "marca"
              Marca.create(record)
            when "matriculaEspecial"
              MatriculaEspecial.create(record)
            when "matriculaReincidente"
              MatriculaReincidente.create(record)
            when "modelo"
              Modelo.create(record)
            when "numeroPersonal"
              NumeroPersonal.create(record)
            when "terminal"
              Terminal.create(record)
            when "tipoSancion"
              TipoSancion.create(record)
            when "tipoVehiculo"
              TipoVehiculo.create(record)
          end
          if (j + 1) % intervalo == 0
            Rho::WebView.executeJavascript(
              "ponDatos('', '" + "#{(k + 1).to_s} / #{numTablas.to_s}" + "', '" + nomtabla + "', '" +
              "#{(j + 1).to_s} / #{numRegistros.to_s}" + "')")
          end
        end
      end
      Rho::Notification.showStatus("Comunicaciones","Terminado correctamente","Ok")
    end
    WebView.navigate(Rho::Application.startURI)
  end

end
