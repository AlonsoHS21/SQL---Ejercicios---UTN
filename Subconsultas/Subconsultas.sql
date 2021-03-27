use MonkeyUniv

-- 1 - Listado con apellidos y nombres de los usuarios que no se hayan inscripto a cursos durante el año 2019.
Select (Nombres + ',' +  Apellidos) As [Nombres y Apellidos] From Datos_Personales 
Where ID NOT IN (Select IDUsuario From Inscripciones Where Year(Fecha) = 2019)

-- 2 - Listado con apellidos y nombres de los usuarios que se hayan inscripto a cursos pero no hayan realizado ningún pago.
Select (Nombres + ',' +  Apellidos) As [Nombres y Apellidos] From Datos_Personales 

-- 3 - Listado de países que no tengan usuarios relacionados
Select * From Paises 
Where ID NOT IN (Select IDPais From Datos_Personales) 

Select * From Paises As P 
inner join Datos_Personales As DP on P.ID = DP.IDPais
Where P.Nombre = 'Inglaterra'
-- Esto es para comprobar que no hay ningun pais listado relacionado a un usuario

-- 4 - Listado de clases cuya duración sea mayor a la duración promedio
Select * From Clases Where 
Duracion > (Select AVG(Duracion) From Clases)

Select AVG(Duracion) From Clases
--Duracion progremadio de clases

-- 5 - Listado de contenidos cuyo tamaño sea mayor al tamaño de todos los contenidos de tipo 'Audio de alta calidad'.
Select * From Contenidos 
Where Tamaño > (Select SUM(Tamaño) From Contenidos Where IDTipo = 1)
-- 1 es el id del tipo de contenido de 'Audio de alta calidad'
Select * From TiposContenido
-- Para saber el ID de 'Audio de alta calidad'
Select * From Contenidos
-- Para saber la cantidad de contenidos

-- 6 - Listado de contenidos cuyo tamaño sea menor al tamaño de algún contenido de tipo 'Audio de alta calidad'.
Select * From Contenidos 
Where Tamaño < (Select SUM(Tamaño) From Contenidos Where IDTipo = 1)

-- 7 - Listado con nombre de país y la cantidad de usuarios de género masculino y
-- la cantidad de usuarios de género femenino que haya registrado.
Select Nombre,
(Select COUNT(ID) From Datos_Personales Where Genero = 'M' and IDPais = P.ID) As [Cantidad de personas Masculinas],
(Select COUNT(ID) From Datos_Personales Where Genero = 'F' and IDPais = P.ID) As [Cantidad de personas Femeninas] 
From Paises As P

Select * From Datos_Personales

-- 8 - Listado con apellidos y nombres de los usuarios y la cantidad de inscripciones
-- realizadas en el 2019 y la cantidad de inscripciones realizadas en el 2020.
Select (Apellidos + ',' + Nombres) As [Apellido y Nombres],
(Select COUNT(ID) From Inscripciones Where Year(Fecha) = 2019 and IDUsuario = DP.ID) As [Cantidad de inscripciones en 2019],
(Select COUNT(ID) From Inscripciones Where Year(Fecha) = 2020 and IDUsuario = DP.ID) As [Cantidad de inscripciones en 2020]
From Datos_Personales As DP

-- 9 - Listado con nombres de los cursos y la cantidad de idiomas de cada tipo. Es
-- decir, la cantidad de idiomas de audio, la cantidad de subtítulos y la cantidad de texto de video.
Select Nombre,
(Select COUNT(IDIdioma) From Idiomas_x_Curso Where IDTipo = 1 and IDCurso = C.ID )As [Cantidad de idiomas de tipo subtitulo],
(Select COUNT(IDIdioma) From Idiomas_x_Curso Where IDTipo = 2 and IDCurso = C.ID )As [Cantidad de idiomas de tipo audio],
(Select COUNT(IDIdioma) From Idiomas_x_Curso Where IDTipo = 3 and IDCurso = C.ID )As [Cantidad de idiomas de tipo texto]
From Cursos As C

Select * From TiposIdioma
--Para conocer los id de los tipos de idiomas asi me ahorro hacer un inner join

