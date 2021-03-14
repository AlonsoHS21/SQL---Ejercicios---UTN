Use MonkeyUniv

-- 1 - Listado con nombre de usuario de todos los usuarios y sus respectivos nombres y apellidos.
Select U.NombreUsuario,(DP.Nombres + ' ,  ' + DP.Apellidos) As [Nombre y apellidos] From Usuarios As U 
inner join Datos_Personales As DP on U.ID = DP.ID

-- 2 - Listado con apellidos, nombres, fecha de nacimiento y nombre del pa�s de nacimiento.
Select DP.Apellidos,DP.Nombres,DP.Nacimiento,P.Nombre As [Nombre Pais] From Datos_Personales As DP
inner join Paises As P on  P.ID = DP.IDPais

-- 3 - Listado con nombre de usuario, apellidos, nombres, email o celular de todos los usuarios que vivan en una domicilio cuyo nombre contenga el t�rmino
 -- 'Presidente' o 'General'.
 -- NOTA: Si no tiene email, obtener el celular.
Select U.NombreUsuario,(DP.Apellidos + ' , ' + DP.Nombres) As [Nombre y apellido],isNULL(DP.Email,DP.Celular) From Datos_Personales As DP 
inner join Usuarios As U on DP.ID = U.ID
-- isNull solo trabaja sobre dos valores
-- REFERENCIA: Funciona parecido a un if y else en C++ O C#	

-- 4 - Listado con nombre de usuario, apellidos, nombres, email o celular o domicilio como 'Informaci�n de contacto'.
-- NOTA: Si no tiene email, obtener el celular y si no posee celular obtener el domicilio.
Select U.NombreUsuario,DP.Apellidos,DP.Nombres,coalesce(Email,Celular,Domicilio) As [Informacion de contacto] 
From Usuarios As U 
inner join Datos_Personales As DP on U.ID = DP.ID

-- 5 - Listado con apellido y nombres, nombre del curso y costo de la inscripci�n de todos los usuarios inscriptos a cursos.
-- NOTA: No deben figurar los usuarios que no se inscribieron a ning�n curso
Select (DP.Apellidos + ' , ' + DP.Nombres),C.Nombre,I.Costo
From Datos_Personales As DP
inner join Usuarios As U on DP.ID = U.ID
inner join Inscripciones As I on U.ID = I.IDUsuario
inner join Cursos As C on C.ID = I.IDCurso

-- El inner join hace que no figuren los usuarios que no se inscribieron a ningun curso, no se necesita una validacion extr

Select * From Usuarios As U
left join Inscripciones As I on U.ID = I.IDUsuario
left join Cursos As C on C.ID = I.IDCurso

-- Uso el left join para saber los usuarios no inscriptos

-- 6 - Listado con nombre de curso, nombre de usuario y mail de todos los inscriptos a cursos que se hayan estrenado en el a�o 2020.
Select C.Nombre As [Nombre Cursos],U.NombreUsuario,DP.Email From Cursos As C
inner join Inscripciones As I on C.ID = I.IDCurso
inner join Usuarios As U on U.ID = I.IDUsuario
inner join Datos_Personales As DP on DP.ID = U.ID
Where Year(C.Estreno) = 2020


-- 7 - Listado con nombre de curso, nombre de usuario, apellidos y nombres, fecha de inscripci�n, costo certificacion, fecha de pago e importe de pago. S�lo
-- listar informaci�n de aquellos que hayan pagado.
Select C.Nombre As [Nombre del curso],U.NombreUsuario,(DP.Apellidos + ' , ' + DP.Nombres) As [Apellidos y nombres],C.CostoCertificacion,I.Fecha,I.Costo
From Cursos As C
inner join Inscripciones As I on C.ID = I.IDCurso
inner join Usuarios As U on U.ID = I.IDUsuario
inner join Datos_Personales As DP on U.ID = DP.ID

-- el inner se encarga de listar solo aquellos que pagaron

