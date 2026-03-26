Feature: Cambio contraseña
  Background:
    Given url "https://api.qateamperu.com"

    Scenario: CP01 - Cambiar contraseña

        * def cambioresponse = call read('classpath:bdd/auth/loginAuth.feature@CP03')
        * print cambioresponse
        * def autcontrasenanueva = cambioresponse.response.access_token
        * print autcontrasenanueva

        And path "api/reset-password"
        And header Authorization = "Bearer "+autcontrasenanueva
        And request {"email": "carlosqateam@gmail.com", "new_password": "carlos1234"}
        When method post
        Then status 201
      * def BearerToken = "Bearer "+autcontrasenanueva
        * print BearerToken