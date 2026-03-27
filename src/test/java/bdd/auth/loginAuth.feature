Feature: Autorización
  Background:
  Given url "https://api.qateamperu.com"


  # dos escenarios login correcto y login incorrecto
    Scenario Outline: CP0<n> - <Logintest>

      And path "api/login"
      And request {"email": <email>, "password": <password>}
      When method post
      Then status 200
      And match response.message == "#string"
      And match response.access_token == "#string"
      And match response.token_type == "#string"
        * def tokendeacceso = response.access_token
        * print tokendeacceso
        * print response
  # del login correcto se guarda el token de acceso para usarlo en el logout.feature, en el registerAuth.feature se guarda el token de acceso del registro para usarlo en el logout.feature
        Examples:
  |n|email|password|Logintest|
  |1|pilarsant@gmail.com|pilar1234|Login incorrecto |
  |2|mdasmat12@gmail.com|123456723448|Login correcto|

      # CP03 Escenario Login correcto para ser usado en el  en el cambio de contraseña

  @automation-api
  Scenario: CP03- Login correcto para uso en logout y cambio de contraseña

    And path "api/login"
    And request {"email": "mdasmat12@gmail.com", "password": "123456723448"}
    When method post
    Then status 200
    * def tokendeacceso = response.access_token
    * print tokendeacceso
    * print response


