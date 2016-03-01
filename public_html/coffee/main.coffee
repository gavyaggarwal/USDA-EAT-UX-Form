# Constants
baseURL = (location.origin ? location.protocol + '//' + location.host) + '/'

# State Variables
panel = 0
child = 1
adult = 1
householdMembers = 1
panelStack = []
programParticipant = false
hasSSN = false
submitted = false
definitionOn = false

# Data Variables
childIncomeTemplate = null
adultIncomeTemplate = null
identityPanelIndex = null
submitPanelIndex = null
adultIncomeTemplate = null
pdfDocument = null

# Data Model that stores form data
data =
    eligibility: null
    parent: null
    children: null
    program: null
    adults: null
    earner: null
    identity: null
    signature: null

# Returns current panel
currentPanel = ->
    $('main').children().eq(panel)

# Update progress bar based on current panel
updateProgressBar = ->
    progress = panel / submitPanelIndex
    progressStr = progress * 100 + '%'
    $('#progressBar').animate
        width: progressStr

# Transitions to the previous panel
showPreviousPanel = ->
    # Change state variables and get panels
    currPanel = do currentPanel
    panel = panelStack.pop()
    prevPanel = do currentPanel
    # Animate by placing previous panel on scroller, scrolling left, and hiding
    # the current one
    $(prevPanel).css("display", "inline-block").animate { opacity: 1 }, 1000
    $('main').scrollLeft(720).animate { scrollLeft: 0 }, 1000
    $(currPanel).animate { opacity: 0 }, 1000, "swing", ->
        $(this).css("display", "none")
    # Update progress bar
    do updateProgressBar

# Helper function that animates panel sliding in from right
forwardPanelTransition = (newPanel) ->
    # Push state onto history so we can detect back button clicks
    history.pushState newPanel, "", "#"
    # Change state variables and get panels
    currPanel = do currentPanel
    panelStack.push panel
    panel = newPanel
    nextPanel = do currentPanel
    # Animate by placing next panel on scroller, scrolling right, and hiding the
    # current one
    $(currPanel).animate { opacity: 0 }, 1000, "swing", ->
        $(this).css("display", "none")
    $('main').animate { scrollLeft: 720 }, 1000, "swing", ->
        $(this).scrollLeft(0)
        $('body').animate
            scrollTop: 0
    $(nextPanel).css("display", "inline-block").animate { opacity: 1 }, 1000
    # Update progress bar
    do updateProgressBar

# Transitions to the next panel
showNextPanel = ->
    forwardPanelTransition panel + 1

# Transitions to identity panel
skipToIdentityPanel = ->
    forwardPanelTransition identityPanelIndex

# Returns an object holding the form values for fields with the given id
objectForFields = (arr) ->
    obj = {}
    for field in arr
        # For each field in input array, if value is exists, set field in object
        # to that value
        val = $('#' + field).val()
        obj[field] = val ? null
    return obj

# Processes eligibility information and continues to next panel if valid
processEligibilityInfo = ->
    form = $('#eligibility_info').find('form')
    $(form).submit()
    if $(form).valid()
        # Add the eligibility to our data model
        data.eligibility =
            type: $(form).find('input[name="eligibilityCategory"]:checked').val()
        # Move onto next panel
        do showNextPanel
    else
        # If nothing is selected, display a small popup
        Materialize.toast 'You must select an option.', 4000

# Processes parent information and continues to next panel if valid
processParentInfo = ->
    $('#parent_info').find('form').submit()
    if $('#parent_info').find('form').valid()
        # Create object of parent info fields and store in data model
        data.parent = objectForFields ['parentFirstName', 'parentLastName', 'email', 'phone', 'address', 'city', 'state', 'zipCode']
        do showNextPanel
    else
        data.parent = null

# Process program information and continues if valid
processProgramInfo = ->
    $('#program_info').find('form').submit()
    if $('#program_info').find('form').valid()
        # Get data from form and store in our data model
        if programParticipant
            # Get case number if participant
            data.program =
                participates: true
                caseNumber: $('#caseNumber').val()
        else
            # Otherwise, leave it blank
            data.program =
                participates: false
                caseNumber: null
        # Go to the next form
        do showNextPanel
    else
        # Remove any data we may have stored if the form is invalid
        data.program = null

