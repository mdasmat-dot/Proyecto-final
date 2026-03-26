Feature: New Product
  Background:
    * def nuevoprodresponse = call read('classpath:bdd/auth/loginAuth.feature@CP03')
    * print nuevoprodresponse
    * def token = nuevoprodresponse.response.access_token
    * print token
    Given url "https://api.qateamperu.com"

    Scenario Outline: CP<n> - Create new product
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
      Then status 200
      Examples:
      | read('classpath:resourses/csv/auth/bodynewprod.csv') |