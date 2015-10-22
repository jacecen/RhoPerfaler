require 'rho/rhocontroller'
require 'helpers/browser_helper'
require 'helpers/application_helper'

class UtilidadesController < Rho::RhoController
  include BrowserHelper
  include ApplicationHelper

  def index
  end
  
  def parametros
    @password = Rho::RhoConfig.exist?("password") ? Rho::RhoConfig.password : ""
    @terminal = Rho::RhoConfig.exist?("terminal") ? Rho::RhoConfig.terminal : ""
    @numOrden = Rho::RhoConfig.exist?("numOrden") ? Rho::RhoConfig.numOrden : ""
    @usuario = Rho::RhoConfig.exist?("usuario") ? Rho::RhoConfig.usuario : ""
    render(:action => :parametros, :back => url_for(:action => :index))
  end
  
  def updateParametros
    Rho::RhoConfig.terminal = @params["parametros-terminal"]
    Rho::RhoConfig.usuario = @params["parametros-usuario"]
    Rho::RhoConfig.numOrden = @params["parametros-numOrden"]
    render(:action => :index)
  end
  
  def password
    @password = Rho::RhoConfig.exist?("password") ? Rho::RhoConfig.password : ""
    render(:action => :password, :back => url_for(:action => :index))
  end
  
  def updatePassword
    Rho::RhoConfig.password = @params["newPassword"]
    render(:action => :index)
  end
  
  def parametrosComunica
    @password = Rho::RhoConfig.exist?("password") ? Rho::RhoConfig.password : ""
    @url = Rho::RhoConfig.exist?("remotePath") ? Rho::RhoConfig.remotePath : ""
    render(:action => :parametrosComunica, :back => url_for(:action => :index))
  end
  
  def updateParametrsComunica
    Rho::RhoConfig.remotePath = @params["url"]
    render(:action => :index)
  end
  
  def impresora
    @password = Rho::RhoConfig.exist?("password") ? Rho::RhoConfig.password : ""
    @impresoraId = Rho::RhoConfig.exist?("impresoraId") ? Rho::RhoConfig.impresoraId : ""
    @impresoraNombre = Rho::RhoConfig.exist?("impresoraNombre") ? Rho::RhoConfig.impresoraNombre : ""
    render(:action => :impresora, :back => url_for(:action => :index))
  end
  
  def buscaImpresoras
    $printers=[]
    parms = {:connectionType => "CONNECTION_TYPE_BLUETOOTH", :printerType => "PRINTER_TYPE_ANY"}
    Rho::Printer.searchPrinters(parms, url_for(:action => :findPrinterCallback))
  end
  
  def findPrinterCallback
    if @params['status'] == 'PRINTER_STATUS_SUCCESS'
      if defined?(@params['printerID'])
        printer = Rho::Printing.getPrinterByID(@params['printerID'])
        $printers.push({:ID => @params['printerID'], :name => printer['deviceName']})
      else
        puts "Done Searching"
      end
    else
      puts @params['status']
    end
  end


end