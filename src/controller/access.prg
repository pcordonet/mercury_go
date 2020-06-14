
CLASS Access

    METHOD Auth( oController )
    METHOD Logout( oController )

ENDCLASS

METHOD Auth( oController ) CLASS Access
local oValidator := TValidator():New()
local hRoles := { 'user' => 'required|string|maxlen:8|minlen:1' , 'psw' => 'required'}
local hFormat := { 'user' => 'lower' }
local hData := {=>}
local hToken := {=>}
local aRows

// Recupero Datos -----------------------------------------------
hData[ 'user'] := oController:oRequest:Post( 'user' )
hData[ 'psw' ] := oController:oRequest:Post( 'psw' )

// Valido datos --------------------------------------------------
if ! oValidator:Run( hRoles )
    oController:View( 'login.view', oValidator:ErrorString() )
    return nil
endif

oValidator:Formatter( hData, hFormat )
// Comprobar identidad -------------------------------------------
if hData[ 'user'] == 'demo' .and. hData[ 'psw'] == '1234'
    // Entro datos opcionales, que los puedo consultar cada vez que entren
    // No se ha de poner informacion sensible...
    hToken := { 'in' => time(), 'user' => hData[ 'user' ] }
    // Inicamos nuestro sistema de Validación del sistema basado en JWT
    oController:oMiddleware:SetAutenticationJWT( hToken )
    // Redirijimos a pantalla principal
    oController:Redirect( Route( 'welcome' ) )
else
    oController:View( 'login.view', 'No es posible Auteticar. Vuelva a probarlo' )
    return nil
endif

RETURN nil        

METHOD Logout( oController ) CLASS Access
LOCAL oMiddleware := oController:oMiddleware

oMiddleware:CloseJWT()
oController:Redirect( Route( 'root' ) )

RETU nil