# Processes children information and continues if valid
processChildrenInfo = ->
    allValid = true
    allExempt = true
    # Check if the info for each child is filled out properly
    $('#children_info').find('form').each ->
        $(this).submit()
        if !($(this).valid())
            allValid = false
    if allValid
        # If so, store their name and properties in our data model
        res = []
        for i in [1...child]
            if document.getElementById('child' + i + 'Form')
                # If a form exists (doesn't necessarily have to if the user
                # added and then deleted a file)
                obj = {}
                # Get First/Middle/Last Name
                for field in ['FirstName', 'MiddleName', 'LastName']
                    val = $('#child' + i + field).val()
                    obj[field] = val ? null
                # Check child status
                for field in ['student', 'foster', 'homeless', 'migrant', 'runaway', 'headStart']
                    obj[field] = document.getElementById('child' + i + field).checked
                if obj.student and !obj.foster and !obj.homeless and !obj.migrant and !obj.runaway and !obj.headStart
                    # If a child is a student and not in the foster/homeless/etc
                    # category, we might need financial info
                    allExempt = false
                res.push obj
        # Set children array in data model to parsed data
        data.children = res
        populateChildrenIncome res
        # If all students are eligible from being foster/homeless/etc or the
        # parent participates in an assistance program, skip to end
        if allExempt or data.program?.participates
            do skipToIdentityPanel
        else
            do showNextPanel
    else
        # If there's a validation error, clear the children already entered
        data.children = null

# Processes adult information and continues if valid
processAdultInfo = ->
    # Check if all adult information is valid
    allValid = true
    $('#household_info').find('form').each ->
        $(this).submit()
        if !($(this).valid())
            allValid = false
    # If so, store their names in our data model
    if allValid
        res = []
        for i in [1...adult]
            # Record the names of each adult and store it as an array
            if document.getElementById('adult' + i + 'Form')
                obj = {}
                for field in ['FirstName', 'LastName']
                    val = $('#adult' + i + field).val()
                    obj[field] = val ? null
                res.push obj
        data.adults = res
        populateAdultIncome res
        do showNextPanel
    else
        data.adults = null

# Processes income information and continues if valid
processIncomeInfo = ->
    # Check if income info is filled out for each family member
    allValid = true
    $('#income_info').find('form').each ->
        $(this).submit()
        if !($(this).valid())
            allValid = false
    if allValid
        # For each child, add income amount and frequency to data structure
        for form, i in $('#childIncomeSection').find('form')
            # Child income is stored as an oject with an amount and frequency
            data.children[i].income =
                amount: $(form).find('[name="childIncome"]').val()
                frequency: $(form).find('[name="childIncomeFrequency"]').val()
        # For each adult, add income types, amounts, and frequencies to data
        for form, i in $('#adultIncomeSection').find('form')
            # Parent income is stored as an array of sources/amounts/frequencies
            income = []
            for method in $(form).find('#adultIncomeType' + i).val()
                if method == 'job'
                    income.push
                        type: 'job',
                        amount: $(form).find('[name="adultIncomeWage"]').val()
                        frequency: $(form).find('[name="adultIncomeWageFrequency"]').val()
                else if method == 'external'
                    income.push
                        type: 'external',
                        amount: $(form).find('[name="adultIncomeExternal"]').val()
                        frequency: $(form).find('[name="adultIncomeExternalFrequency"]').val()
                else if method == 'other'
                    income.push
                        type: 'other',
                        amount: $(form).find('[name="adultIncomeOther"]').val()
                        frequency: $(form).find('[name="adultIncomeOtherFrequency"]').val()
            # The first index corresponds to the parent currently filling out
            # the form
            if i == 0
                data.parent.income = income
            else
                data.adults[i - 1].income = income

        # Move onto the next panel if validation passes
        do showNextPanel

