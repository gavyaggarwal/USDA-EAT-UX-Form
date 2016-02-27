# Sample data structures for PDF file generation

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

generatePDF = (data) ->
    arr = []

    arr.push
        text: 'National School Lunch Program Application'
        style: 'header'

    proposedEligibility = data.eligibility.type
    if data.children[0].income != undefined
        proposedEligibility = 'Financial Need'
    else if data.program.participates == true
        proposedEligibility = 'Assistance Program Participation'
    else
        proposedEligibility = 'Status of Child(ren)'
    arr.push
        text: 'Proposed Categorical Eligibility: ' + proposedEligibility + '\r\n'
        style: 'normal'

    arr.push
        text: 'Parent Contact Information'
        style: 'subheader'
    arr.push
        text: 'Name: ' + data.parent.parentFirstName + ' ' + data.parent.parentLastName
        style: 'tabbed'
    if data.parent.email != ''
        arr.push
            text: 'Email: ' + data.parent.email
            style: 'tabbed'
    if data.parent.phone != ''
        arr.push
            text: 'Phone Number: ' + data.parent.phone
            style: 'tabbed'
    address = ''
    if data.parent.address != ''
        address = data.parent.address
    if data.parent.city != ''
        address += ', ' + data.parent.city
    if data.parent.state != null
        address += ', ' + data.parent.state + ' ' + data.parent.zipCode
    if address != ''
        arr.push
            text: 'Address: ' + address + '\r\n'
            style: 'tabbed'

    arr.push
        text: 'Student Information'
        style: 'subheader'
    for c, i in data.children
        if c.student == true
            arr.push
                text: studentInfo(c, i) + '\r\n'
                style: 'tabbed'

    if proposedEligibility == 'Assistance Program Participation'
        arr.push
            text: 'Assistance Program Information'
            style: 'subheader'
        arr.push
            text: 'Case Number: ' + data.program.caseNumber + '\r\n'
            style: 'tabbed'

    if proposedEligibility == 'Financial Need'
        arr.push
            text: 'Income Information'
            style: 'subheader'
        numAdults = 0
        if data.adults != undefined
            numAdults = data.adults.length
        householdSize = 1 + data.children.length + numAdults
        arr.push
            text: 'Total Number of Household Members: ' + householdSize
            style: 'normal'
        arr.push
            text: memberName(data.parent, true)
            style: 'tabbed'
        arr.push
            text: incomeInfo(data.parent, false)
            style: 'tabbed2'
        for c in data.children
            arr.push
                text: memberName(c, false)
                style: 'tabbed'
            arr.push
                text: incomeInfo(c, true)
                style: 'tabbed2'
        if data.adults
            for a in data.adults
                arr.push
                    text: memberName(a, false)
                    style: 'tabbed'
                arr.push
                    text: incomeInfo(a, false)
                    style: 'tabbed2'
        if data.earner != null
            arr.push
                text: 'SSN Information (last 4 digits) \r\n'
                style: 'normal'
            arr.push
                text: data.earner.name + ' - ' + data.earner.ssn
                style: 'tabbed'
        else
            arr.push
                text: 'No SSN Information Provided.'
                style: 'normal'

    if data.identity.races != undefined or data.identity.hispanic != undefined
        arr.push
            text: 'Children\'s Racial and Ethnic Identities'
            style: 'subheader'
        if data.identity.hispanic
            arr.push
                text: 'Ethnicity: Hispanic or Latino'
                style: 'tabbed'
        else if !data.identity.hispanic
            arr.push
                text: 'Ethnicity: Hispanic or Latino'
                style: 'tabbed'
        races = ''
        if data.identity.races != undefined
            for r in data.identity.races
                races += ' ' + r + ','
            races = races.slice(0, -1)
            arr.push
                text: 'Racial Background:' + races
                style: 'tabbed'

    arr.push
        text: 'Electronic Signature'
        style: 'subheader'
    d = new Date
    arr.push
        text: 'Completed and Signed by: ' + data.signature + '\r\n Submission Date: ' + (d.getMonth() + 1).toString() + '/' + d.getDate().toString() + '/' + d.getFullYear().toString()
        style: 'normal'
    arr

studentInfo = (student, i) ->
    studentType = ''
    studentName = (i + 1) + '. ' + student.FirstName + ' '
    if student.MiddleName
        studentName += student.MiddleName + '. '
    studentName += student.LastName + ' '

    if student.foster or student.homeless or student.runaway or student.migrant or student.headStart
        studentType = '('
        if student.foster == true
            studentType += 'Foster/'
        if student.homeless == true
            studentType += 'Homeless/'
        if student.runaway == true
            studentType += 'Runaway/'
        if student.migrant == true
            studentType += 'Migrant/'
        if student.headStart == true
            studentType += 'Head Start/'
        studentType = studentType.slice(0, -1)
        studentType += ')'

    return studentName + ' ' + studentType

memberName = (person, parent) ->
    if parent
        personName = person.parentFirstName + ' ' + person.parentLastName + '\r\n'
    else
        personName = person.FirstName + ' ' + person.LastName + '\r\n'
    return personName

incomeInfo = (person, child) ->
    personIncome = ''
    if (!child and !person.income) or (child and +person.income.amount == 0)
        personIncome = 'No Income'
    else
        for i in person.income
            personIncome += incomeType(i.type) + ': $' + i.amount + ' (' + incomeFrequency(i.frequency) + ') \r\n'

    return personIncome

incomeType = (type) ->
    switch type
        when 'job'
            source = 'Salary/Wages'
        when 'external'
            source = 'Public Assistance/Child Support/Alimony'
        when 'other'
            source = 'Pension/Retirement/Other'
        else
            source = ''

    return source

incomeFrequency = (frequency) ->
    switch frequency
        when 'weekly'
            sourceFreq = 'Weekly'
        when 'biweekly'
            sourceFreq = 'Every Two Weeks'
        when 'semimonthly'
            sourceFreq = 'Twice a Month'
        when 'monthly'
            sourceFreq = 'Monthly'
        when 'annually'
            sourceFreq = 'Annually'
        else
            sourceFreq = ''

    return sourceFreq

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
