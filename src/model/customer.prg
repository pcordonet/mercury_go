CLASS CustomerModel

    DATA cAlias
    METHOD New() CONSTRUCTOR
    METHOD RowsByState( cState )
ENDCLASS
//----------------------------------------------------------------------------//
METHOD New() CLASS CustomerModel

USE ( AppPathData() + 'test.dbf' ) SHARED NEW VIA 'DBFCDX'
SET INDEX TO 'test.cdx'
::cAlias := Alias()
RETU SELF

// -----------------------------------------------
METHOD RowsByState( cState ) CLASS CustomerModel
local aRows := {}
DEFAULT cState TO ''
(::cAlias)->( OrdSetFocus( 'state' ) )
(::cAlias)->( DbSeek( cState ) )
while (::cAlias)->state == cState .and. (::cAlias)->( ! Eof() )
    Aadd( aRows , { 'first' => (::cAlias)->first,;
                    'last' => (::cAlias)->last,;
                    'street' => (::cAlias)->street,;
                    'city' => (::cAlias)->city,;
                    'zip' => (::cAlias)->zip,;
                    'salary' => (::cAlias)->salary ;
                    })
    (::cAlias)->( DbSkip() )
end
RETU aRows
// -----------------------------------------------