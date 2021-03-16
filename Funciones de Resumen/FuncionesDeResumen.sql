use MonkeyUniv

-- 1 - Listado con la cantidad de cursos.
Select Count(*) As [Cantidad de cursos] From Cursos

-- 2 - Listado con la cantidad de usuarios.
Select Count(*) As [Cantidad de usuarios] From Usuarios

-- 3 - Listado con el promedio de costo de certificación de los cursos.
Select Round(AVG(CostoCertificacion),2,0) As [Costo de certificacion] From Cursos
-- Round redondea a dos decimales en este caso

-- 4 -  Listado con el promedio general de calificación de reseñas.
Select AVG(Puntaje) As [Promedio general de calificacion] From Reseñas

-- 5 - Listado con la fecha de estreno de curso más antigua.
Select MIN(Year(Estreno)) As [Estreno de curso mas antiguo] From Cursos

-- 6 - Listado con el costo de certificación menos costoso.
Select MIN(CostoCertificacion) As [Costo certificacion menos costoso] From Cursos 

-- 7 - Listado con el costo total de todos los cursos.
Select SUM(CostoCurso) As [Costo total de todos los cursos] From Cursos

-- 8 -  Listado con la suma total de todos los pagos.
Select SUM(Importe) As [Importe de todos los pagos] From Pagos

-- 9 - Listado con la cantidad de cursos de nivel principiante.
Select Count(*) As [Cantidad de cursos Principiantes] From Cursos As C
inner join Niveles As N on N.ID = C.IDNivel
Where N.Nombre = 'Principiante'

Select * From Niveles
-- para saber los niveles

-- 10 - Listado con la suma total de todos los pagos realizados en 2019.
Select SUM(Importe) As [Suma de pagos realizados en 2019] From Pagos
Where Year(Fecha) = '2019'

Select * From Pagos
Where Year(Fecha) = '2019'
-- Para saber los pagos de 2019

-- 11 - Listado con la cantidad de usuarios que son instructores
Select Count(*) As [Cantidad de usuarios que son instructores] From Usuarios As U 
inner join Instructores_x_Curso As IxC on U.ID = IxC.IDUsuario

-- 12 - Listado con la cantidad de usuarios distintos que se hayan certificado.
Select Count(*) As [Cantidad de usuarios distintos certificados] From Usuarios As U 
inner join Inscripciones As I on U.ID = I.IDUsuario
inner join Certificaciones As CE on I.ID = CE.IDInscripcion 

Select distinct * From Usuarios As U 
inner join Inscripciones As I on U.ID = I.IDUsuario
inner join Certificaciones As CE on I.ID = CE.IDInscripcion 
-- Usuarios distintos certificados 

-- 13 - Listado con el nombre del país y la cantidad de usuarios de cada país.
Select P.Nombre,Count(U.ID) As [Cantidad de usuarios x pais] From Paises As P
inner join Datos_Personales As DP on P.ID = DP.IDPais
inner join Usuarios As U on DP.ID = U.ID
Group by P.Nombre

Select DP.Nombres,P.Nombre From Paises As P
inner join Datos_Personales As DP on P.ID = DP.IDPais
inner join Usuarios As U on DP.ID = U.ID
-- Usuarios y sus paises

-- 14 - Listado con el apellido y nombres del usuario y el importe más costoso
-- abonado como pago. Sólo listar aquellos que hayan abonado más de $7500.
Select DP.Nombres + ', ' + DP.Apellidos As [Nombre y Apellido],Max(P.Importe) As [Importe mas costoso] From Datos_Personales As DP 
inner join Usuarios As U on DP.ID = U.ID
inner join Inscripciones As I on U.ID = I.IDUsuario
inner join Pagos As P on I.ID = P.IDInscripcion
Group by DP.Nombres,DP.Apellidos

-- 15 - Listado con el apellido y nombres de usuario y el importe más costoso de
-- curso al cual se haya inscripto.
Select DP.Apellidos,U.NombreUsuario,MAX(I.Costo) As [Importe maximo] From Datos_Personales As DP
inner join Usuarios As U on DP.ID = U.ID
inner join Inscripciones As I on U.ID = I.IDCurso
Group by DP.Apellidos,U.NombreUsuario

