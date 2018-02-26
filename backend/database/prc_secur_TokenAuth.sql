DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_secur_TokenAuth`(
	IN `in_username` VARCHAR(50),
    IN `in_password` VARCHAR(50)
)
BEGIN
	-- Variaveis Auxiliares
    DECLARE ValidaUsuario INT(1); -- Armazena o Retorno da validação
    DECLARE v_mensagem 	  VARCHAR(50); -- Mensagem de Retorno
    DECLARE v_tipo		  VARCHAR(20); -- Tipo da Mensagem
    
    -- Validar usuário da API
    SET ValidaUsuario = (
							SELECT count(*) from 001t_apiauth au
								WHERE au.login = in_username
                                  AND au.password  = md5(in_password)
							);
	IF (ValidaUsuario = 0) then
		SET v_tipo = "erro";
        SET v_mensagem = "usuário e/ou senha inválidos";
	ELSE 
		SET v_tipo = "Sucesso";
		SET v_mensagem = "Token Autorizado";
    END IF;
    
    select ValidaUsuario,v_tipo,v_mensagem;
    
    
END$$
DELIMITER ;
