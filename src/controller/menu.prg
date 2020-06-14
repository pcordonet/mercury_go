
#include {% MercuryInclude( 'lib/mercury' ) %}

CLASS Menu

    METHOD New( oController ) CONSTRUCTOR
    METHOD Welcome( oController )

ENDCLASS

//----------------------------------------------------------------------------//
METHOD New( oController ) CLASS Menu

    oController:Middleware( , 'login' )
//   AUTENTICATE CONTROLLER oController ERROR VIEW 'login'

RETU Self
//----------------------------------------------------------------------------//
METHOD Welcome( oController ) CLASS Menu

    oController:View( 'welcome.view' )

RETU nil
//----------------------------------------------------------------------------//