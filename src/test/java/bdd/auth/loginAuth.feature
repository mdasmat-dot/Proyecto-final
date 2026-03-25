Feature: Autorización
  Background:
  Given url "https://api.qateamperu.com"

@CP01
    Scenario: CP01 - Login con
      * def body = read('classpath:resources/json/auth/bodyLogin.json')
      And path "api/login"
      And request body
      When method post
      Then status 200
      And match response.message == "#string"
      And match response.access_token == "#string"
      And match response.token_type == "#string"
        * def tokendeacceso = response.access_token
        * print tokendeacceso

Scenario: CP02 - Registro
  * def registrobody = read('classpath:resources/json/auth/registerbody.json')
  And path "api/register"
    And request registrobody
    When method post
    Then status 200
    * print response

  Scenario: CP03 - LogOut
    And path "api/logout"
    And header Authorization = "Bearer"+tokendeacceso
    When method get
    Then status 200
    * print response