# Processes the SSN information and continues if valid
processSSNInfo = ->
    form = $('#ssn_info').find('form')
    $(form).submit()
    if $(form).valid()
        # If somebody has an SSN, record their SSN as the primary earner
        if hasSSN
            # Get index of selected value
            i = +$(form).find('select').val()
            # A value of 0 corresponds to the current person filling out the
            # form. Get the appropriate formatted name
            if i == 0
                name = data.parent.parentFirstName + ' ' + data.parent.parentLastName
            else
                name = data.adults[i - 1].FirstName + ' ' + data.adults[i - 1].LastName
            # Store into our data model
            data.earner =
                name: name
                ssn: $(form).find('#SSN').val()
        else
            # If no SSN, store nothing
            data.earner = null
        # Move onto next panel
        do showNextPanel
    else
        # Clear data if form is invalid
        data.earner = null

# Saves racial and ethnic data if filled out
processIdentityInfo = ->
    # This info is optional so validation is not required
    # Store whatever data is filled out
    form = $('#identity_info').find('form')
    data.identity =
        hispanic: $(form).find('input[name="hispanic"]:checked').val()
        races:  []
    $(form).find('input[name="race"]:checked').each ->
        data.identity.races.push $(this).val()
    # Generate a PDF of all the data collected so far to display on the next
    # panel
    do generatePDF
    # Show the next panel
    do showNextPanel

# Processes the submit information and submits form if valid
processSubmit = ->
    form = $('#submit').find('form')
    $(form).submit()
    if $(form).valid()
        # Hide the pre-submission content and display a message indicating the
        # form is being submitted
        $('#preSubmission').hide()
        $('#duringSubmission').show()
        data.signature = $(form).find('#signature').val()
        # Let our handler submit the form to the backend
        do submitForm

# Creates and opens a download link for the generated PDF
downloadPDF = ->
    pdfDocument.download 'Reduced School Lunch Application'

# Helper functions used in confirming the number of household members
changeHouseHoldMembers = (change) ->
    if change == 'add'
        householdMembers++
    else if change == 'remove'
        householdMembers--
    $('#householdSize').html householdMembers