-- 8 -  Listado con nombre y apellidos, genero, fecha de nacimiento, mail, nombre del curso y fecha de certificaci�n de todos aquellos usuarios que se hayan certificado.
Select DP.Nombres,DP.Apellidos,DP.Genero,DP.Nacimiento,DP.Email,C.Nombre,CE.Fecha As [Fecha Inscripcion],I.IDUsuario,I.ID
From Datos_Personales As DP
inner join Usuarios As U on DP.ID = U.ID
inner join Inscripciones As I on U.ID = I.IDUsuario
inner join Cursos As C on C.ID = I.IDCurso
inner join Certificaciones As CE on I.ID = CE.IDInscripcion

-- Es medio rebuscado el enunciado o solo me parece a mi??

-- 9 - Listado de cursos con nombre, costo de cursado y certificaci�n, costo total (cursado + certificaci�n) con 10% de todos los cursos de nivel Principiante.
Select C.Nombre,C.CostoCurso,C.CostoCertificacion,((c.CostoCertificacion+C.CostoCurso)*1.10) As [Costo total] 
From Cursos As C
inner join Niveles As N on C.IDNivel = N.ID
Where N.Nombre = 'Principiante'
Group by C.Nombre,C.CostoCurso,C.CostoCertificacion 

-- A costo total le sumo el 10% no me quedo claro

-- 10 - Listado con nombre y apellido y mail de todos los instructores. Sin repetir.
Select Distinct DP.Nombres,DP.Apellidos,DP.Email
From Datos_Personales As DP
inner join Usuarios As U on DP.ID = U.ID
left join Instructores_x_Curso As IxC on U.ID = IxC.IDUsuario

-- Un INSTRUCTOR puede no tener id Usuario?? no lo tengo claro

-- 11 - Listado con nombre y apellido de todos los usuarios que hayan cursado alg�n curso cuya categor�a sea 'Historia'.
Select Distinct DP.Nombres,DP.Apellidos
From Datos_Personales As DP
inner join Usuarios As U on DP.ID = U.ID
inner join Inscripciones As I on U.ID = I.IDUsuario
inner join Cursos As C on C.ID = I.IDCurso
inner join Categorias_x_Curso As CxC on C.ID = CxC.IDCurso
inner join Categorias As CAT on CAT.ID = CAT.ID
Where CAT.Nombre = 'Historia'

-- Agregue un disctinct porque me tiraba mas de 100 usuarios repetidos
-- Dios cuantos inner join, con una subconsulta seria mas facil jaja

-- 12 - Listado con nombre de idioma, c�digo de curso y c�digo de tipo de idioma. Listar todos los idiomas indistintamente si no tiene cursos relacionados.

-- 13 - Listado con nombre de idioma de todos los idiomas que no tienen cursos relacionados.

-- 14 - Listado con nombres de idioma que figuren como audio de alg�n curso. Sin repeticiones.

-- 15 - Listado con nombres y apellidos de todos los usuarios y el nombre del pa�s en el que nacieron. Listar todos los pa�ses indistintamente si no tiene usuarios relacionados.

-- 16 - Listado con nombre de curso, fecha de estreno y nombres de usuario de todos los inscriptos. Listar todos los nombres de usuario indistintamente si no se inscribieron a ning�n curso.

-- 17 - Listado con nombre de usuario, apellido, nombres, g�nero, fecha de nacimiento y mail de todos los usuarios que no cursaron ning�n curso.

-- 18 - Listado con nombre y apellido, nombre del curso, puntaje otorgado y texto de la rese�a. S�lo de aquellos usuarios que hayan realizado una rese�a inapropiada.

-- 19 - Listado con nombre del curso, costo de cursado, costo de certificaci�n, nombre del idioma y nombre del tipo de idioma de todos los cursos cuya  fecha de estreno haya sido antes del a�o actual.
-- Ordenado por nombre del curso y luego por nombre de tipo de idioma. Ambos ascendentemente.
 
-- 20 - Listado con nombre del curso y todos los importes de los pagos relacionados.

-- 21 - Listado con nombre de curso, costo de cursado y una leyenda que indique "Costoso" si el costo de cursado es mayor a $ 15000, "Accesible" si el costo de cursado est� entre $2500 y $15000, "Barato" si 
-- el costo est� entre $1 y $2499 y "Gratis" si el costo es $0.






