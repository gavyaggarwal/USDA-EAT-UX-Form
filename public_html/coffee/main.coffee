# State Variables
panel = 0
child = 1
baseURL = 'http://localhost:8080/'

# Data Model that stores form data
data =
    parent: null
    children: null

# Returns current panel
currentPanel = ->
    $('main').children().eq(panel)

# Transitions to the previous panel
showPreviousPanel = ->
    currPanel = do currentPanel
    panel--
    prevPanel = do currentPanel
    $(prevPanel).css("display", "inline-block").animate { opacity: 1 }, 1000
    $('main').scrollLeft(720).animate { scrollLeft: 0 }, 1000
    $(currPanel).animate { opacity: 0 }, 1000, "swing", ->
        $(this).css("display", "none")

# Transitions to the next panel
showNextPanel = ->
    currPanel = do currentPanel
    panel++
    nextPanel = do currentPanel
    $(currPanel).animate { opacity: 0 }, 1000, "swing", ->
        $(this).css("display", "none")
    $('main').animate { scrollLeft: 720 }, 1000, "swing", ->
        $(this).scrollLeft(0)
    $(nextPanel).css("display", "inline-block").animate { opacity: 1 }, 1000

# Returns an object holding the form values for fields with the given id
objectForFields = (arr) ->
    obj = {}
    for field in arr
        val = $('#' + field).val()
        if val == null || val == "" || val == undefined
            obj[field] = null
        else
            obj[field] = val
    return obj

# Processes parent information and continues to next panel if valid
processParentInfo = ->
    $('#parent_info').find('form').submit()
    if $('#parent_info').find('form').valid()
        data.parent = objectForFields ['parentFirstName', 'parentLastName', 'email', 'phone', 'address', 'city', 'state', 'zipCode']
        do showNextPanel
    else
        data.parent = null

# Processes children information and continues to next panel if valid
processChildrenInfo = ->
    allValid = true
    $('#children_info').find('form').each ->
        $(this).submit()
        if !($(this).valid())
            allValid = false
    if allValid
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
                for field in ['student', 'foster', 'homeless', 'migrant', 'runaway']
                    obj[field] = document.getElementById('child' + i + field).checked
                res.push obj
        data.children = res
        do showNextPanel
    else
        data.children = null

# Prints current form data to console
showData = ->
    console.log data

# Generates array that represents contents of PDF with formatting
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
    $('#GetStartButton').click ->
        do showNextPanel

    $('.backButton').click ->
        do showPreviousPanel

    $('.nextButton').click ->
        do showNextPanel

    $('#parentInfoButton').click ->
        do processParentInfo

    $('#childrenInfoButton').click ->
        do processChildrenInfo

# Configure helper tooltips
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
    $.validator.addMethod 'phoneUS', ((phone_number, element) ->
        phone_number = phone_number.replace(/\s+/g, '')
        @optional(element) or phone_number.length > 9 and phone_number.match(/^(1-?)?(\([2-9]\d{2}\)|[2-9]\d{2})-?[2-9]\d{2}-?\d{4}$/)), 'Please enter a valid phone number.'

    $.validator.setDefaults
        debug: true
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
            zip: 'digits'
            childFirstName: 'required'
            childLastName: 'required'

    $('form').each ->
        $(this).validate {}

# Configure child panel so that children can be dynamically added and removed
setUpChildPanel = ->
    template = $('#child-num-Form')
    templateHTML = $(template)[0].outerHTML
    $(template).remove()

    addChild = ->
        newHTML = templateHTML.replace /-num-/g, child.toString()
        newElement = $.parseHTML(newHTML)
        setUpDefinitions newElement
        $(newElement).validate {}
        $('#addChildSection').before newElement

        $('#child' + child + 'FirstName').on 'change keyup input', ->
            val = $(this).val()
            if val
                $(this).closest('form').find('h5').html $(this).val()
            else
                $(this).closest('form').find('h5').html 'New Child'
        child++

        $(newElement).find('.removeChild').click ->
            if $('.childForm').size() == 1
                Materialize.toast 'You must have at least one child.', 4000
            else
                $(this).closest('form').remove()

    $('#addChild').click ->
        do addChild

    do addChild

# Begin configuration when page is ready
$ ->
    do setUpButtons
    do setUpDefinitions
    do setUpValidation
    do setUpChildPanel
    $('select').material_select()
