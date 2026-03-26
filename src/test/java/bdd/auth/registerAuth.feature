Feature: Registro
  Background:
    * def registrobody = read('classpath:resources/json/auth/registerbody.json')
    * def respuestadelregistro = read('classpath:resources/json/auth/validacionderegistro.json')
    Given url "https://api.qateamperu.com"

@ CPregistro
Scenario Outline: CP0<n> - usuario <usuario>-Registro
  # email dinamico para evitar que el mismo correo se registre mas de una vez
  * def random = Math.floor(Math.random() * 100000)
  * set registrobody.email = 'qa' + random + '@mail.com'
  # mapear datos del Examples
  * set registrobody.password = "<password>"
  * set registrobody.nombre = "<nombre>"
  * set registrobody.tipo_usuario_id = "<tipo_usuario_id>"
  * set registrobody.estado = "<estado>"
And path "api/register"
And request registrobody
When method post
Then status 200
  And match response.data.nombre == '#string'
  And match response.data.tipo_usuario_id == '#string'
  And match response.data.estado == '#string'
  And match response.data.email == '#string'
  And match response.data.password == '#string'
  And match response.data.id == '#number'
  And match response.access_token == '#string'
  And match response.token_type == '#string'
  * print response
  # guarda datos de segunda iteracion en variables
  * def nombre1 = response.data.nombre
  * def email1 = response.data.email
  * def token1 = response.access_token
  * def id1 = response.data.id
  * def estado1 = response.data.estado

  * print nombre1
  * print email1
  * print token1
  * print id1
  * print estado1

  Examples:
|n|usuario|password|nombre|tipo_usuario_id|estado|
|1|mario|23456789|Mario|2|1|
|2|carlos|12345678|Carlos|1|5|
  #el password debe tener mas de 8 caracteres para que el registro sea exitoso, por eso el segundo caso es negativo





