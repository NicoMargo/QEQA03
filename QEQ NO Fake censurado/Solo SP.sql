
/****** Object:  StoredProcedure [dbo].[spBuscarPartidas]    Script Date: 26/11/2018 19:58:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spBuscarPartidas] 
as 
select IdPartida, IdUsuario1, Ip1, idCategoria, Fecha from Partidas where Multijugador = 1 and IdUsuario2 is null AND Ganador is null 




GO
/****** Object:  StoredProcedure [dbo].[spCargarRespuestas]    Script Date: 26/11/2018 19:58:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spCargarRespuestas] 
@idPersonaje int,
@idPregunta int
as
if((select top 1 idPersona from Personas where idPersona = @idPersonaje) is not null and (select top 1 idPregunta from Preguntas where idPregunta = idPregunta) is not null)
begin
	insert into Respuestas(idPersona,idPregunta) values(@idPersonaje,@idPregunta)
end





GO
/****** Object:  StoredProcedure [dbo].[spCrearCat]    Script Date: 26/11/2018 19:58:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spCrearCat] 
@Nombre varchar(50)
as
declare @msg varchar(100) = ''
if exists(select Categoria from Categorias where Categoria=@Nombre)
SET @msg = 'Ya hay una categoria con ese nombre'
else
insert into Categorias(Categoria) values(@Nombre)

select @msg as msg
	





GO
/****** Object:  StoredProcedure [dbo].[spCrearGrupo]    Script Date: 26/11/2018 19:58:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spCrearGrupo] 
@Nombre varchar(50)
as
declare @msg varchar(100) = ''
if exists(select Nombre from Grupo where Nombre=@Nombre)
SET @msg = 'Ya hay un grupo de preguntas con ese nombre'
else
insert into Grupo(Nombre) values(@Nombre)

select @msg as msg
	





GO
/****** Object:  StoredProcedure [dbo].[spCrearPartida]    Script Date: 26/11/2018 19:58:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE proc [dbo].[spCrearPartida] 
 @IdUsuarioHost int,
 @IpHost varchar(100),
 @idCat int,
 @idPer2 int
as
if((select top 1 idCategoria from Categorias where idCategoria=@idCat )is not null or @idcat=0)
if exists(select * from Usuarios where idUsuarios= @IdUsuarioHost)
begin
	insert into Partidas(IdUsuario1,Ip1,Multijugador,idCategoria,Preguntas,Fecha,idPer2, Turno) values(@IdUsuarioHost,@IpHost,1,@idCat,0, CURRENT_TIMESTAMP, @idPer2,0)
	Select TOP 1 (idPartida) as id from partidas order by idPartida desc
end




GO
/****** Object:  StoredProcedure [dbo].[spCrearPersonaje]    Script Date: 26/11/2018 19:58:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spCrearPersonaje] 
@Nombre varchar(50),
@Foto image,
@idCategoria int
as
--Se crea un personaje , insertar un nuevo personaje en la tabla con los parametros @nombre, @foto y categoria
--SE DEBE VERIFICAR SI LA CATEGORIA EXISTE, SI NO DEBE DEVOLVER UN ERROR EN FORMA DE BOOL (O BIT) @exito (0 fallido, 1 exitoso)
--select ‘PR3498’, ‘Campos’,’Pardo’,’Luis’,’15/01/1997′, ‘A’, * from OpenRowset(Bulk ‘D:\EmpleadosFotos\CamposPardoLuis.jpg’, Single_Blob) As EmpleadosFoto
--SELECT 1, 'Norman', BulkColumn  FROM Openrowset( Bulk 'C:\ImagenFichero.bmp', Single_Blob) as Imagen
declare @Msg varchar = 'El nombre ya esta siendo utilizado'
if((select top 1 idCategoria from Categorias where idCategoria = @idCategoria)is not null and (select top 1 Nombre from Personas where Nombre = @Nombre) is null)
begin
	insert into Personas(Nombre,idCategoria,Foto) values (@Nombre, @idCategoria, @Foto)
	set @Msg = ''
	select @Msg as msg, idPersona from Personas where Nombre = @Nombre
end
else
select @Msg as msg, -1 as idPersona
--//LISTO





GO
/****** Object:  StoredProcedure [dbo].[spCrearPregunta]    Script Date: 26/11/2018 19:58:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spCrearPregunta] 
@Texto varchar(150),
@idGrupo varchar(50),
@Puntos int
as
declare @msg varchar(50) = 'Existe una pregunta con el mismo texto'
if((select Texto from Preguntas where @Texto = Texto) is null and @idGrupo is not null)
begin
	insert into Preguntas(Texto, idGrupo,Puntos) values(@Texto, @idGrupo,@Puntos)
	set @msg = ''
end
select @msg as msg





GO
/****** Object:  StoredProcedure [dbo].[spCTurno]    Script Date: 26/11/2018 19:58:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[spCTurno]
@IdPartida int,
@Turno bit
as
if exists(select * from Partidas where IdPartida = @IdPartida)
begin
	update Partidas set Turno = @Turno where idPartida= @IdPartida	
end
GO
/****** Object:  StoredProcedure [dbo].[spDatosPartida]    Script Date: 26/11/2018 19:58:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spDatosPartida] 
@idPartida int,
@idUsuario int
as
if exists(select * from Partidas where IdPartida = @IdPartida and Ganador is not null)
begin
	if exists(select * from Partidas where IdPartida = @IdPartida and idUsuario1 = @idUsuario)
	select Nombre, Preguntas, Ganador  from Partidas inner join Usuarios on IdUsuario2 = idUsuarios
	where IdPartida = @IdPartida
	else
	begin
		if exists(select * from Partidas where IdPartida = @IdPartida and idUsuario2 = @idUsuario)
		select Nombre, Preguntas, Ganador  from Partidas inner join Usuarios on IdUsuario1 = idUsuarios
		where IdPartida = @IdPartida
	end
end




GO
/****** Object:  StoredProcedure [dbo].[spEliminarCat]    Script Date: 26/11/2018 19:58:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spEliminarCat] 
@id int
as
declare @msg varchar (100) = ''
if exists(select * from Categorias where idCategoria=@id)
begin
	set @msg = 'Se elimino la categoria: ' + (select top 1 Categoria from Categorias where idCategoria=@id)
	delete from Categorias 
	where idCategoria = @id
end
else
set @msg = 'No se encontro la categoria'

select @msg as msg





GO
/****** Object:  StoredProcedure [dbo].[spEliminarGrupo]    Script Date: 26/11/2018 19:58:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spEliminarGrupo] 
@id int
as
declare @msg varchar (100) = '' 
if exists(select * from Grupo where idGrupo=@id)
begin
	set @msg = 'Se elimino el grupo: ' + (select top 1 Nombre from Grupo where idGrupo = @id) 
	delete from Grupo 
	where idGrupo = @id
end
else
set @msg = 'No se encontro el Grupo'

select @msg as msg





GO
/****** Object:  StoredProcedure [dbo].[spEliminarPersonaje]    Script Date: 26/11/2018 19:58:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spEliminarPersonaje] 
@Id int
as
declare @msg varchar(50) = 'Persona no encontrada'
declare @idPer int = (select top 1 idPersona from Personas where idPersona = @Id)
if(@idPer is not null)
begin
	set @msg = 'Se elimino el personaje: ' + (select top 1 Nombre from Personas where idPersona = @Id)
	delete from Respuestas where idPersona = @Id
	delete from Personas where idPersona = @Id 
end
select @msg as msg





GO
/****** Object:  StoredProcedure [dbo].[spEliminarPregunta]    Script Date: 26/11/2018 19:58:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc[dbo].[spEliminarPregunta]
@idPregunta int
as
declare @msg varchar(100) = 'no se encontro la pregunta a eliminar'
declare @idPre int = (select top 1 idPregunta from Preguntas where @idPregunta = idPregunta)
if(@idPre is not null)
begin
	delete from Respuestas where idPregunta = @idPre
	delete from Preguntas where  @idPregunta = idPregunta
	set @msg = 'Eliminacion satisfactoria'
end
select @msg as msg



GO
/****** Object:  StoredProcedure [dbo].[spEliminarUsuario]    Script Date: 26/11/2018 19:58:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spEliminarUsuario] 
--recibe el nombre, (y quiza la contrasenia, eso lo veremos despues) y elimina el usuario y todos los puntajes que realizo
@Username varchar(50)
AS
Declare @Exito bit = 0
IF (@Username IS NOT NULL)
BEGIN
    IF ((SELECT Username FROM Usuarios WHERE Username = @Username) IS NOT NULL)
    BEGIN
        DELETE FROM Usuarios WHERE Username = @Username
        Set @Exito = 1
    END
END
select @Exito






GO
/****** Object:  StoredProcedure [dbo].[spFinalizarPartida]    Script Date: 26/11/2018 19:58:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spFinalizarPartida] 
@IdPartida int,
@IdUsuario int,
@Fecha date
as
if exists(select * from Partidas where IdPartida = @IdPartida)
begin
update Partidas set Fecha = @Fecha where idPartida= @IdPartida
	if(@IdUsuario = (select IdUsuario1 from Partidas where IdPartida = @IdPartida))
	update Partidas set Ganador = 1 where idPartida= @IdPartida
	else
	update Partidas set Ganador = 0 where idPartida= @IdPartida
end




GO
/****** Object:  StoredProcedure [dbo].[spGanador]    Script Date: 26/11/2018 19:58:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spGanador]
@IdPartida int,
@Ganador int
as
	update Partidas set Ganador = @Ganador where @IdPartida = idPartida
GO
/****** Object:  StoredProcedure [dbo].[spGuardarPartida]    Script Date: 26/11/2018 19:58:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spGuardarPartida]  
@idUsuario int,
@ip int,
@puntos int,
@CantPreguntas int,
@Ganador bit,
@Fecha date
as
insert into Partidas(IdUsuario1,Ip1,Puntos,Preguntas,Ganador,Fecha,Multijugador) values(@IdUsuario,@Ip,@Puntos,@CantPreguntas,@Ganador,@Fecha,0)




GO
/****** Object:  StoredProcedure [dbo].[spGuardarPartida1]    Script Date: 26/11/2018 19:58:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spGuardarPartida1]
@Usuario int,
@ip varchar(50),
@cantPregunta int,
@Ganador bit,
@idPersonaje int,
@Puntos int
as
if exists (select top 1 Nombre from Usuarios where idUsuarios=@Usuario)
begin
	insert into Partidas(idUsuario1,ip1,Fecha,Preguntas,Multijugador,Ganador,idPer1,Puntos) values(@Usuario,@ip,CURRENT_TIMESTAMP,@cantPregunta,0,@Ganador,@idPersonaje,@Puntos)
end
else if(@Usuario =0) insert into Partidas(idUsuario1,ip1,Fecha,Preguntas,Multijugador,Ganador,idPer1,Puntos) values(@Usuario,@ip,CURRENT_TIMESTAMP,@cantPregunta,0,@Ganador,@idPersonaje,@Puntos)
GO
/****** Object:  StoredProcedure [dbo].[spLogin]    Script Date: 26/11/2018 19:58:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc[dbo].[spLogin]
@Ip varchar(50),
@Username varchar(50),
@Password varchar(50)
AS
Declare @msg varchar(50) = '', @Pass varchar(50)
set @pass  = (SELECT HashBytes('MD5',@Password))

if  Exists(select Username from Usuarios where Username = @Username and Pass = @pass)
Begin
if (@Ip is not null)
begin
update Usuarios set Ip1 = @Ip where @Username = Username
end
set @msg = 'OK'
SELECT  @msg as msg, *  FROM Usuarios WHERE @Username = Username AND @pass = Pass
 
End
Else if  Not Exists(Select Username from Usuarios where Username = @Username )
Begin
set @msg = 'Username incorrecto'
select @msg as msg
End
Else 
Begin
	set @msg = 'Contraseña incorrecta'
	select @msg as msg
End
	
 
     






GO
/****** Object:  StoredProcedure [dbo].[spModificarCategoria]    Script Date: 26/11/2018 19:58:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc[dbo].[spModificarCategoria]
@newCategoria varchar(50),
@idCategoria int
as
declare @msg varchar(100)= ''
if exists(select top 1 idCategoria from Categorias where @idCategoria=idCategoria)
begin
	if exists(select top 1 @newCategoria from Categorias where @newCategoria = Categoria)
	set @msg = 'Ya hay una categoria con ese nuevo nombre'
	else
	update Categorias set Categoria = @newCategoria where @idCategoria = idCategoria
end
else
set @msg = 'Categoria no Encontrada'

select @msg as msg



GO
/****** Object:  StoredProcedure [dbo].[spModificarGrupo]    Script Date: 26/11/2018 19:58:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc[dbo].[spModificarGrupo]
@newGrupo varchar(50),
@idGrupo int
as
declare @msg varchar(100)= ''
if exists(select top 1 idGrupo from Grupo where @idGrupo=idGrupo)
begin
	if exists(select top 1 idGrupo from Grupo where @newGrupo=Nombre)
	set @msg = 'ya hay un grupo de preguntas con ese nuevo nombre'
	else
	update Grupo set Nombre = @newGrupo where @idGrupo = idGrupo
end
else
set @msg = 'Grupo no encontrado'

select @msg as msg




GO
/****** Object:  StoredProcedure [dbo].[spModificarPersonaje]    Script Date: 26/11/2018 19:58:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc[dbo].[spModificarPersonaje]
@Id int,
@nuevoNombre varchar(150),
@Foto image,
@idCategoria int
as
declare @msg varchar(200)= 'Se modifico a '+ @nuevoNombre
if exists(select * from Personas where @Id=idPersona)
begin
	delete from Respuestas where idPersona = (select idPersona from Personas where @Id=idPersona)
	if(@nuevoNombre is not null and @nuevoNombre !='')
	begin
		if exists(select * from Personas where @nuevoNombre=Nombre)
		set @msg += ',Error: el Nombre ya esta siendo utilizado '
		else
		begin
			update Personas set Nombre = @nuevoNombre where @Id = idPersona
			set @msg += ',Nombre modificado '
		end
	end
	if(@idCategoria is not null and @idCategoria !='')
	begin
		if exists(select * from Categorias where @idCategoria=idCategoria)
		begin
			update Personas set idCategoria = @idCategoria where @Id = idPersona
			set @msg += ',Categoria modificada '
		end
		else
		set @msg += ',Error: Categoria no encontrada '
	end
	if(@Foto is not null)
	begin
		update Personas set Foto = @Foto where @Id = idPersona
		set @msg += ',Foto Modificada '
	end
end
else
set @msg = 'La id no Corresponde a ningun personaje'

select @msg as msg




GO
/****** Object:  StoredProcedure [dbo].[spModificarPregunta]    Script Date: 26/11/2018 19:58:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc[dbo].[spModificarPregunta]
@idPregunta int,
@nuevoTexto varchar(150),
@idGrupo int,
@Puntos int
as
declare @msg varchar(50) = 'Pregunta No encontrada'
if exists(select Texto from Preguntas where idPregunta = @idPregunta) 
begin
	if (@idGrupo is not null)
	begin
		update Preguntas set Texto = @nuevoTexto where idPregunta = @idPregunta
		update Preguntas set idGrupo = @idGrupo where idPregunta = @idPregunta
		update Preguntas set Puntos  = @Puntos where idPregunta = @idPregunta
		set @msg = ''

	end
	else
	begin
		if(@idGrupo is null)
		begin
		set @msg = 'Se actualizo la pregunta "'+ (select Top 1 Texto from Preguntas where idPregunta = @idPregunta)+ '?" Por "'+ @nuevoTexto + '?"'
		update Preguntas set Texto = @nuevoTexto where idPregunta = @idPregunta
		end
	end
end
select @msg as msg




GO
/****** Object:  StoredProcedure [dbo].[spModificarUsuario]    Script Date: 26/11/2018 19:58:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spModificarUsuario]
@Username varchar(50),
@nuevoUsername varchar(50),
@NuevaPass varchar(50),
@nuevoNombre varchar(50),
@nuevoMail varchar(50)
as
declare @pass varchar(50)
set @pass  = (SELECT HashBytes('MD5',@NuevaPass))

if not exists (select Username from Usuarios where @nuevoUsername = Username)
Begin
	if (@NuevaPass != 'a')
	Begin
	update Usuarios set Pass = @pass where @Username = Username	
	End	
	update Usuarios set Nombre = @nuevoNombre where @Username = Username
	update Usuarios set Mail = @nuevoMail where @Username = Username
	update Usuarios set Username = @nuevoUsername where @Username = Username
end




if ( @nuevoUsername = @Username)
Begin
	if (@NuevaPass != 'a')
	Begin
	update Usuarios set Pass = @pass where @Username = Username	
	End	
	update Usuarios set Nombre = @nuevoNombre where @Username = Username
	update Usuarios set Mail = @nuevoMail where @Username = Username
	update Usuarios set Username = @nuevoUsername where @Username = Username
end







GO
/****** Object:  StoredProcedure [dbo].[spOlvidoPass]    Script Date: 26/11/2018 19:58:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procEDURE [dbo].[spOlvidoPass] 
@NuevaPass varchar(50),
@Username varchar(50)
AS
declare @pass varchar(50)
set @pass  = (SELECT HashBytes('MD5',@NuevaPass))
if exists(select Username from Usuarios where Username = @Username)
Begin
update Usuarios set Pass = @pass where @Username = Username
select '' as NoUser
end
else 
begin
select 'El Username no existe' as NoUser
end



GO
/****** Object:  StoredProcedure [dbo].[spPasarTurno]    Script Date: 26/11/2018 19:58:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc[dbo].[spPasarTurno]
@IdPartida int,
@IdUsuario int
as
if exists(select * from Partidas where IdPartida = @IdPartida and Ganador is null)
begin
	if(@IdUsuario = (select IdUsuario1 from Partidas where IdPartida = @IdPartida))
	update Partidas set Preguntas = Preguntas+1 where idPartida= @IdPartida
	select '' as msg
end	
else
select 'La partida esta finalizada' as msg



GO
/****** Object:  StoredProcedure [dbo].[spRanking]    Script Date: 26/11/2018 19:58:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spRanking]
AS
select idPartida,idUsuario1,idPer1,Puntos,Preguntas,Ganador,Fecha From Partidas where Multijugador = 0 order by puntos desc 
GO
/****** Object:  StoredProcedure [dbo].[spRegister]    Script Date: 26/11/2018 19:58:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc[dbo].[spRegister]
@Username varchar(50),
@Password varchar(50),
@Nomb varchar(50),
@Mail varchar(75),
@Ip1 varchar(50),
@Admin bit
as
declare @exito bit = 0, @pass varchar(50)
set @pass  = (SELECT HashBytes('MD5',@Password))
if (@Mail is not null and @Mail != '' and @Nomb is not null and @Nomb != '' and @Username is not null and @Username != '' and @Password is not null and @Password != '' )
begin
if not exists(select Username from Usuarios where Username = @Username)
begin
    insert into Usuarios(Username,Pass,Nombre,Administrador,Mail,Ip1) values (@Username,@pass,@Nomb,@Admin,@Mail,@Ip1)
    set @exito = 1
	end
end
select @exito as exito




GO
/****** Object:  StoredProcedure [dbo].[spTraerCats]    Script Date: 26/11/2018 19:58:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc[dbo].[spTraerCats] --traer categorias
as
select idCategoria, Categoria from Categorias




GO
/****** Object:  StoredProcedure [dbo].[spTraerGrupos]    Script Date: 26/11/2018 19:58:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc[dbo].[spTraerGrupos]
as
select idGrupo, Nombre from Grupo




GO
/****** Object:  StoredProcedure [dbo].[spTraerPersonajes]    Script Date: 26/11/2018 19:58:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc[dbo].[spTraerPersonajes]
@idCategoria int
as
--Trae una lista de personajes, parametros : @categoria varchar , si se envia nulo o '' se traera a todos  

if((select top 1 Categoria from Categorias where @idCategoria = idCategoria) is not null or @idCategoria=0)
begin	
	if(@idCategoria != 0)
	begin
		select idPersona,Foto, Nombre, idCategoria from Personas 
		where @idCategoria = idCategoria
	end
	else if (@idCategoria = 0)
	begin
	select idPersona,Foto, Nombre, idCategoria from Personas 
	end
End
	
	
	

GO
/****** Object:  StoredProcedure [dbo].[spTraerPreguntas]    Script Date: 26/11/2018 19:58:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc[dbo].[spTraerPreguntas]
as
select idPregunta, Texto , idGrupo, Puntos from Preguntas




GO
/****** Object:  StoredProcedure [dbo].[spTraerRespuestas]    Script Date: 26/11/2018 19:58:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc[dbo].[spTraerRespuestas]
@idCategoria int
as
if((select Categoria from Categorias where @idCategoria = idCategoria) is not null or @idCategoria=0)
begin
	if(@idCategoria !=0)
	begin
		select idRespuestas,idPregunta,Respuestas.idPersona from Respuestas inner join Personas on Personas.idPersona = Respuestas.idPersona
		where @idCategoria = Personas.idCategoria
	end
	else
	begin
		select * from Respuestas
	end
end



GO
/****** Object:  StoredProcedure [dbo].[spTraerRxP]    Script Date: 26/11/2018 19:58:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spTraerRxP]
@idPersona int
as
if((select Top 1 Nombre from Personas where @idPersona = idPersona) is not null)
begin
	select Respuestas.idPregunta, Texto,idGrupo,Puntos
	from Respuestas inner join Preguntas on Preguntas.idPregunta = Respuestas.idPregunta
	where @idPersona = idPersona
end
else
select 0 as idPregunta, '' as Texto, 0 as idGrupo, 0 as Puntos



GO
/****** Object:  StoredProcedure [dbo].[spTraerUsuarios]    Script Date: 26/11/2018 19:58:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spTraerUsuarios]
as
select * from Usuarios
GO
/****** Object:  StoredProcedure [dbo].[spTurno]    Script Date: 26/11/2018 19:58:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spTurno]
@idpart int
as
select Turno as Turno from Partidas where idPartida = @idpart
GO
/****** Object:  StoredProcedure [dbo].[spUnirse]    Script Date: 26/11/2018 19:58:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc[dbo].[spUnirse]
@IdPartida int,
@IdUsuario2 int,
@Ip2 varchar(50),
@Per1 int
as
declare @exito bit = 0
if exists(select * from Partidas where IdPartida = @IdPartida and Multijugador = 1 and IdUsuario2 is null  and Ganador is null)
begin
	update Partidas set IdUsuario2 = @IdUsuario2 where idPartida= @IdPartida
	update Partidas set Ip2 = @Ip2 where idPartida= @IdPartida
	update Partidas set idPer1 = @Per1 where idPartida= @IdPartida	
	update Partidas set Turno = 1 where idPartida= @IdPartida	
	set @exito = 1
end
select @exito as exito



GO
USE [master]
GO
ALTER DATABASE [QEQA03] SET  READ_WRITE 
GO
