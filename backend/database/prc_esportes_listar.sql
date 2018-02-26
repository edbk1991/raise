CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_esportes_listar`()
BEGIN
	select idespoerte,descricao from 004t_esportes;
END