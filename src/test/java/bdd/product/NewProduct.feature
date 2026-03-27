Feature: New Product
  Background:
    * def nuevoprodresponse = call read('classpath:bdd/auth/loginAuth.feature@automation-api')
    * print nuevoprodresponse
    * def token = nuevoprodresponse.response.access_token
    * print token
    Given url "https://api.qateamperu.com"
@automation-api
    Scenario Outline: CP<n> - Crear nuevo producto: <nombre>
      And path "api/v1/producto"
      And header Authorization = "Bearer "+token
      And request
      """
    {
    "codigo": <codigo>,
    "nombre": <nombre>,
    "medida": <medida>,
    "marca":  <marca>,
    "categoria": <categoria>,
    "precio": <precio>,
    "stock":  <stock>,
    "estado": <estado>,
    "descripcion": <descripcion>
    }
    """
      When method post
      Then status 500
         * print response
      # una vez generados los nuevos productos el status varia de 200 a 500 por el tema de la base de datos, se puede usar el mismo escenario para generar nuevos productos y validar el status 200 o 500 dependiendo del caso
      Examples:
      | read('classpath:resources/csv/auth/bodynewprod.csv') |