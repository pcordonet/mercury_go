CLASS WS

    METHOD Auth( oController )
    METHOD GetByState( oController )
    METHOD Data( oController )

ENDCLASS

METHOD GetByState( oController ) CLASS WS
local qSelf:= Hb_QSelf()
local oCusto := CustomerModel():New()
local oValidator := TValidator():New()
local hRoles := { 'state' => 'required|string|len:2' }
local hFormat := { 'state' => 'upper' }
local hData := {=>}
local hResponse := {=>}
local aRows

oController:Middleware( 'token' ,  , {|| qSelf:auth() } , { 'mierror' => 'No autorizado' } )

// Recupero Datos -----------------------------------------------
hData[ 'state' ] = oController:oRequest:Get( 'state' )
// Valido datos --------------------------------------------------
if ! oValidator:Run( hRoles )
    hResponse[ 'success' ] := .F.
    hResponse[ 'error' ] := oValidator:ErrorString()
    oController:oResponse:SendJson( hResponse )
    return nil
endif

oValidator:Formatter( hData, hFormat )
// -----------------------------------------------------------------
aRows := oCusto:RowsByState( hData[ 'state' ] )
hResponse[ 'success' ] := .T.
hResponse[ 'state' ] := hData[ 'state' ]
hResponse[ 'rows' ] := aRows
oController:oResponse:SendJson( hResponse )

RETU nil    

METHOD Auth( oController ) CLASS WS
local oValidator := TValidator():New()
local hRoles := { 'user' => 'required|string|maxlen:8|minlen:1' , 'psw' => 'required'}
local hFormat := { 'user' => 'lower' }
local hData := {=>}
local hToken := {=>}
local hResponse := {=>}
local aRows

// Recupero Datos -----------------------------------------------
hData[ 'user'] := oController:oRequest:Post( 'user' )
hData[ 'psw' ] := oController:oRequest:Post( 'psw' )
// Valido datos --------------------------------------------------
if ! oValidator:Run( hRoles )
    hResponse[ 'success' ] := .F.
    hResponse[ 'error' ] := 'Error autentication'
    oController:oResponse:SendJson( hResponse )
    return nil
endif

oValidator:Formatter( hData, hFormat )    

// Comprobar identidad -------------------------------------------
if hData[ 'user'] == 'demo' .and. hData[ 'psw'] == '1234'
    // Entro datos opcionales, que los puedo consultar cada vez que entren
    // No se ha de poner informacion sensible...
    hToken := { 'in' => time(), 'user' => hData[ 'user' ] }
    // Entro datos opcionales, que los puedo consultar cada vez que entren
    // No se ha de poner informacion sensible...
    hToken := { 'in' => time(), 'user' => hData[ 'user' ] }
    // 120 = 2 minuts; default 3600
    cToken := oController:oMiddleware:SetAutenticationToken( hToken, 120 )
    // Preparamos respuesta
    hResponse := { 'success' => .t., 'token' => cToken }
else
    hResponse := { 'success' => .f., 'error' => 'Error autentication.' }
endif

oController:oResponse:SendJson( hResponse )

RETURN nil

METHOD Data( oController ) CLASS WS
local hData := oController:oMiddleware:GetDataToken()

oController:oResponse:SendJson( hData )

RETU nil

{% LoadFile( "/src/model/customer.prg" ) %}