Feature: Update Product
  Background:
    Given url "https://api.qateamperu.com"
@automation-api
    Scenario Outline: CP<n> - Update product con id producto #<idprod>
      * def updateprodresponse = call read('classpath:bdd/auth/loginAuth.feature@automation-api')
      * print updateprodresponse
      * def token = updateprodresponse.response.access_token
      * print token
      And header Authorization = "Bearer "+token
      And header Content-Type = "application/json"
      And path "/api/v1/producto/"+<idprod>
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
      * def body =
      """ {
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
         * print body
      # En el body los campos marca y categoria conservan los valores Generico y Repuestos respectivamente para evitar problemas con la base de datos, se pueden cambiar dependiendo del caso pero siempre deben ser valores que existan en la base de datos, el id del producto a actualizar también debe existir en la base de datos para evitar errores, dependiendo del caso el status puede variar entre 200 y 500 por el tema de la base de datos
    When method put
    Then status 200
      And match response.id == '#number'
      And match response.codigo == '#string'
      And match response.medida == '#string'
      And match response.marca_id == '#number'
      And match response.categoria_id == '#number'
      And match response.precio == '#string'
      And match response.stock == '#number'
      And match response.estado == '#number'
      And match response.descripcion == '#string'
      And match response.created_at == '#string'
      * print response
         # se puede usar el mismo escenario para actualizar diferentes productos cambiando el id del producto a actualizar y los datos del producto en el body, dependiendo del caso el status puede variar entre 200 y 500 por el tema de la base de datos

      Examples:
        | read('classpath:resources/csv/auth/updateprod.csv') |

