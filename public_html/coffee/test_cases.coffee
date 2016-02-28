# Sample data structures for form inputs

# Missing Some Contact Info
data1 =
  'eligibility': 'type': 'financial'
  'parent':
    'parentFirstName': 'Jatin'
    'parentLastName': 'Frost'
    'email': ''
    'phone': ''
    'address': ''
    'city': ''
    'state': null
    'zipCode': ''
    'income': [ {
      'type': 'external'
      'amount': '100'
      'frequency': 'weekly'
    } ]
  'children': [
    {
      'FirstName': 'Mat'
      'MiddleName': 'R'
      'LastName': 'Frost'
      'student': true
      'foster': false
      'homeless': false
      'migrant': false
      'runaway': false
      'headStart': false
      'income':
        'amount': '0'
        'frequency': 'weekly'
    }
  ]
  'program':
    'participates': false
    'caseNumber': null
  'adults': []
  'earner':
    'name': 'Jatin Frost'
    'ssn': '1234'
  'identity': 'races': []
  'signature': 'Jatin Frost'

# All students fall under foster/runaway/migrant benefits
data2 =
  'eligibility': 'type': 'childStatus'
  'parent':
    'parentFirstName': 'Jatin'
    'parentLastName': 'Frost'
    'email': 'jat-frost@geocities.com'
    'phone': '669-221-6251'
    'address': '6087 Pleasant Forest Line'
    'city': 'Tin City'
    'state': 'NH'
    'zipCode': '03672'
  'children': [
    {
      'FirstName': 'Mat'
      'MiddleName': 'R'
      'LastName': 'Frost'
      'student': true
      'foster': false
      'homeless': false
      'migrant': true
      'runaway': false
      'headStart': false
    }
  ]
  'adults': null
  'program':
    'participates': false
    'caseNumber': null
  'earner': null
  'identity': 'races': []
  'signature': 'Jatin Frost'

# Multiple amount of children
data3 =
  'eligibility': 'type': 'financial'
  'parent':
    'parentFirstName': 'Jatin'
    'parentLastName': 'Frost'
    'email': ''
    'phone': ''
    'address': ''
    'city': ''
    'state': null
    'zipCode': ''
    'income': [ {
      'type': 'external'
      'amount': '100'
      'frequency': 'weekly'
    } ]
  'children': [
    {
      'FirstName': 'Mat'
      'MiddleName': 'R'
      'LastName': 'Frost'
      'student': true
      'foster': false
      'homeless': false
      'migrant': false
      'runaway': false
      'headStart': false
      'income':
        'amount': '0'
        'frequency': 'weekly'
    }
    {
      'FirstName': 'Arland'
      'MiddleName': null
      'LastName': 'Frost'
      'student': true
      'foster': false
      'homeless': false
      'migrant': false
      'runaway': false
      'headStart': false
      'income':
        'amount': '0'
        'frequency': 'weekly'
    }
  ]
  'program':
    'participates': false
    'caseNumber': null
  'adults': []
  'earner':
    'name': 'Jatin Frost'
    'ssn': '1234'
  'identity': 'races': []
  'signature': 'Jatin Frost'

# Multiple amount of household members
data4 =
  'eligibility': 'type': 'financial'
  'parent':
    'parentFirstName': 'Jatin'
    'parentLastName': 'Frost'
    'email': ''
    'phone': ''
    'address': ''
    'city': ''
    'state': null
    'zipCode': ''
    'income': [ {
      'type': 'external'
      'amount': '100'
      'frequency': 'weekly'
    } ]
  'children': [
    {
      'FirstName': 'Mat'
      'MiddleName': 'R'
      'LastName': 'Frost'
      'student': true
      'foster': false
      'homeless': false
      'migrant': false
      'runaway': false
      'headStart': false
      'income':
        'amount': '0'
        'frequency': 'weekly'
    }
  ]
  'program':
    'participates': false
    'caseNumber': null
  'adults': [
    {
      'FirstName': 'Mary'
      'LastName': 'Frost'
      'income': [ {
        'type': 'job'
        'amount': '3000'
        'frequency': 'monthly'
      }
      {
        'type': 'external'
        'amount': '100'
        'frequency': 'weekly'
      } ]
    }
    {
      'FirstName': 'Selena'
      'LastName': 'Frost'
      'income': []
    }
  ]
  'earner':
    'name': 'Jatin Frost'
    'ssn': '1234'
  'identity': 'races': []
  'signature': 'Jatin Frost'

