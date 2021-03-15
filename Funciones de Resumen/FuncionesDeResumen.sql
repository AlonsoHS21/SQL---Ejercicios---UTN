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


-- 16 - Listado con el nombre del curso, nombre del nivel, cantidad total de clases y
-- duración total del curso en minutos.

-- 17 - Listado con el nombre del curso y cantidad de contenidos registrados. Sólo
-- listar aquellos cursos que tengan más de 10 contenidos registrados.

-- 18 - Listado con nombre del curso, nombre del idioma y cantidad de tipos de idiomas.

-- 19 - Listado con el nombre del curso y cantidad de idiomas distintos disponibles.

-- 20 - Listado de categorías de curso y cantidad de cursos asociadas a cada
-- categoría. Sólo mostrar las categorías con más de 5 cursos.

-- 21 - Listado con tipos de contenido y la cantidad de contenidos asociados a cada
-- tipo. Mostrar también aquellos tipos que no hayan registrado contenidos con
-- cantidad 0.

-- 22 - Listado con Nombre del curso, nivel, año de estreno y el total recaudado en
-- concepto de inscripciones. Listar también aquellos cursos sin inscripciones
-- con total igual a $0.

-- 23 - Listado con Nombre del curso, costo de cursado y certificación y cantidad de
-- usuarios distintos inscriptos cuyo costo de cursado sea menor a $10000 y
-- cuya cantidad de usuarios inscriptos sea menor a 5. Listar también aquellos
-- cursos sin inscripciones con cantidad 0.
-- 24 - Listado con Nombre del curso, fecha de estreno y nombre del nivel del curso
-- que más recaudó en concepto de certificaciones.

-- 25 - Listado con Nombre del idioma del idioma más utilizado como subtítulo.

-- 26 - Listado con Nombre del curso y promedio de puntaje de reseñas apropiadas
-- 27 - Listado con Nombre de usuario y la cantidad de reseñas inapropiadas que registró.

-- 28 - Listado con Nombre del curso, nombre y apellidos de usuarios y la cantidad
-- de veces que dicho usuario realizó dicho curso. No mostrar cursos y usuarios
-- que contabilicen cero.

-- 29 - Listado con Apellidos y nombres, mail y duración total en concepto de clases
-- de cursos a los que se haya inscripto. Sólo listar información de aquellos
-- registros cuya duración total supere los 400 minutos.

-- 30 - Listado con nombre del curso y recaudación total. La recaudación total
-- consiste en la sumatoria de costos de inscripción y de certificación. Listarlos
-- ordenados de mayor a menor por recaudación
