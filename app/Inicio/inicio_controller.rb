require 'rho/rhocontroller'
require 'helpers/browser_helper'
require 'helpers/application_helper'

class InicioController < Rho::RhoController
  include BrowserHelper
  include ApplicationHelper


  def index
    unless Marca.find(:all).count > 0
      Rho::Notification.beep()
      Rho::Notification.vibrate()
      Rho::Notification.showStatus("No hay datos", "Debe comunicar", "Cerrar")
      redirect(:controller => :settings, :action => :comunica, :back => "/app") 
    else
      $terminal = Rho::RhoConfig.exist?("terminal") ? Rho::RhoConfig.terminal : ""
      $usuario = Rho::RhoConfig.exist?("usuario") ? Rho::RhoConfig.usuario : ""
      if blank?($terminal) | blank?($usuario)
        Rho::Notification.beep()
        Rho::Notification.vibrate()
        Rho::Notification.showStatus("Zona azul", "Debe asignar un usuario y terminal", "Cerrar")
        redirect(:controller => :utilidades, :action => :parametros, :back => "/app")
      end 
    end
  end
  
end