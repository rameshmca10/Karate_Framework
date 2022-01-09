Feature: Incident Management

  Scenario: Get all Incidents xml with query paramters
    Given url 'https://dev62655.service-now.com/api/now/table/incident'
    And header Authorization = 'Basic YWRtaW46ZVRieDkyUHB6Rk9a'
    And header accept = 'application/xml'
    And param sysparm_fields = 'number,sys_id,category,short_description'
    When method get
    And print response

  Scenario: Get all Incidents json all parameters
    Given url 'https://dev62655.service-now.com/api/now/table/incident'
    And header Authorization = 'Basic YWRtaW46ZVRieDkyUHB6Rk9a'
    When method get
    And print response

  Scenario: Get all Incidents json all parameters assetions
    Given url 'https://dev62655.service-now.com/api/now/table/incident'
    And header Authorization = 'Basic YWRtaW46ZVRieDkyUHB6Rk9a'
    When method get
    Then status 200
    And match responseType == 'json'
    And print response

  Scenario: Post Incident no body
    Given url 'https://dev62655.service-now.com/api/now/table/incident'
    And header Authorization = 'Basic YWRtaW46ZVRieDkyUHB6Rk9a'
    And request {}
    When method post
    Then status 201
    And match responseType == 'json'
    And print response
    And def sys_id = response.result.sys_id

  Scenario: Post Incident json body
    Given url 'https://dev62655.service-now.com/api/now/table/incident'
    And header Authorization = 'Basic YWRtaW46ZVRieDkyUHB6Rk9a'
    And header content-Type = 'application/json'
    And request Karate.readAsString('data/CreateAnIssue.json')
    When method post
    Then status 201
    And match responseType == 'json'
    And print response

  Scenario: Delete Incident
    Given url 'https://dev62655.service-now.com/api/now/table/incident'
    And header Authorization = 'Basic YWRtaW46ZVRieDkyUHB6Rk9a'
    And request {}
    When method post
    Then status 201
    And match responseType == 'json'
    And print response
    And def sys_id = response.result.sys_id
    Given url 'https://dev62655.service-now.com/api/now/table/incident/'+sys_id
    When method delete
    Then status 204
    And print response
