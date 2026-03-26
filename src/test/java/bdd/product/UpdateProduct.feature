Feature: Update Product
  Background:
    Given url "https://api.qateamperu.com"

    Scenario Outline: CP<n> - Update product
      * def updateprodresponse = call read('classpath:bdd/auth/loginAuth.feature@CP03')
      * print updateprodresponse
      * def token = updateprodresponse.response.access_token
      * def idprod = 505
      * print token
      And path "/api/v1/producto/"+idprod
      And header Authorization = "Bearer "+token
      And header Content-Type = "application/json"
      And request
      """
      {
    "codigo": <codigo>,
    "nombre": <nombre>,
    "medida": <medida>,
    "marca": <marca>,
    "categoria": <categoria>,
    "precio": <precio>,
    "stock": <stock>,
    "estado": <estado>,
    "descripcion": <descripcion>
}
      """
      * print request
    When method put
    Then status 200
      And match response.nombre == <nombre>
      And match response.precio == <precio>
      And match response.stock == <stock>
      And match response.descripcion == <descripcion>
      And match response.estado == <estado>


      Examples:
        | read('classpath:resources/csv/auth/updateprod.csv') |

