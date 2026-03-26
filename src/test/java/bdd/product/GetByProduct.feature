Feature: Get Product
  Background:
    Given url "https://api.qateamperu.com"

    Scenario Outline: CP<n> - Get producto por codigo codigo producto #<idproducto>
      And path "api/v1/producto/"+<idproducto>
       * def getprodresponse = call read('classpath:bdd/auth/loginAuth.feature@CP03')
       * print getprodresponse
       * def token = getprodresponse.response.access_token
       * print token
       And header Authorization = "Bearer "+token
       And header Content-Type = "application/json"
      When method get
      Then status 200
      And match response.id  == "#number"
      And match response.codigo == "#string"
        And match response.nombre == "#string"
        And match response.medida == "#string"
        And match response.marca == "#string"
        And match response.categoria == "#string"
        And match response.precio == "#string"
        And match response.stock == "#number"
        And match response.estado == "#number"
        And match response.descripcion == "#string"
      * print response

        Examples:
            | read('classpath:resources/csv/auth/getprod.csv') |

