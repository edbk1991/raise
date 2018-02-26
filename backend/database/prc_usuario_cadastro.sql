CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_usuario_cadastro`(
	IN in_nomecompleto varchar(100),
    IN in_foto         LONGTEXT,
    IN in_idesporte    INT,
    IN in_tempotreino  varchar(50),
    IN in_dtnascimento date,
    IN in_usuario	   varchar(50),
    IN in_senha		   varchar(50)
)
BEGIN
	DECLARE v_id INT(10);
	-- ============================================
    --  Registra na tabela de Login para obter o ID
    -- ============================================
		IF(in_usuario = undefined) then
        
			INSERT into 002t_login (nomecompleto,tipologin,status) values (in_nomecompleto,"social",1);
            select idlogin into v_id from 002tlogin where nomecompleto = in_nomecompleto;
            insert into 003t_dadoscomplementares (fk_uuid,NomeCompleto,foto,fk_idesporte,tempotreino,dtnascimento)
					values (v_id,in_nomecompleto,in_foto,in_idesporte,in_tempotreino,in_dtnascimento);
		else
			INSERT into 002t_login (usuario,senha,nomecompleto,tipologin,status) values (in_usuario,md5(in_senha),in_nomecompleto,"social",1);
            select idlogin into v_id from 002tlogin where nomecompleto = in_nomecompleto;
            insert into 003t_dadoscomplementares (fk_uuid,NomeCompleto,foto,fk_idesporte,tempotreino,dtnascimento)
					values (v_id,in_nomecompleto,in_foto,in_idesporte,in_tempotreino,in_dtnascimento);
        end if;
END