# Generates array that represents contents of a formatted PDF
formatPDF = ->
    # Creates a string with student name and category labels
    studentInfo = (student, i) ->
        studentType = ''
        # Adds numbered list item and student name
        studentName = (i + 1) + '. ' + student.FirstName + ' '
        if student.MiddleName
            studentName += student.MiddleName + '. '
        studentName += student.LastName + ' '
        # Adds category labels
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
        # Returns string with student info: e.g. '1. Student Name (Status 1/Status 2)'
        return studentName + ' ' + studentType

    # Creates a string with name of adult
    memberName = (person, parent) ->
        # Accounts for different data model structure for signing parent vs. other adults
        if parent
            personName = person.parentFirstName + ' ' + person.parentLastName + '\r\n'
        else
            personName = person.FirstName + ' ' + person.LastName + '\r\n'
        return personName

    # Formats person income into list of type (if adult), amount, and frequency
    incomeInfo = (person, c) ->
        personIncome = ''
        # If person earns no income, reports that
        if (!c and person.income == []) or (c and +person.income.amount == 0)
            personIncome = 'No Income'
        # Otherwise, formats income
        else
            # Adult income includes type whereas child income does not
            if !c
                for i in person.income
                    personIncome += incomeType(i.type) + ': $' + i.amount + ' (' + incomeFrequency(i.frequency) + ') \r\n'
            else
                personIncome = '$' + person.income.amount + ' (' + incomeFrequency(person.income.frequency) + ') \r\n'

        return personIncome

    # Creates a string to indicate income type
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

    # Creates a string to indicate income frequency
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

    # Array that stores PDF elements
    arr = []

    # Application header
    arr.push
        text: 'National School Lunch Program Application'
        style: 'header'

    # Proposed eligibility category (confirmed by examining data model)
    if data.eligibility.type != null
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

    # Parent contact information (name, phone/email/address if provided)
    arr.push
        text: 'Parent Contact Information'
        style: 'subheader'
    arr.push
        text: 'Name: ' + memberName(data.parent, true)
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

    # List of students in household (name, category labels)
    arr.push
        text: 'Student Information'
        style: 'subheader'
    for c, i in data.children
        if c.student == true
            arr.push
                text: studentInfo(c, i) + '\r\n'
                style: 'tabbed'

    # Assistance program information (if available)
    if proposedEligibility == 'Assistance Program Participation'
        arr.push
            text: 'Assistance Program Information'
            style: 'subheader'
        arr.push
            text: 'Case Number: ' + data.program.caseNumber + '\r\n'
            style: 'tabbed'

    # Income information (if available)
    if proposedEligibility == 'Financial Need'
        arr.push
            text: 'Income Information'
            style: 'subheader'
        numAdults = 0
        if data.adults != undefined
            numAdults = data.adults.length
        # Household size
        householdSize = 1 + data.children.length + numAdults
        arr.push
            text: 'Total Number of Household Members: ' + householdSize
            style: 'normal'
        # Parent income information
        arr.push
            text: memberName(data.parent, true)
            style: 'tabbed'
        arr.push
            text: incomeInfo(data.parent, false)
            style: 'tabbed2'
        # Children income information
        for c in data.children
            arr.push
                text: memberName(c, false)
                style: 'tabbed'
            arr.push
                text: incomeInfo(c, true)
                style: 'tabbed2'
        # Adult income information
        if data.adults
            for a in data.adults
                arr.push
                    text: memberName(a, false)
                    style: 'tabbed'
                arr.push
                    text: incomeInfo(a, false)
                    style: 'tabbed2'
        # SSN information (if available)
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

    # Demographical information (if available)
    if data.identity.races.length != 0 or data.identity.hispanic != undefined
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

    # Signature section (name and date)
    arr.push
        text: 'Electronic Signature'
        style: 'subheader'
    d = new Date
    arr.push
        text: 'Completed and Signed by: ' + memberName(data.parent, true) + 'Submission Date: ' + (d.getMonth() + 1).toString() + '/' + d.getDate().toString() + '/' + d.getFullYear().toString()
        style: 'normal'
    arr

# Creates a PDF document from the data model and stores it as pdfDocument
generatePDF = ->
    # Get formatted representation of PDF
    format = do formatPDF

    # Custom Font Definitions for PDF Generation
    # https://github.com/bpampuch/pdfmake/wiki/Custom-Fonts---client-side
    # Causes a slowdown, but could be reenabled in the future
    ###
    fonts = Roboto:
        normal: 'fonts/Roboto-Light.ttf'
        bold: 'fonts/Roboto-Medium.ttf'
        bolditalics: 'fonts/Roboto-Regular.ttf'
        italics: 'fonts/Roboto-Thin.ttf'
    ###

    # Style Definitions for PDF Generation
    styles =
        header:
            marginTop: 12
            fontSize: 24
            italics: true
        subheader:
            marginTop: 9
            fontSize: 18
            italics: true
        normal:
            marginTop: 6
            fontSize: 12
            lineHeight: 1.2
        tabbed:
            marginTop: 6
            marginLeft: 40
            fontSize: 12
            lineHeight: 1.2
        tabbed2:
            marginTop: 6
            marginLeft: 80
            fontSize: 12
            lineHeight: 1.2

    # Use the pdfMake library to generate a PDF
    pdfDocument = pdfMake.createPdf
        content: format
        styles: styles

    # Display PDF Preview in iFrame
    pdfDocument.getDataUrl (result) ->
        $('#pdfView').attr 'src', result

# Sends data to server
submitForm = ->
    # Get the PDF as a base64 encoded format and send it off to the server to be
    # saved
    pdfDocument.getDataUrl (result) ->
        $.ajax(
            url: baseURL + 'form-submit.json'
            method: 'POST'
            data: {filename: 'pdf', data: result},
        ).done (data) ->
            # Server responded in success
            submitted = true
            # Change the message to one indicating the submission is complete
            $('#duringSubmission').hide()
            $('#postSubmission').show()
        .error (xhr, error) ->
            console.log 'Error Occurred: ' + error

