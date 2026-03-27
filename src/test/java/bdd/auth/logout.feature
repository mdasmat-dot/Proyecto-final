Feature: Logout
  Background:
    Given url "https://api.qateamperu.com"
    * def loginresponse = call read('classpath:bdd/auth/loginAuth.feature@automation-api')
    * print loginresponse
    * def tokendeautorizacion = loginresponse.response.access_token
    * print tokendeautorizacion

    Scenario: CP01 - Logout
      And path "api/logout"
      * def autorizaciondeingreso = "Bearer "+tokendeautorizacion
      And header Authorization = autorizaciondeingreso
      * print autorizaciondeingreso
      When method get
      Then status 200

