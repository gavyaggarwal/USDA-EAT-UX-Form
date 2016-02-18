panel = 0
baseURL = 'http://192.168.0.104:8080/'

currentPanel = ->
    $('main').children().eq(panel)

showPreviousPanel = ->
    currPanel = do currentPanel
    panel--
    prevPanel = do currentPanel
    $(prevPanel).css("display", "inline-block").animate { opacity: 1 }, 1000
    $('main').scrollLeft(720).animate { scrollLeft: 0 }, 1000
    $(currPanel).animate { opacity: 0 }, 1000, "swing", ->
        $(this).css("display", "none")

showNextPanel = ->
    currPanel = do currentPanel
    panel++
    nextPanel = do currentPanel
    $(currPanel).animate { opacity: 0 }, 1000, "swing", ->
        $(this).css("display", "none")
    $('main').animate { scrollLeft: 720 }, 1000, "swing", ->
        $(this).scrollLeft(0)
    $(nextPanel).css("display", "inline-block").animate { opacity: 1 }, 1000


submitForm = ->
    $.ajax(
        url: baseURL + 'form-submit.json'
        method: 'POST'
        contentType: 'application/json;charset=UTF-8'
        data: '{"text": "Sample PDF", "style":"header"}'
        dataType: 'json'
    ).done (data) ->
        console.log data
    .error (xhr, error) ->
        console.log 'Error Occurred: ' + error

setUpButtons = ->
    $('#GetStartButton').click ->
        do showNextPanel

    $('.backButton').click ->
        do showPreviousPanel

    $('.nextButton').click ->
        do showNextPanel

    $('.skipButton').click ->
        do showNextPanel
        do showNextPanel

setUpDefinitions = ->
    $('.has-definition').on 'focusin mouseenter', ->
        $('#status-card span').html $(this).attr("data-definition")
        $('#status-card').css('display', 'block').animate { opacity: 1 }
    $('.has-definition').on 'focusout mouseleave', ->
        $('#status-card').animate { opacity: 0 }, 400, "swing", ->
            $(this).css('display', 'none')

setUpValidation = ->
    jQuery.validator.addMethod 'phoneUS', ((phone_number, element) ->
        phone_number = phone_number.replace(/\s+/g, '')
        @optional(element) or phone_number.length > 9 and phone_number.match(/^(1-?)?(\([2-9]\d{2}\)|[2-9]\d{2})-?[2-9]\d{2}-?\d{4}$/)), 'Please enter a valid phone number.'

    $.validator.setDefaults
        debug: true
        errorClass: 'invalid'
        validClass: 'valid'
        errorPlacement: (error, element) ->
            $(element).closest('form').find('label[for=\'' + element.attr('id') + '\']').attr 'data-error', error.text()
        submitHandler: (form) ->
            console.log 'form ok'
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

setUpChildPanel = ->
    $('.removeChild').click ->
        console.log 'Remove Child'
    $('#addChild').click ->
        console.log 'Add Child'

$ ->
    do setUpButtons
    do setUpDefinitions
    do setUpValidation
    do setUpChildPanel
    $('select').material_select()
