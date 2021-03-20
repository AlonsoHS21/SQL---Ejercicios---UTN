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


-- 5 - Listado de contenidos cuyo tamaño sea mayor al tamaño de todos los contenidos de tipo 'Audio de alta calidad'.

-- 6 - Listado de contenidos cuyo tamaño sea menor al tamaño de algún contenido de tipo 'Audio de alta calidad'.

-- 7 - Listado con nombre de país y la cantidad de usuarios de género masculino y
-- la cantidad de usuarios de género femenino que haya registrado.

-- 8 - Listado con apellidos y nombres de los usuarios y la cantidad de inscripciones
-- realizadas en el 2019 y la cantidad de inscripciones realizadas en el 2020.

-- 9 - Listado con nombres de los cursos y la cantidad de idiomas de cada tipo. Es
-- decir, la cantidad de idiomas de audio, la cantidad de subtítulos y la cantidad de texto de video.

-- 10 - Listado con apellidos y nombres de los usuarios, nombre de usuario y
-- cantidad de cursos de nivel 'Principiante' que realizó y cantidad de cursos de nivel 'Avanzado' que realizó.

-- 11 - Listado con nombre de los cursos y la recaudación de inscripciones de
-- usuarios de género femenino que se inscribieron y la recaudación de
-- inscripciones de usuarios de género masculino.

-- 12 - Listado con nombre de país de aquellos que hayan registrado más usuarios
-- de género masculino que de género femenino.

-- 13 - Listado con nombre de país de aquellos que hayan registrado más usuarios
-- de género masculino que de género femenino pero que haya registrado al
-- menos un usuario de género femenino.

-- 14 - Listado de cursos que hayan registrado la misma cantidad de idiomas de audio que de subtítulos.

-- 15 - Listado de usuarios que hayan realizado más cursos en el año 2018 que en el
-- 2019 y a su vez más cursos en el año 2019 que en el 2020.

-- 16 -Listado de apellido y nombres de usuarios que hayan realizado cursos pero nunca se hayan certificado