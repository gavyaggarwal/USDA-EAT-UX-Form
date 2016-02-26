# Constants
baseURL = (location.origin ? location.protocol + '//' + location.host) + '/'

# State Variables
panel = 0
child = 1
adult = 1
panelStack = []
programParticipant = false
hasSSN = false

# Data Variables
childIncomeTemplate = null
adultIncomeTemplate = null
submitPanelIndex = null
adultIncomeTemplate = null

# Data Model that stores form data
data =
    eligibility: null
    parent: null
    children: null
    program: null
    adults: null
    earner: null
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

# Transitions to final panel
skipToSubmitPanel = ->
    forwardPanelTransition submitPanelIndex

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
        do showNextPanel

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
            data.program =
                participates: true
                caseNumber: $('#caseNumber').val()
        else
            data.program =
                participates: false
                caseNumber: null
        do showNextPanel
    else
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
                obj = {}
                for field in ['FirstName', 'MiddleName', 'LastName']
                    val = $('#child' + i + field).val()
                    if val == null || val == "" || val == undefined
                        obj[field] = null
                    else
                        obj[field] = val
                for field in ['student', 'foster', 'homeless', 'migrant', 'runaway', 'headStart']
                    obj[field] = document.getElementById('child' + i + field).checked
                if obj.student and !obj.foster and !obj.homeless and !obj.migrant and !obj.runaway and !obj.headStart
                    allExempt = false
                res.push obj
        data.children = res
        populateChildrenIncome res
        # If all students are eligible from being foster/homeless/etc or the
        # parent participates in an assistance program, skip to end
        if allExempt or data.program?.participates
            do skipToSubmitPanel
        else
            do showNextPanel
    else
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
            data.children[i].income =
                amount: $(form).find('[name="childIncome"]').val()
                frequency: $(form).find('[name="childIncomeFrequency"]').val()
        # For each adult, add income types, amounts, and frequencies to data
        for form, i in $('#adultIncomeSection').find('form')
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

            if i == 0
                data.parent.income = income
            else
                data.adults[i - 1].income = income

        do showNextPanel

# Processes the SSN information and continues if valid
processSSNInfo = ->
    form = $('#ssn_info').find('form')
    $(form).submit()
    if $(form).valid()
        # If somebody has an SSN, record their SSN as the primary earner
        if hasSSN
            i = +$(form).find('select').val()
            if i == 0
                name = data.parent.parentFirstName + ' ' + data.parent.parentLastName
            else
                name = data.adults[i - 1].FirstName + ' ' + data.adults[i - 1].LastName
            data.earner =
                name: name
                ssn: $(form).find('#SSN').val()
        else
            data.earner = null
        do showNextPanel
    else
        data.earner = null

# Processes the submit information and submits form if valid
processSubmit = ->
    form = $('#submit').find('form')
    $(form).submit()
    if $(form).valid()
        data.signature = $(form).find('#signature').val()
        do submitForm

# Prints current form data to console
showData = ->
    console.log data

# Generates array that represents contents of a formatted PDF
generatePDF = ->
    [{
        text: 'Sample PDF'
        style: 'header'
    },
    {
        text: data.parent.parentFirstName + ' ' + data.parent.parentLastName
        style: 'subheader'
    },
    {
        text: 'This PDF has been generated dynamically.'
        style: 'normal'
    }]

# Sends data to server
submitForm = ->
    $.ajax(
        url: baseURL + 'form-submit.json'
        method: 'POST'
        contentType: 'application/json;charset=UTF-8'
        data: JSON.stringify generatePDF()
        dataType: 'json'
    ).done (data) ->
        console.log data
    .error (xhr, error) ->
        console.log 'Error Occurred: ' + error

# Configure actions of buttons
setUpButtons = ->
    # Map each button to the click handler
    $('#GetStartButton').click showNextPanel
    $('.backButton').click showPreviousPanel
    $('.nextButton').click showNextPanel
    $('#eligibilityInfoButton').click processEligibilityInfo
    $('#parentInfoButton').click processParentInfo
    $('#childrenInfoButton').click processChildrenInfo
    $('#programInfoButton').click processProgramInfo
    $('#adultInfoButton').click processAdultInfo
    $('#incomeInfoButton').click processIncomeInfo
    $('#ssnInfoButton').click processSSNInfo
    $('#submitButton').click processSubmit

# Configure helper tooltips for all elements in parent
setUpDefinitions = (parent) ->
    parent = parent || 'body'
    $(parent).find('.has-definition').on 'focusin mouseenter', ->
        $('#status-card span').html $(this).attr("data-definition")
        $('#status-card').css('display', 'block').animate { opacity: 1 }
    $(parent).find('.has-definition').on 'focusout mouseleave', ->
        $('#status-card').animate { opacity: 0 }, 400, "swing", ->
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

        # Update state variable
        child++

        # Upon clicking the remove button, remove the form
        $(newElement).find('.removeChild').click ->
            if $('.childForm').size() == 1
                Materialize.toast 'You must have at least one child.', 4000
            else
                $(this).closest('form').remove()

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

        # Upon clicking the remove button, remove the form
        $(newElement).find('.removeAdult').click ->
            $(this).closest('form').remove()

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

# Configure submit panel
do setUpSubmitPanel = ->
    # Set state variable to index of submit panel
    submitPanelIndex = $('.panel').length - 1

# Begin configuration when page is ready
$ ->
    do setUpButtons
    do setUpDefinitions
    do setUpValidation
    do setUpChildPanel
    do setUpProgramPanel
    do setUpHouseholdPanel
    do setUpIncomePanel
    do setUpSSNPanel
    do setUpSubmitPanel
    $('select').material_select()       # Enable dropdown menus globally
    $('.modal-trigger').leanModal()     # Enable model popups globally