-- 10 - Listado con apellidos y nombres de los usuarios, nombre de usuario y
-- cantidad de cursos de nivel 'Principiante' que realizó y cantidad de cursos de nivel 'Avanzado' que realizó.
Select (Apellidos + ',' + Nombres) As [Apellido y Nombres],
(Select nombreusuario From Usuarios Where ID = DP.ID) As [Nombre usuario],
(Select COUNT(C.ID) From Cursos As C 
inner join Inscripciones As I on C.ID = I.IDCurso Where IDNivel = 5 and DP.ID = I.IDUsuario) As [Cantidad de cursos Principiantes],
(Select COUNT(C.ID) From Cursos As C 
inner join Inscripciones As I on C.ID = I.IDCurso Where IDNivel = 3 and DP.ID = I.IDUsuario) As [Cantidad de cursos Avanzado]
From Datos_Personales As DP 

Select * From Niveles
-- Para saber los id de niveles de los cursos

-- 11 - Listado con nombre de los cursos y la recaudación de inscripciones de
-- usuarios de género femenino que se inscribieron y la recaudación de
-- inscripciones de usuarios de género masculino.
Select Nombre,
(Select SUM(I.Costo) From Datos_Personales As DP
inner join Usuarios As U on DP.ID = U.ID 
inner join Inscripciones As I on U.ID = I.IDUsuario Where Genero = 'M' and C.ID = I.IDCurso) As [Recaudacion de usuario Masculinos],
(Select SUM(I.Costo) From Datos_Personales As DP
inner join Usuarios As U on DP.ID = U.ID 
inner join Inscripciones As I on U.ID = I.IDUsuario Where Genero = 'F' and C.ID = I.IDCurso) As [Recaudacion de usuario Femeninos]
From Cursos As C

-- 12 - Listado con nombre de país de aquellos que hayan registrado más usuarios
-- de género masculino que de género femenino.
Select * From (
Select Nombre,
(Select COUNT(ID) From Datos_Personales Where Genero = 'M' and IDPais = P.ID) As CantM,
(Select COUNT(ID) From Datos_Personales Where Genero = 'F' and IDPais = P.ID) As CantF
From Paises As P) As AUX
Where AUX.CantM > AUX.CantF


-- 13 - Listado con nombre de país de aquellos que hayan registrado más usuarios
-- de género masculino que de género femenino pero que haya registrado al
-- menos un usuario de género femenino.
Select * From (
Select Nombre,
(Select COUNT(ID) From Datos_Personales Where Genero = 'M' and IDPais = P.ID) As CantM,
(Select COUNT(ID) From Datos_Personales Where Genero = 'F' and IDPais = P.ID) As CantF
From Paises As P) As AUX
Where AUX.CantM > AUX.CantF and AUX.CantF > 0

-- 14 - Listado de cursos que hayan registrado la misma cantidad de idiomas de audio que de subtítulos.
Select * From (
Select *,
(Select COUNT(IDIdioma) From Idiomas_x_Curso Where IDTipo = 2 and C.ID = IDCurso) As CantAudio,
(Select COUNT(IDIdioma) From Idiomas_x_Curso Where IDTipo = 1 and C.ID = IDCurso) As CantSub
From Cursos As C) As AUX
Where AUX.CantAudio = AUX.CantSub

Select * From TiposIdioma
-- Para saber el id del tipo de idioma

-- 15 - Listado de usuarios que hayan realizado más cursos en el año 2018 que en el
-- 2019 y a su vez más cursos en el año 2019 que en el 2020.
Select  * From(
Select *,
(Select COUNT(*) From Cursos As C 
inner join Inscripciones As I on C.ID = I.IDCurso
Where YEAR(C.Estreno) = 2018 and I.IDUsuario = U.ID) As CantCursos2018,
(Select COUNT(*) From Cursos As C 
inner join Inscripciones As I on C.ID = I.IDCurso
Where YEAR(C.Estreno) = 2019 and I.IDUsuario = U.ID) As CantCursos2019,
(Select COUNT(*) From Cursos As C 
inner join Inscripciones As I on C.ID = I.IDCurso
Where YEAR(C.Estreno) = 2020 and I.IDUsuario = U.ID) As CantCursos2020
From Usuarios As U) As AUX
Where AUX.CantCursos2018 > AUX.CantCursos2019 and AUX.CantCursos2019 > AUX.CantCursos2020

-- No hay ningun usuario que cumpla estas condiciones

-- 16 -Listado de apellido y nombres de usuarios que hayan realizado cursos pero nunca se hayan certificado.
Select * From Datos_Personales Where ID NOT IN 
(Select I.IDUsuario From Inscripciones As I 
inner join Certificaciones As C on I.ID = C.IDInscripcion)