-- 16 - Listado con el nombre del curso, nombre del nivel, cantidad total de clases y
-- duración total del curso en minutos.
Select C.Nombre As [Nombre del curso],N.Nombre,COUNT(CL.ID) As [Cantidad total de clases],SUM(CL.Duracion*60) As [Duracion total en minutos] From Cursos As C
inner join Niveles As N on N.ID = C.IDNivel
inner join Clases As CL on C.ID = CL.IDCurso
Group by C.Nombre,N.Nombre

-- Multiplico la duracion de la clase por 60 porque esta en horas y me pide que la muestre en minutos

-- 17 - Listado con el nombre del curso y cantidad de contenidos registrados. Sólo
-- listar aquellos cursos que tengan más de 10 contenidos registrados.
Select C.Nombre,COUNT(CO.ID) As [Cantidad de contenidos registrados] From Cursos As C 
inner join Clases As CL on C.ID = CL.IDCurso
inner join Contenidos As CO on CL.ID = CO.IDClase
Group by C.Nombre
Having COUNT(CO.ID) > 10

-- 18 - Listado con nombre del curso, nombre del idioma y cantidad de tipos de idiomas.
Select C.Nombre,I.Nombre,Count(TI.ID) As [Cantidad de tipos de idiomas] From Cursos As C
inner join Idiomas_x_Curso As IxC on C.ID = IxC.IDCurso
inner join Idiomas As I on I.ID = IxC.IDIdioma
inner join TiposIdioma As TI on TI.ID = IxC.IDTipo 
Group by C.Nombre,I.Nombre

-- 19 - Listado con el nombre del curso y cantidad de idiomas distintos disponibles.
Select C.Nombre,Count(IxC.IDIdioma) As [Cantidad de idiomas distintos disponibles] From Cursos As C
inner join Idiomas_x_Curso As IxC on C.ID = IxC.IDCurso
Group by C.Nombre

-- Se supone que no hay dos veces Castellano por ejemplo para un curso no? o sea que cuando siempre distintos idiomas me parece

Select * From Idiomas

-- mmm aca son 6 idiomas nose porque cuenta 7 entonces

-- 20 - Listado de categorías de curso y cantidad de cursos asociadas a cada
-- categoría. Sólo mostrar las categorías con más de 5 cursos.
Select C.Nombre,COUNT(C.ID) As [Cantidad de cursos asociados] From Categorias As C 
inner join Categorias_x_Curso As CxC on C.ID = CxC.IDCategoria
inner join Cursos As CU on CU.ID = CxC.IDCurso 
Group by C.Nombre
Having COUNT(C.ID) > 5


-- 21 - Listado con tipos de contenido y la cantidad de contenidos asociados a cada
-- tipo. Mostrar también aquellos tipos que no hayan registrado contenidos con
-- cantidad 0.
Select TC.ID,TC.Nombre,COUNT(C.ID) As [Cantidad de contenidos asociados] From TiposContenido As TC 
inner join Contenidos As C on TC.ID = C.IDTipo
Group by TC.ID,TC.Nombre

Select * From TiposContenido
-- No hay contenidos asociados con cantidad 0

-- 22 - Listado con Nombre del curso, nivel, año de estreno y el total recaudado en
-- concepto de inscripciones. Listar también aquellos cursos sin inscripciones
-- con total igual a $0.
Select C.Nombre,N.Nombre,C.Estreno,SUM(I.Costo) As [Total recaudado en incripciones] From Cursos As C 
left join Niveles As N on C.IDNivel = N.ID
left join Inscripciones As I on N.ID = I.IDCurso
Group by C.Nombre,N.Nombre,C.Estreno
-- No hay recaudaciones para algunos cursos pero aparecen como NULL

Select * From Cursos
-- Para saber cuantos cursos hay

-- 23 - Listado con Nombre del curso, costo de cursado y certificación y cantidad de
-- usuarios distintos inscriptos cuyo costo de cursado sea menor a $10000 y
-- cuya cantidad de usuarios inscriptos sea menor a 5. Listar también aquellos
-- cursos sin inscripciones con cantidad 0.
Select C.Nombre,C.CostoCurso,C.CostoCertificacion,COUNT(U.ID) As [Cantidad de usuarios distintos] From  Cursos As C 
left join Inscripciones As I on C.ID = I.IDCurso
left join Usuarios As U on U.ID = I.IDUsuario
Where C.CostoCurso < 10000
Group by C.Nombre,C.CostoCurso,C.CostoCertificacion
Having COUNT(U.ID) < 5
-- Hay datos que no se muestran pero no cumplen alguno de las dos condiciones

