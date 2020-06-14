CLASS Customer
	
    METHOD New( oController ) CONSTRUCTOR
    METHOD GetByState( oController )
    METHOD Search( oController )
    METHOD data_json( oController )

ENDCLASS

//----------------------------------------------------------------------------//
METHOD New( oController ) CLASS Customer

    oController:Middleware( , 'login' )

RETURN Self
//----------------------------------------------------------------------------//
METHOD GetByState( oController ) CLASS Customer
    local oCusto := CustomerModel():New()
    local oValidator := TValidator():New()
    local hRoles := { 'mystate' => 'required|string|len:2' }
    local hFormat := { 'mystate' => 'upper' }
    local hData := {=>}
    local aRows
    // Recupero Datos -----------------------------------------------
    hData[ 'mystate' ] = oController:oRequest:Post( 'mystate' )
    // Valido datos --------------------------------------------------
    if ! oValidator:Run( hRoles )
        oController:View( 'search.view', oValidator:ErrorString() )
        return nil
    endif
    oValidator:Formatter( hData, hFormat )

    // -----------------------------------------------------------------
    aRows := oCusto:RowsByState( hData[ 'mystate' ] )

    oController:View( 'listbystate.view', hData[ 'mystate' ], aRows )

RETURN nil

METHOD Search( oController ) CLASS Customer

    local cDate := DtoC( date() + 10 )
    local aFruits := { 'Banana', 'Apple', 'Pear', 'Cherry' }

    oController:View( "search.view" , cDate, aFruits )

RETURN nil

METHOD data_json( oController ) CLASS Customer
local hUser := { 'name' => 'John Kocinsky', 'age' => 38, 'date' => CTod( '07/11/2001' ) }
    oController:oResponse:SendJson( hUser )
RETU nil

{% LoadFile( "/src/model/customer.prg" ) %}