# Set up window events to improve application functionality in the browser
setUpWindow = ->
    # Set history state to current panel
    history.pushState 0, "", "#"

    # Detect back button presses so we can update content when the browser backButton
    # button is hit
    $(window).on 'popstate', (e) ->
        state = e.originalEvent.state
        if state != null and state < panel
            do showPreviousPanel

    # Display a confirmation prompt if the user tries to navigate away without
    # submitting the form
    $(window).on 'beforeunload', (e) ->
        if !submitted
            'You have not submitted your form yet. If you leave the page now, your data will be lost.'

# Configure actions of buttons
setUpButtons = ->
    # Map each button to the click handler
    $('#GetStartButton').click showNextPanel
    $('.backButton').click ->
        # Use browser based back
        history.back()
    $('.nextButton').click showNextPanel
    $('#eligibilityInfoButton').click processEligibilityInfo
    $('#parentInfoButton').click processParentInfo
    $('#childrenInfoButton').click processChildrenInfo
    $('#programInfoButton').click processProgramInfo
    $('#adultInfoButton').click processAdultInfo
    $('#incomeInfoButton').click processIncomeInfo
    $('#ssnInfoButton').click processSSNInfo
    $('#identityInfoButton').click processIdentityInfo
    $('#submitButton').click processSubmit
    $('#pdfDownload').click downloadPDF

# Configure helper tooltips for all elements in parent
setUpDefinitions = (parent) ->
    parent = parent || 'body'
    # Add event listener to elements within parent that have a "has-definition"
    # class so that when they are focused or hovered on, text in their
    # "data-definition" attribute is displayed in a tooltip.
    $(parent).find('.has-definition').on 'focusin mouseenter', ->
        definitionOn = true
        $('#status-card span').html $(this).attr("data-definition")
        $('#status-card')
            .css 'display', 'block'
            .stop true
            .animate
                opacity: 1
    # Event listener to hide the tooltip when hovering away
    $(parent).find('.has-definition').on 'focusout mouseleave', ->
        definitionOn = false
        $('#status-card')
            .stop true
            .animate { opacity: 0 }, 400, "swing", ->
                if !definitionOn
                    $(this).css('display', 'none')

# Configure form validation
setUpValidation = (parent) ->
    # Add method for validating phone number
    $.validator.addMethod 'phoneUS', ((phone_number, element) ->
        phone_number = phone_number.replace(/\s+/g, '')
        @optional(element) or phone_number.length > 9 and phone_number.match(/^(1-?)?(\([2-9]\d{2}\)|[2-9]\d{2})-?[2-9]\d{2}-?\d{4}$/)), 'Please enter a valid phone number.'

    # Set validation rules
    $.validator.setDefaults
        debug: false
        errorClass: 'invalid'
        validClass: 'valid'
        errorPlacement: (error, element) ->
            # Do nothing with the error
            #$(element).closest('form').find('label[for=\'' + element.attr('id') + '\']').attr 'data-error', error.text()
        submitHandler: (form) ->
            # Don't need to actually submit
        rules:
            # Rules for various textfields within our form that require Custom
            # validation procedures
            parentFirstName: 'required'
            parentLastName: 'required'
            email: 'email'
            phone: 'phoneUS'
            zipCode: 'digits'
            caseNumber: 'required'
            programParticipation: 'required'
            childIncome: 'digits'
            adultIncomeWage: 'digits'
            adultIncomeExternal: 'digits'
            adultIncomeOther: 'digits'
            ssn: 'digits'
            signature: 'required'

    # Enable validation for every form on the page
    $('form').each ->
        $(this).validate {}

# Configure program panel to ask for case number when necessary
setUpProgramPanel = ->
    caseNumberHTML = $('#caseNumberSection').html()
    $('#caseNumberSection').html ''

    # Each time the user changes the program participation check box, show or
    # hide a text field asking for the case number
    $("input[name='programParticipation']").change ->
        if $(this).val() == 'true'
            programParticipant = true
            $('#caseNumberSection').html caseNumberHTML
            setUpDefinitions '#caseNumberSection'
        else
            programParticipant = false
            $('#caseNumberSection').html ''

