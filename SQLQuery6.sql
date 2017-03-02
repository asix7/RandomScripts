Declare @CollID1 char(8)
Set @CollID1 = 'SPX000AA'
Declare @Modelo int = 16777281
Declare @Equipo int

DECLARE @MaxRownum INT
DECLARE @Iter INT

SELECT 
       RowNum = ROW_NUMBER() OVER(ORDER BY sys.ResourceID),sys.ResourceID, sys.Netbios_Name0,fcm.CollectionID
       INTO #Equipos
       FROM v_R_System_Valid as sys 
       JOIN v_FullCollectionMembership fcm on sys.ResourceID=fcm.ResourceID 
       WHERE fcm.CollectionID = @CollID1

SET @MaxRownum = (SELECT MAX(RowNum) FROM #Equipos)
SET @Iter = (SELECT MIN(RowNum) FROM #Equipos)


	SET @Equipo = (select sys.ResourceID from #Equipos as sys where sys.RowNum = @Iter)

	select sys.Netbios_Name0 as NombreEquipo, prg.DisplayName0 as Nombre_Programa, prg.ProdID0 as Programa_ID, prg.Version0 as Version_Modelo, versions.v as Version_Instalada
	INTO #Nuevo
	from v_R_System_Valid as sys join v_GS_ADD_REMOVE_PROGRAMS as prg on sys.ResourceID=prg.ResourceID
	full outer join
	(
		select sys.ResourceID, prg.DisplayName0, prg.ProdID0, prg.Version0 as v, diferences.Version0 as vm
		from v_R_System_Valid as sys join v_GS_ADD_REMOVE_PROGRAMS as prg on sys.ResourceID=prg.ResourceID
		left join
		(
			select * from 
			(select prg.DisplayName0, prg.ProdID0, prg.Version0
			from v_R_System_Valid as sys join v_GS_ADD_REMOVE_PROGRAMS as prg on sys.ResourceID=prg.ResourceID
			where sys.ResourceID= @Modelo) as query2
			Except
			select * from 
			(
			select prg.DisplayName0, prg.ProdID0, prg.Version0
			from v_R_System_Valid as sys join v_GS_ADD_REMOVE_PROGRAMS as prg on sys.ResourceID=prg.ResourceID
			where sys.ResourceID= @Equipo ) as query1
			UNION
			select prg.DisplayName0, prg.ProdID0, prg.Version0
			from v_R_System_Valid as sys join v_GS_ADD_REMOVE_PROGRAMS as prg on sys.ResourceID=prg.ResourceID
			join
			(
				select prg.DisplayName0, prg.ProdID0, prg.Version0
				from v_R_System_Valid as sys join v_GS_ADD_REMOVE_PROGRAMS as prg on sys.ResourceID=prg.ResourceID
				where sys.ResourceID = @Equipo
			) as similar on prg.ProdID0 = similar.ProdID0
			where sys.ResourceID = @Modelo and similar.Version0 = prg.Version0 
		) as diferences on diferences.ProdID0= prg.ProdID0
		where sys.ResourceID= @Equipo 

	) as versions on versions.ProdID0= prg.ProdID0
	where sys.ResourceID=@Modelo and (prg.Version0 != versions.v or (versions.v IS NULL and prg.Version0 IS NOT NULL))

	UPDATE #Nuevo
	SET NombreEquipo = (select sys.Netbios_Name0 from v_R_System_Valid as sys where sys.ResourceID=@Equipo )
	WHERE NombreEquipo = (select sys.Netbios_Name0 from v_R_System_Valid as sys where sys.ResourceID=@Modelo)

	select sys.Netbios_Name0 as NombreEquipo, prg.DisplayName0 as Nombre_Programa, prg.ProdID0 as Programa_ID, versions.v as Version_Modelo, prg.Version0 as Version_Instalada
	INTO #Temp1
	from v_R_System_Valid as sys join v_GS_ADD_REMOVE_PROGRAMS as prg on sys.ResourceID=prg.ResourceID
	full outer join
	(
		select sys.ResourceID, prg.DisplayName0, prg.ProdID0, prg.Version0 as v, diferences.Version0 as vm
		from v_R_System_Valid as sys join v_GS_ADD_REMOVE_PROGRAMS as prg on sys.ResourceID=prg.ResourceID
		left join
		(
			select * from 
			(select prg.DisplayName0, prg.ProdID0, prg.Version0
			from v_R_System_Valid as sys join v_GS_ADD_REMOVE_PROGRAMS as prg on sys.ResourceID=prg.ResourceID
			where sys.ResourceID= @Equipo) as query2
			Except
			select * from 
			(
			select prg.DisplayName0, prg.ProdID0, prg.Version0
			from v_R_System_Valid as sys join v_GS_ADD_REMOVE_PROGRAMS as prg on sys.ResourceID=prg.ResourceID
			where sys.ResourceID= @Modelo ) as query1
			UNION
			select prg.DisplayName0, prg.ProdID0, prg.Version0
			from v_R_System_Valid as sys join v_GS_ADD_REMOVE_PROGRAMS as prg on sys.ResourceID=prg.ResourceID
			join
			(
				select prg.DisplayName0, prg.ProdID0, prg.Version0
				from v_R_System_Valid as sys join v_GS_ADD_REMOVE_PROGRAMS as prg on sys.ResourceID=prg.ResourceID
				where sys.ResourceID = @Modelo
			) as similar on prg.ProdID0 = similar.ProdID0
			where sys.ResourceID = @Equipo and similar.Version0 = prg.Version0 
		) as diferences on diferences.ProdID0= prg.ProdID0
		where sys.ResourceID= @Modelo

	) as versions on versions.ProdID0= prg.ProdID0
	where sys.ResourceID=@Equipo and (prg.Version0 != versions.v or (versions.v IS NULL and prg.Version0 IS NOT NULL))
	
	INSERT INTO #Nuevo
	SELECT * FROM #Temp1

	drop table #temp1

	SET @Iter = @Iter + 1
	SET @Equipo = (select sys.ResourceID from #Equipos as sys where sys.RowNum = @Iter)


while @Iter < @MaxRownum + 1
BEGIN
	select sys.Netbios_Name0 as NombreEquipo, prg.DisplayName0 as Nombre_Programa, prg.ProdID0 as Programa_ID, prg.Version0 as Version_Modelo, versions.v as Version_Instalada
	INTO #Temp
	from v_R_System_Valid as sys join v_GS_ADD_REMOVE_PROGRAMS as prg on sys.ResourceID=prg.ResourceID
	full outer join
	(
		select sys.ResourceID, prg.DisplayName0, prg.ProdID0, prg.Version0 as v, diferences.Version0 as vm
		from v_R_System_Valid as sys join v_GS_ADD_REMOVE_PROGRAMS as prg on sys.ResourceID=prg.ResourceID
		left join
		(
			select * from 
			(select prg.DisplayName0, prg.ProdID0, prg.Version0
			from v_R_System_Valid as sys join v_GS_ADD_REMOVE_PROGRAMS as prg on sys.ResourceID=prg.ResourceID
			where sys.ResourceID= @Modelo) as query2
			Except
			select * from 
			(
			select prg.DisplayName0, prg.ProdID0, prg.Version0
			from v_R_System_Valid as sys join v_GS_ADD_REMOVE_PROGRAMS as prg on sys.ResourceID=prg.ResourceID
			where sys.ResourceID= @Equipo ) as query1
			UNION
			select prg.DisplayName0, prg.ProdID0, prg.Version0
			from v_R_System_Valid as sys join v_GS_ADD_REMOVE_PROGRAMS as prg on sys.ResourceID=prg.ResourceID
			join
			(
				select prg.DisplayName0, prg.ProdID0, prg.Version0
				from v_R_System_Valid as sys join v_GS_ADD_REMOVE_PROGRAMS as prg on sys.ResourceID=prg.ResourceID
				where sys.ResourceID = @Equipo
			) as similar on prg.ProdID0 = similar.ProdID0
			where sys.ResourceID = @Modelo and similar.Version0 = prg.Version0 
		) as diferences on diferences.ProdID0= prg.ProdID0
		where sys.ResourceID= @Equipo 

	) as versions on versions.ProdID0= prg.ProdID0
	where sys.ResourceID=@Modelo and (prg.Version0 != versions.v or (versions.v IS NULL and prg.Version0 IS NOT NULL))


	UPDATE #Temp
	SET #Temp.NombreEquipo = (select sys.Netbios_Name0 from v_R_System_Valid as sys where sys.ResourceID=@Equipo )
	WHERE #Temp.NombreEquipo = (select sys.Netbios_Name0 from v_R_System_Valid as sys where sys.ResourceID=@Modelo)
	
	INSERT INTO #Nuevo
	SELECT * FROM #Temp

	drop table #temp

	select sys.Netbios_Name0 as NombreEquipo, prg.DisplayName0 as Nombre_Programa, prg.ProdID0 as Programa_ID, versions.v as Version_Modelo, prg.Version0 as Version_Instalada
	INTO #Temp2
	from v_R_System_Valid as sys join v_GS_ADD_REMOVE_PROGRAMS as prg on sys.ResourceID=prg.ResourceID
	full outer join
	(
		select sys.ResourceID, prg.DisplayName0, prg.ProdID0, prg.Version0 as v, diferences.Version0 as vm
		from v_R_System_Valid as sys join v_GS_ADD_REMOVE_PROGRAMS as prg on sys.ResourceID=prg.ResourceID
		left join
		(
			select * from 
			(select prg.DisplayName0, prg.ProdID0, prg.Version0
			from v_R_System_Valid as sys join v_GS_ADD_REMOVE_PROGRAMS as prg on sys.ResourceID=prg.ResourceID
			where sys.ResourceID= @Equipo) as query2
			Except
			select * from 
			(
			select prg.DisplayName0, prg.ProdID0, prg.Version0
			from v_R_System_Valid as sys join v_GS_ADD_REMOVE_PROGRAMS as prg on sys.ResourceID=prg.ResourceID
			where sys.ResourceID= @Modelo ) as query1
			UNION
			select prg.DisplayName0, prg.ProdID0, prg.Version0
			from v_R_System_Valid as sys join v_GS_ADD_REMOVE_PROGRAMS as prg on sys.ResourceID=prg.ResourceID
			join
			(
				select prg.DisplayName0, prg.ProdID0, prg.Version0
				from v_R_System_Valid as sys join v_GS_ADD_REMOVE_PROGRAMS as prg on sys.ResourceID=prg.ResourceID
				where sys.ResourceID = @Modelo
			) as similar on prg.ProdID0 = similar.ProdID0
			where sys.ResourceID = @Equipo and similar.Version0 = prg.Version0 
		) as diferences on diferences.ProdID0= prg.ProdID0
		where sys.ResourceID= @Modelo

	) as versions on versions.ProdID0= prg.ProdID0
	where sys.ResourceID=@Equipo and (prg.Version0 != versions.v or (versions.v IS NULL and prg.Version0 IS NOT NULL))
	
	INSERT INTO #Nuevo
	SELECT * FROM #Temp2

	drop table #temp2

	SET @Iter = @Iter + 1
	SET @Equipo = (select sys.ResourceID from #Equipos as sys where sys.RowNum = @Iter)
END;

select DISTINCT * from #Nuevo
order by Nombre_Programa
drop table #Nuevo
drop table #Equipos