# In Federal Assistance Program
data5 =
  'eligibility': 'type': 'assistance'
  'parent':
    'parentFirstName': 'Jatin'
    'parentLastName': 'Frost'
    'email': 'jat-frost@geocities.com'
    'phone': ''
    'address': ''
    'city': ''
    'state': null
    'zipCode': ''
  'children': [
    {
      'FirstName': 'Mat'
      'MiddleName': 'R'
      'LastName': 'Frost'
      'student': true
      'foster': false
      'homeless': false
      'migrant': false
      'runaway': false
      'headStart': false
    }
    {
      'FirstName': 'Arland'
      'MiddleName': null
      'LastName': 'Frost'
      'student': true
      'foster': false
      'homeless': false
      'migrant': false
      'runaway': false
      'headStart': false
    }
  ]
  'program':
    'participates': true
    'caseNumber': '1234567890ABCEDF'
  'adults': null
  'earner': null
  'identity': 'races': []
  'signature': 'Jatin Frost'

# No Social Security Number
data6 =
  'eligibility': 'type': 'financial'
  'parent':
    'parentFirstName': 'Jatin'
    'parentLastName': 'Frost'
    'email': ''
    'phone': ''
    'address': ''
    'city': ''
    'state': null
    'zipCode': ''
    'income': [ {
      'type': 'external'
      'amount': '100'
      'frequency': 'weekly'
    } ]
  'children': [
    {
      'FirstName': 'Mat'
      'MiddleName': 'R'
      'LastName': 'Frost'
      'student': true
      'foster': false
      'homeless': false
      'migrant': false
      'runaway': false
      'headStart': false
      'income':
        'amount': '0'
        'frequency': 'weekly'
    }
  ]
  'program':
    'participates': false
    'caseNumber': null
  'adults': []
  'earner': null
  'identity': 'races': []
  'signature': 'Jatin Frost'

# Full identity info
data7 =
  'eligibility': 'type': 'financial'
  'parent':
    'parentFirstName': 'Jatin'
    'parentLastName': 'Frost'
    'email': ''
    'phone': ''
    'address': ''
    'city': ''
    'state': null
    'zipCode': ''
    'income': [ {
      'type': 'external'
      'amount': '100'
      'frequency': 'weekly'
    } ]
  'children': [
    {
      'FirstName': 'Mat'
      'MiddleName': 'R'
      'LastName': 'Frost'
      'student': true
      'foster': false
      'homeless': false
      'migrant': false
      'runaway': false
      'headStart': false
      'income':
        'amount': '0'
        'frequency': 'weekly'
    }
  ]
  'program':
    'participates': false
    'caseNumber': null
  'adults': []
  'earner':
    'name': 'Jatin Frost'
    'ssn': '1234'
  'identity':
    'hispanic': 'false'
    'races': [
      'American Indian or Alaskan Native'
      'Black or African American'
      'Native Hawaiian or Other Pacific Islander'
    ]
  'signature': 'Jatin Frost'

test = (caseNumber) ->
    cases = [data1, data2, data3, data4, data5, data6, data7]
    $.ajax(
        url: baseURL + 'form-submit.json'
        method: 'POST'
        contentType: 'application/json;charset=UTF-8'
        data: JSON.stringify (generatePDF cases[caseNumber])
        dataType: 'json'
    ).done (data) ->
        console.log 'Test Case Passed', data
    .error (xhr, error) ->
        console.log 'Error Occurred on Test Case', error
