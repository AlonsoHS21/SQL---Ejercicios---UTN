use MonkeyUniv

-- 1 - Listado con la cantidad de cursos.
Select Count(*) As [Cantidad de cursos] From Cursos

-- 2 - Listado con la cantidad de usuarios.
Select Count(*) As [Cantidad de usuarios] From Usuarios

-- 3 - Listado con el promedio de costo de certificaci�n de los cursos.
Select Round(AVG(CostoCertificacion),2,0) As [Costo de certificacion] From Cursos
-- Round redondea a dos decimales en este caso

-- 4 -  Listado con el promedio general de calificaci�n de rese�as.
Select AVG(Puntaje) As [Promedio general de calificacion] From Rese�as

-- 5 - Listado con la fecha de estreno de curso m�s antigua.
Select MIN(Year(Estreno)) As [Estreno de curso mas antiguo] From Cursos

-- 6 - Listado con el costo de certificaci�n menos costoso.
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

-- 13 - Listado con el nombre del pa�s y la cantidad de usuarios de cada pa�s.
Select P.Nombre,Count(U.ID) As [Cantidad de usuarios x pais] From Paises As P
inner join Datos_Personales As DP on P.ID = DP.IDPais
inner join Usuarios As U on DP.ID = U.ID
Group by P.Nombre

Select DP.Nombres,P.Nombre From Paises As P
inner join Datos_Personales As DP on P.ID = DP.IDPais
inner join Usuarios As U on DP.ID = U.ID
-- Usuarios y sus paises

-- 14 - Listado con el apellido y nombres del usuario y el importe m�s costoso
-- abonado como pago. S�lo listar aquellos que hayan abonado m�s de $7500.
Select DP.Nombres + ', ' + DP.Apellidos As [Nombre y Apellido],Max(P.Importe) As [Importe mas costoso] From Datos_Personales As DP 
inner join Usuarios As U on DP.ID = U.ID
inner join Inscripciones As I on U.ID = I.IDUsuario
inner join Pagos As P on I.ID = P.IDInscripcion
Group by DP.Nombres,DP.Apellidos

-- 15 - Listado con el apellido y nombres de usuario y el importe m�s costoso de
-- curso al cual se haya inscripto.


-- 16 - Listado con el nombre del curso, nombre del nivel, cantidad total de clases y
-- duraci�n total del curso en minutos.

-- 17 - Listado con el nombre del curso y cantidad de contenidos registrados. S�lo
-- listar aquellos cursos que tengan m�s de 10 contenidos registrados.

-- 18 - Listado con nombre del curso, nombre del idioma y cantidad de tipos de idiomas.

-- 19 - Listado con el nombre del curso y cantidad de idiomas distintos disponibles.

-- 20 - Listado de categor�as de curso y cantidad de cursos asociadas a cada
-- categor�a. S�lo mostrar las categor�as con m�s de 5 cursos.

-- 21 - Listado con tipos de contenido y la cantidad de contenidos asociados a cada
-- tipo. Mostrar tambi�n aquellos tipos que no hayan registrado contenidos con
-- cantidad 0.

-- 22 - Listado con Nombre del curso, nivel, a�o de estreno y el total recaudado en
-- concepto de inscripciones. Listar tambi�n aquellos cursos sin inscripciones
-- con total igual a $0.

-- 23 - Listado con Nombre del curso, costo de cursado y certificaci�n y cantidad de
-- usuarios distintos inscriptos cuyo costo de cursado sea menor a $10000 y
-- cuya cantidad de usuarios inscriptos sea menor a 5. Listar tambi�n aquellos
-- cursos sin inscripciones con cantidad 0.
-- 24 - Listado con Nombre del curso, fecha de estreno y nombre del nivel del curso
-- que m�s recaud� en concepto de certificaciones.

-- 25 - Listado con Nombre del idioma del idioma m�s utilizado como subt�tulo.

-- 26 - Listado con Nombre del curso y promedio de puntaje de rese�as apropiadas
-- 27 - Listado con Nombre de usuario y la cantidad de rese�as inapropiadas que registr�.

-- 28 - Listado con Nombre del curso, nombre y apellidos de usuarios y la cantidad
-- de veces que dicho usuario realiz� dicho curso. No mostrar cursos y usuarios
-- que contabilicen cero.

-- 29 - Listado con Apellidos y nombres, mail y duraci�n total en concepto de clases
-- de cursos a los que se haya inscripto. S�lo listar informaci�n de aquellos
-- registros cuya duraci�n total supere los 400 minutos.

-- 30 - Listado con nombre del curso y recaudaci�n total. La recaudaci�n total
-- consiste en la sumatoria de costos de inscripci�n y de certificaci�n. Listarlos
-- ordenados de mayor a menor por recaudaci�n