Select * From Cursos
-- Para saber cuantos cursos hay

-- 24 - Listado con Nombre del curso, fecha de estreno y nombre del nivel del curso
-- que más recaudó en concepto de certificaciones.
Select C.Nombre,C.Estreno,N.Nombre,SUM(C.CostoCertificacion) As [Recaudacion de certificaciones] From Cursos As C
inner join Niveles As N on N.ID = C.IDNivel
Group by C.Nombre,C.Estreno,N.Nombre

-- 25 - Listado con Nombre del idioma del idioma más utilizado como subtítulo.
Select top 1 I.Nombre,TI.Nombre,COUNT(TI.ID) As [Cant. de Tipos de idiomas utilizado como sub.] From Idiomas As I 
inner join Idiomas_x_Curso As IxC on I.ID = IxC.IDIdioma
inner join TiposIdioma As TI on TI.ID =IxC.IDTipo
Where TI.Nombre = 'Subtítulo'
Group by I.Nombre,TI.Nombre

Select * From TiposIdioma
-- Para saber los tipos de idiomas que hay

-- 26 - Listado con Nombre del curso y promedio de puntaje de reseñas apropiadas.
Select C.Nombre,AVG(R.Puntaje) As [Promedio de puntaje de reseñas apropiadas] From Cursos As C 
inner join Inscripciones As I on C.ID = I.IDCurso
inner join Reseñas As R on I.ID = R.IDInscripcion
Where R.Inapropiada = 0
Group by C.Nombre

-- Este where me trae solo las reseñas no son inapropiadas

-- 27 - Listado con Nombre de usuario y la cantidad de reseñas inapropiadas que registró.
Select U.NombreUsuario,Count(R.Inapropiada) As [Cantidad de reseñas inapropiadas que registró] From Usuarios As U 
inner join Inscripciones As I on U.ID = I.IDUsuario
inner join Reseñas As R on I.ID = R.IDInscripcion
Group by U.NombreUsuario

-- 28 - Listado con Nombre del curso, nombre y apellidos de usuarios y la cantidad
-- de veces que dicho usuario realizó dicho curso. No mostrar cursos y usuarios
-- que contabilicen cero.
Select C.Nombre,DP.Nombres + ', ' + DP.Apellidos As [Nombre y Apellido],COUNT(U.ID) As [Cantidad de veces usuario realizó dicho curso] From Cursos As C
inner join Inscripciones As I on C.ID = I.IDCurso
inner join Usuarios As U on U.ID = I.IDUsuario
inner join Datos_Personales As DP on U.ID = DP.ID
Group by  C.Nombre,DP.Nombres,DP.Apellidos


-- 29 - Listado con Apellidos y nombres, mail y duración total en concepto de clases
-- de cursos a los que se haya inscripto. Sólo listar información de aquellos
-- registros cuya duración total supere los 400 minutos.
Select DP.Nombres + ', ' + DP.Apellidos As [Nombre y Apellido],Coalesce(DP.Email,DP.Celular,DP.Domicilio) As [Contacto],SUM(CL.Duracion) As [Duracion total]
From Datos_Personales As DP 
inner join Usuarios As U on DP.ID = U.ID
inner join Inscripciones As I on U.ID = I.IDUsuario
inner join Cursos As C on C.ID = I.IDCurso
inner join Clases As CL on C.ID = CL.IDCurso
Group by DP.Nombres,DP.Apellidos,DP.Email,DP.Celular,DP.Domicilio
Having SUM(CL.Duracion) > 400
-- La duracion ya esta en minutos asi que no tengo que hacer una conversion
-- isNull(DP.Email,DP.Celular) para que no queden campos con NULL
-- Podria usar Coalesce para que no quede ese NULL ahi

Select * From Clases
-- Para saber que contiene clases lo estoy haciendo de Memoria sin el DER

-- 30 - Listado con nombre del curso y recaudación total. La recaudación total
-- consiste en la sumatoria de costos de inscripción y de certificación. Listarlos
-- ordenados de mayor a menor por recaudación
Select C.Nombre,SUM(I.Costo + C.CostoCertificacion) As [Recaudacion total] From Cursos As C 
inner join Inscripciones As I on C.ID = I.IDCurso
Group by C.Nombre
Order by 2 DESC

-- El 2 hace referencia la 2 dato a mostrar