# Configure child panel so that children can be dynamically added and removed
setUpChildPanel = ->
    # Get template HTML from page and remove template element
    template = $('#child-num-Form')
    templateHTML = $(template)[0].outerHTML
    $(template).remove()

    # Helper function that adds another row for a child to the panel
    addChild = ->
        # Create new HTML from template HTML and enable definitions/validation
        newHTML = templateHTML.replace /-num-/g, child.toString()
        newElement = $.parseHTML(newHTML)
        setUpDefinitions newElement
        $(newElement).validate {}
        $('#addChildSection').before newElement

        # Update heading when user types the child's name
        $('#child' + child + 'FirstName').on 'change keyup input', ->
            val = $(this).val()
            if val
                $(this).closest('form').find('h5').html $(this).val()
            else
                $(this).closest('form').find('h5').html 'New Child'

        # Update state variables
        child++
        changeHouseHoldMembers 'add'

        # Upon clicking the remove button, remove the form
        $(newElement).find('.removeChild').click ->
            if $('.childForm').size() == 1
                Materialize.toast 'You must have at least one child.', 4000
            else
                $(this).closest('form').remove()
                changeHouseHoldMembers 'remove'

    # Upon clicking the add button, add a child
    $('#addChild').click ->
        do addChild

    # Add child so we start with one
    do addChild

# Configure household panel so that household members can be dynamically added and removed
setUpHouseholdPanel = ->
    # Get template HTML from page and remove template element
    template = $('#adult-num-Form')
    templateHTML = $(template)[0].outerHTML
    $(template).remove()

    # Helper function that adds another row for an adult to the panel
    addAdult = ->
        # Create new HTML from template HTML and enable definitions/validation
        newHTML = templateHTML.replace /-num-/g, adult.toString()
        newElement = $.parseHTML(newHTML)
        setUpDefinitions newElement
        $(newElement).validate {}
        $('#addAdultSection').before newElement

        # Update state variable
        adult++
        changeHouseHoldMembers 'add'

        # Upon clicking the remove button, remove the form
        $(newElement).find('.removeAdult').click ->
            $(this).closest('form').remove()
            changeHouseHoldMembers 'remove'

    # Upon clicking the add button, add an adult
    $('#addAdult').click ->
        do addAdult

# Configure income panel to dynamically adapt to input
setUpIncomePanel = ->
    # Get template HTML from panel for adult/child income and remove the
    # template element
    childIncomeElement = $('#childIncomeTemplate')
    childIncomeTemplate = $(childIncomeElement)[0].outerHTML
    $(childIncomeElement).remove()

    adultIncomeElement = $('#adultIncomeTemplate')
    adultIncomeTemplate = $(adultIncomeElement)[0].outerHTML
    $(adultIncomeElement).remove()

# Fill the income panel with a form asking for each child's income
populateChildrenIncome = (children) ->
    # When we have updated children, add a form for each child prompting for
    # each child's income and frequency
    childIncomeSection = $('#childIncomeSection')
    $(childIncomeSection).empty()
    for c, i in children
        newForm = $.parseHTML(childIncomeTemplate)
        $(childIncomeSection).append newForm
        setUpDefinitions newForm
        $(newForm).attr 'id', 'childIncomeForm' + i
        $(newForm).find('#childIncomeNameTemplate')
            .attr 'id', 'childIncomeName' + i
            .html c.FirstName
        $(newForm).find('#childIncomeFieldTemplate')
            .attr 'id', 'childIncomeField' + i
        $(newForm).find('#childIncomeFrequencyTemplate')
            .attr 'id', 'childIncomeFrequency' + i
            .material_select()
        $(newForm).validate {}

