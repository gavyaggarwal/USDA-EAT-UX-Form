# Required Modules (all under MIT license)
bodyParser = require('body-parser')
cookieParser = require('cookie-parser')
express = require('express')
fs = require('fs')
moment = require('moment')
pdf = require('pdfmake')
serveIndex = require('serve-index')

# Base URL
baseURL = 'http://192.168.0.104:8080/'

# Ports to use for web server
webPort = process.env.OPENSHIFT_NODEJS_PORT || 8080
webIP = process.env.OPENSHIFT_NODEJS_IP || "127.0.0.1"

# Default username and password for access to PDFs of form submissions
pdfUser = 'USDA'
pdfPass = 'Demo'

# Fonts used in PDF generation
fonts = Roboto:
    normal: 'fonts/Roboto-Light.ttf'
    bold: 'fonts/Roboto-Medium.ttf'
    bolditalics: 'fonts/Roboto-Regular.ttf'
    italics: 'fonts/Roboto-Thin.ttf'

# Formatting Rules for PDF generation
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

# PDF Generator Engine
printer = new pdf(fonts)

# Web Server
webServer = express()



# Express middleware that handles private, school-facing portion of website
schoolHandler = (req, res, next) ->
    c = req.cookies
    if !c || c.user != pdfUser || c.pass != pdfPass
        b = req.body
        if b && b.user == pdfUser && b.pass == pdfPass
            res.cookie 'user', b.user
            res.cookie 'pass', b.pass
        else
            res.redirect 307, baseURL + 'login.html'
            return
    if req.url == '/'
        index = serveIndex('./pdfs', 'icons': true)
        index req, res, res.send
    else
        path = 'pdfs' + req.url
        fs.access path, fs.F_OK, (err) ->
            if !err
                options =
                    root: process.cwd()
                res.sendFile path, options
            else
                res.status(404).end()



# Set up web server that servers static content and a private area for schools
webServer.use express.static('./public_html/')
webServer.use bodyParser.json()
webServer.use '/schools', bodyParser.urlencoded(extended:false), cookieParser(), schoolHandler



# Set up web server to dynamically handle form submissions
webServer.post '/form-submit.json', (req, res) ->
    contents = req.body
    console.log 'Received Form Submission', JSON.stringify(contents)

    try
        file = printer.createPdfKitDocument
            content: contents
            styles: styles

        filename = moment().format 'YYYYMMDD-hhmmss'
        count = 0
        loop
            countStr = if count then count.toString() else ''
            try
                fs.accessSync('pdfs/' + filename + countStr + '.pdf', fs.F_OK)
                count += 1
                continue
            catch error
                filename = 'pdfs/' + filename + countStr + '.pdf'
                break
        writeStream = fs.createWriteStream filename
        file.pipe writeStream
        file.end()
        console.log "PDF Successfully Generated: " + filename
    catch error
        console.log "Error Generating PDF: " + error

    res.setHeader 'Content-Type', 'application/json'
    res.json {success:true}



# Start Web Server
try
    webServer.listen webPort, webIP, ->
        console.log 'Web Server Listening on port ' + webPort
catch error
    console.log 'Unable to Run Web Server: ' + error
