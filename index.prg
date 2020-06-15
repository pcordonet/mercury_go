//	------------------------------------------------------------------------------
//	Title......: MVC_MERCURY
//	Description: Test MVC system for mod_harbour with Hrb Lib
//	Date.......: 09/07/2019
//	Last Upd...: 28/04/2020
//	------------------------------------------------------------------------------
//  {% hb_SetEnv( "HB_INCLUDE", "c:\harbour\include" ) %}
//	{% LoadHRB( '/lib/mercury/mercury.hrb' ) %}	//	Loading system MVC Mercury
//	{% LoadHRB( '/lib/wdo_lib.hrb' ) %}					//	Loading WDO lib
//	{% HB_SetEnv( 'WDO_PATH_MYSQL', "C:/Apache24/htdocs/" ) %}	//	Usuarios Xampp
//	--------------------------------------------------------------
#include {% MercuryInclude( 'lib/mercury' ) %}

FUNCTION Main()
local oApp


	// Define App
	DEFINE APP oApp TITLE 'My web aplication...' ON INIT Config() CREDENTIALS 'HshoP!2020v1' COOKIE 'MyApp'
	// Config Routes
	DEFINE ROUTE 'root'  URL '/'     VIEW 'hello.view' METHOD 'GET' OF oApp
	DEFINE ROUTE 'view1' URL 'view1' VIEW 'view1.view' METHOD 'GET' OF oApp
	DEFINE ROUTE 'view2' URL 'view2' VIEW 'view2.view' METHOD 'GET' OF oApp

	DEFINE ROUTE 'moda' URL 'moda' VIEW 'mod-a.view' METHOD 'GET' OF oApp
	DEFINE ROUTE 'modb' URL 'modb' VIEW 'mod-b.view' METHOD 'GET' OF oApp

	DEFINE ROUTE 'state'  URL 'state'  VIEW 'state.view' METHOD 'GET' OF oApp
	DEFINE ROUTE 'search' URL 'search' CONTROLLER 'search@customer.prg' METHOD 'GET' OF oApp
	DEFINE ROUTE 'getst' URL 'getbystate' CONTROLLER 'getbystate@customer.prg' METHOD 'POST' OF oApp

	DEFINE ROUTE 'data' URL 'datajson' 	CONTROLLER 'data_json@customer.prg' METHOD 'GET' OF oApp

	// autentificació.
	DEFINE ROUTE 'login'	URL 'login' 	VIEW 		'login.view'		METHOD 'GET' OF oApp
	DEFINE ROUTE 'logout'	URL 'logout'	CONTROLLER	'logout@access.prg'	METHOD 'GET' OF oApp
	DEFINE ROUTE 'auth'  	URL 'auth'		CONTROLLER	'auth@access.prg'	METHOD 'POST' OF oApp

	// Pagina Inicial de 
	DEFINE ROUTE 'welcome'	URL 'welcome' 	CONTROLLER	'welcome@menu.prg'	METHOD 'GET' OF oApp

	// WebService
	DEFINE ROUTE 'wsstate'	URL 'wsstate'	CONTROLLER 'getbystate@ws.prg'	METHOD 'GET' OF oApp
	DEFINE ROUTE 'wsauth'	URL 'wsauth'	CONTROLLER 'auth@ws.prg'		METHOD 'POST' OF oApp
	DEFINE ROUTE 'wsdata'	URL 'wsdata'	CONTROLLER 'data@ws.prg'		METHOD 'GET' OF oApp

	// System init...
	INIT APP oApp	

RETU NIL

function AppPath()
RETU AP_GetEnv( "DOCUMENT_ROOT" ) + AP_GetEnv( "PATH_APP" )
function AppPathData()
RETU AP_GetEnv( "DOCUMENT_ROOT" ) + AP_GetEnv( "PATH_DATA" )

function AppUrlImg()
RETU AP_GetEnv( "PATH_URL" ) + '/images/'
function AppUrlLib()
RETU AP_GetEnv( "PATH_URL" ) + '/lib/'
function AppUrlJs()
RETU AP_GetEnv( "PATH_URL" ) + '/js/'
function AppUrlDat()
RETU AP_GetEnv( "PATH_DATA" )
	
	
function Config() 
	
	SET DATE FORMAT TO 'dd-mm-yyyy'	

retu nil 
