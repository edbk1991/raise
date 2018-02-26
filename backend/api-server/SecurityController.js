var jwt    = require('jsonwebtoken');
var config = require('./config'); // get our config file

/*--------
*  Autenticar dados do solicitante do token
*  Entrada: usuario , senha
*  Saida:   ValidadorUsuario ( se o usuário existe)
            ValidadorSenha   ( se a senha está ok)
---------*/
exports.AuthToken = function(req,res){

  
  var ValidaUsuario = "";
   //Check on Database and Return the validations below
    //Usuario e senha do APP ou WEB
    var usuario = req.body.username;
    var senha   = req.body.password; 
    req.getConnection(function (err, conn) {
        if (err) return console.log("Cannot Connect");
        //Chama a procedure de validação de usuario e senha para token
        var query = conn.query("Call prc_secur_TokenAuth('"+usuario+"','"+senha+"')", function (err, rows) {
            if (err) {
                console.log(err);
                return console.log("Mysql error, check your query");
            }
            //res.end(JSON.stringify(rows[0]));
            //Preencher a model e devolver
            ValidaUsuario = rows[0][0].ValidaUsuario;
            if(rows[0][0].v_tipo != "Erro"){
                //User.Nome = rows[0][0].Nome;
                 ValidateToken(ValidaUsuario,res,req);
            }else{
                 //Vall the Data Validation to Generate the Token
                ValidateToken(ValidaUsuario,res,req);
            }
            
        });
    });
};

    //Token Validation and Generation
    function ValidateToken(ValidaUsuario,res,req) {
      if (ValidaUsuario == 0 || ValidaUsuario == undefined) {
        res.json({ success: false, message: 'Authentication failed.' });
      } else {
            // if user is found and password is right
          // create a token with only our given payload
      // we don't want to pass in the entire user since that has the password
      const payload = {
        admin: "admin"
      };
          var token = jwt.sign(payload,config.secret, {
            //expiresInMinutes: 1440 // expires in 24 hours
          });
  
          // return the information including token as JSON
          res.json({
            success: true,
            message: 'Enjoy your token!',
            token: token
          });
        }
      } 
   //Token Validation and Generation
     function ValidateToken(User) {
      if (User.ValidaUsuario == 0 || User.ValidaUsuario == undefined) {
        res.json({ success: false, message: 'Authentication failed.' });
      } else {
            // if user is found and password is right
          // create a token with only our given payload
      // we don't want to pass in the entire user since that has the password
      const payload = {
        admin: User.admin 
      };
          var token = jwt.sign(payload, app.get('superSecret'), {
            //expiresInMinutes: 1440 // expires in 24 hours
          });
  
          // return the information including token as JSON
          res.json({
            success: true,
            message: 'Enjoy your token!',
            token: token
          });
        }
      } 
};