# Fill the income panel with a form asking for each adult's income and type
populateAdultIncome = (adults) ->
    # When we have updated adults, add a form for each adult prompting for
    # each adult's income and frequency
    adultIncomeSection = $('#adultIncomeSection')
    $(adultIncomeSection).empty()
    adultIncomeBoxes = new Array(adults.length + 1)
    allAdults = adults.slice 0
    allAdults.unshift {FirstName: data.parent.parentFirstName}
    for a, i in allAdults
        newForm = $.parseHTML(adultIncomeTemplate)
        $(adultIncomeSection).append newForm
        setUpDefinitions newForm
        $(newForm).attr 'id', 'adultIncomeForm' + i
        $(newForm).find('#adultIncomeNameTemplate')
            .attr 'id', 'adultIncomeName' + i
            .html a.FirstName
        # When the income type is changed, update the input fields so that a
        # text field and dropdown menu is available for each of the selected
        # income types
        $(newForm).find('#adultIncomeTypeTemplate')
            .attr 'id', 'adultIncomeType' + i
            .change ->
                form = $(this).closest('form')
                j = $(form).index()
                $('#adultIncomeForm' + i + ' .select-wrapper')
                for box in adultIncomeBoxes[j]
                    $(box).find('select').material_select 'destroy'
                    $(box).remove()
                for method in $(this).val()
                    if method == 'job'
                        $(form).append(adultIncomeBoxes[j][0])
                        $(adultIncomeBoxes[j][0]).find('select').material_select()
                    else if method == 'external'
                        $(form).append(adultIncomeBoxes[j][1])
                        $(adultIncomeBoxes[j][1]).find('select').material_select()
                    else if method == 'other'
                        $(form).append(adultIncomeBoxes[j][2])
                        $(adultIncomeBoxes[j][2]).find('select').material_select()
                setUpDefinitions form
            .material_select()
        jobIncome = $(newForm).find('#jobIncomeTemplate')
        $(jobIncome).attr 'id', 'jobIncome' + i
        externalIncome = $(newForm).find('#externalIncomeTemplate')
        $(externalIncome).attr 'id', 'externalIncome' + i
        otherIncome = $(newForm).find('#otherIncomeTemplate')
        $(otherIncome).attr 'id', 'otherIncome' + i

        adultIncomeBoxes[i] = [
            jobIncome
            externalIncome
            otherIncome
        ]
        for box in adultIncomeBoxes[i]
            $(box).find('select').material_select 'destroy'
            $(box).remove()

        $(newForm).validate {}

# Configure SSN panel to ask for SSN of primary wage earner
setUpSSNPanel = ->
    ssnDetails = $('#ssnDetails')
    $('#ssnDetails').find('select').material_select 'destroy'
    $(ssnDetails).remove()

    # Each time the user changes the has SSN check box, show or hide a dropdown
    # menu and textfield asking for the primary earner and SSN
    $("input[name='socialSecurity']").change ->
        if $(this).val() == 'true'
            hasSSN = true
            select = $(ssnDetails).find('select')
            $('#ssn_info form').append ssnDetails
            $(select).empty().append '<option value=0>' + data.parent.parentFirstName + '</option>'
            for a, i in data.adults
                $(select).append '<option value=' + (i + 1) + '>' + a.FirstName + '</option>'
            $(select).material_select()
        else
            hasSSN = false
            $(ssnDetails).find('select').material_select 'destroy'
            $(ssnDetails).remove()

# Configure identity panel
do setUpIdentityPanel = ->
    # Set state variable to index of identity panel
    identityPanelIndex = $('.panel').length - 2

# Configure submit panel
do setUpSubmitPanel = ->
    # Set state variable to index of submit panel
    submitPanelIndex = $('.panel').length - 1

    $('#postSubmission').hide()
    $('#duringSubmission').hide()

# Begin configuration when page is ready
$ ->
    do setUpWindow
    do setUpButtons
    do setUpDefinitions
    do setUpValidation
    do setUpChildPanel
    do setUpProgramPanel
    do setUpHouseholdPanel
    do setUpIncomePanel
    do setUpSSNPanel
    do setUpIdentityPanel
    do setUpSubmitPanel
    $('select').material_select()       # Enable dropdown menus globally
    $('.modal-trigger').leanModal()     # Enable model popups globally
