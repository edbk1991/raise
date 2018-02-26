
var express          = require('express'),
    path             = require('path'),
    bodyParser       = require('body-parser'),
    app              = express(),
    LocalStorage     = require('node-localstorage').LocalStorage,
    expressValidator = require('express-validator');
var cors             = require('cors');
var jwt 	   		 = require('jsonwebtoken');
var connection 	     = require('express-myconnection'),
mysql 		   		 = require('mysql');
var config    		 = require('./config'); // get our config file
          
//Chamar DB CONFIG para facilitar na hora de troca de servidores
dbcfg = require('./config/db');

//Classe Usuário
usuario = require('./usuario'),


/*Set EJS template Engine*/
app.set('views', './views');
//app.set('view engine', 'ejs');
app.engine('html', require('ejs').renderFile);
app.set('view engine', 'html');

app.use(express.static(path.join(__dirname, 'public')));
app.use(bodyParser.urlencoded({ extended: true })); //support x-www-form-urlencoded
app.use(bodyParser.json());
app.use(expressValidator());

app.use(function (req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    next();
});

app.use(connection(mysql,dbcfg,'request'));

//RESTful route
var router = express.Router();

/*------------------------------------------------------
*  This is router middleware,invoked everytime
*  we hit url /api and anything after /api
*  like /api/user , /api/user/7
*  we can use this for doing validation,authetication
*  for every route started with /api
--------------------------------------------------------*/
router.use(function (req, res, next) {
    console.log(req.method, req.url);
    next();
});

/*----------------------------------------------------------------------
*  Função chamada pelo GET exibe o DashBoard
----------------------------------------------------------------------*/
app.get('/', function (req, res) {
    // res.render('principal', { title: "DashBoard" });
});


// This Route Generates the Tokens for using Safe Routes used by web/app and testing
apiRoutes.post('/Security/Authenticate',SecurityController.AuthToken);


/******************/
/* Rotas Usuário */
/*****************/

/*--------
*  Login 
---------*/
app.post('/usuario/login', usuario.login);

/*--------
*  Cadastro 
---------*/
app.post('/usuario/Registrar', usuario.CadastrarUsuario);



//now we need to apply our router here
app.use('/api', router);

//start Server
var server = app.listen(8080, '0.0.0.0', function () {

    console.log("Listening to port %s", server.address().port);

});
