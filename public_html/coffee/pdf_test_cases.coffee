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
      'income':
        'amount': '0'
        'frequency': 'weekly'
    }
  ]
  'adults': null
  'program':
    'participates': false
    'caseNumber': null
  'earner': null
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
  'signature': 'Jatin Frost'

generatePDF = (data) ->
    arr = []

    arr.push
        text: 'National School Lunch Program Application'
        style: 'header'

    proposedEligibility = data.eligbility.type
    if data.children[0].income.amount == ''
        proposedEligibility = 'Financial Need'
    else if data.program.participates == true
        proposedEligibility = 'Assistance Program Participation'
    else
        proposedEligibility = 'Status of Child(ren)'
    arr.push
        text: 'Proposed Categorical Eligibility: ' + proposedEligibility + '/n'
        style: 'normal'

    arr.push
        text: 'Parent Contact Information'
        style: 'subheader'
    arr.push
        text: 'Name: ' + data.parent.parentFirstName + ' ' + data.parent.parentLastName
        style: 'normal'
    if data.parent.email != ''
        arr.push
            text: 'Email: ' + data.parent.email
            style: 'normal'
    if data.parent.phone != ''
        arr.push
            text: 'Phone Number: ' + data.parent.phone
            style: 'normal'
    if data.parent.address != ''
        address = data.parent.address
    if data.parent.city != null
        address += ', ' + data.parent.city
    if data.partent.state != ''
        address += ', ' + data.parent.state + ' ' + data.parent.zipCode
    arr.push
        text: 'Address: ' + address + '/n'
        style: 'normal'

    arr.push
        text: 'Student Information'
        style: 'subheader'
    for c, i in data.children
        if c.student == true
            arr.push
                text: '/t' + studentInfo(c.student) + '/n'
                style: 'normal'
    arr.push
        text: '/n'
        style: 'normal'

    if proposedEligibility == 'Assistance Program Participation'
        arr.push
            text: 'Assistance Program Information'
            style: 'subheader'
        arr.push
            text: '/t Case Number: ' + data.program.caseNumber + '/n'
            style: 'normal'

    if proposedEligibility == 'Financial Need'
        arr.push
            text: 'Income Information'
            style: 'subheader'
        householdSize = 1 + data.children.length + data.adults.length
        arr.push
            text: 'Total Number of Household Members: ' + size
            style: 'normal'
        arr.push
            text: incomeInfo(data.parent)
            style: 'normal'
        for c in data.children
            arr.push
                text: incomeInfo(c)
                style: 'normal'
        for a in data.adults
            arr.push
                text: incomeInfo(a)
                style: 'normal'
        if data.earner != null
            arr.push
                text: 'SSN Information (last 4 digits) /n /t' + data.earner.name + ' - ' + data.earner.ssn
                style: 'normal'
        arr.push
            text: '/n'
            style: 'normal'

    arr.push
        text: 'Electronic Signature'
        style: 'subheader'
    d = new Date
    arr.push
        text: 'Completed and Signed by: ' + data.signature + '/n Submission Date: ' + d.getMonth + '/' + d.getDate + '/' + d.getFullYear

    arr

studentInfo = (student) ->
    studentType = ''
    studentName = '/t' + i + '. ' + student.FirstName + ' '
    if student.MiddleName != ''
        studentName += student.MiddleName + '. '
    studentName += student.LastName + ' '

    if student.foster == true or student.homeless == true or student.runaway == true or student.migrant == true or student.headStart == true
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
        studentType += ')'
        studentType.replace('/)', ')')

    return studentName + studentType

incomeInfo = (person) ->
    if person == data.parent
        personName = '/t' + person.parentFirstName + ' ' + person.parentLastName + '/n'
    else
        personName = '/t' + person.FirstName + ' ' + person.LastName + '/n'

    personIncome = ''
    if person.income != null and person.income != []
        personIncome = 'No Income'
    else
        for i in person.income
            personIncome += '/t /t' + incomeType(i.type) + ': $' + i.amount + '(' + i.frequency + ') /n'

    return personName + personIncome

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
    cases = [data1, data2, data3, data4, data5, data6]
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
