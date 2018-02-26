
/*--------
*  Cadastrar novo usuário
*
*  Entrada: dados do facebook / twitter / google ou default
*  Saida:   OK/NOK
*
---------*/
exports.CadastrarUsuario = function (req, res, next) {

    var usuario = req.body.usuario;
    var senha   = req.body.senha;
    //Validar os demais dados a serem enviados

    req.getConnection(function (err, conn) {
        if (err) return next("Cannot Connect");
        //Baseado no Barcode Recupera as infos e marca o ponto
        var query = conn.query("Call prc_usuario_cadastro('"+usuario+"','"+senha+"')", function (err, rows) {
            if (err) {
                console.log(err);
                return next("Mysql error, check your query");
            }
            res.end(JSON.stringify(rows[0]));
        });
    });
};

/*--------
*  Acesso usuário
*
*  Entrada: usuario , senha
*  Saida:   NOK / Dados usuário e OK
*
---------*/
exports.login = function (req, res,next) {
    var usuario = req.body.usuario;
    var senha   = req.body.senha;
    req.getConnection(function (err, conn) {
        if (err) return next("Cannot Connect");
        //Baseado no Barcode Recupera as infos e marca o ponto
        var query = conn.query("Call prc_usuario_login('"+usuario+"','"+senha+"')", function (err, rows) {
            if (err) {
                console.log(err);
                return next("Mysql error, check your query");
            }
            res.end(JSON.stringify(rows[0]));
        });
    });
};

