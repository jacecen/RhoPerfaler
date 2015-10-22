require 'rho/rhoapplication'

class AppApplication < Rho::RhoApplication

  def initialize
    # Tab items are loaded left->right, @tabs[0] is leftmost tab in the tab-bar
    # Super must be called *after* settings @tabs!
    @tabs = nil
    #To remove default toolbar uncomment next line:
    @@toolbar = nil
    super
    @default_menu = {
      "Acerca de" => '/app/Compania',
      "Inicio" => Rho::Application.startURI,
      "Opciones" => '/app/Settings',
      "Ver Log" => :log,
      "Salir" => :close
    };
  end

end