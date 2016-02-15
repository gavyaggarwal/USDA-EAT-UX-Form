panel = 0
baseURL = "http://192.168.0.101:3000/"

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

$ ->
    do setUpButtons
    do setUpDefinitions
    $('select').material_select()
