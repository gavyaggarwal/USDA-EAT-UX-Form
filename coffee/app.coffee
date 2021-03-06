# Required Modules (all under MIT license)
bodyParser   = require('body-parser')
cookieParser = require('cookie-parser')
express      = require('express')
fs           = require('fs')
moment       = require('moment')
serveIndex   = require('serve-index')

# Port and IP to use for web server
webPort = process.env.OPENSHIFT_NODEJS_PORT || 8080
webIP = process.env.OPENSHIFT_NODEJS_IP || "192.168.0.100"

# Base URL
baseURL = 'http://' + webIP + ':' + webPort + '/'

# Default username and password for access to PDFs of form submissions
pdfUser = 'USDA'
pdfPass = 'Demo'

# Web Server
webServer = express()



# Express middleware that handles private, school-facing portion of website
schoolHandler = (req, res, next) ->
    c = req.cookies
    if !c || c.user != pdfUser || c.pass != pdfPass
        # Get username/password, checking post, get, cookie for data
        b = req.query ? req.body
        if b && b.user == pdfUser && b.pass == pdfPass
            res.cookie 'user', b.user
            res.cookie 'pass', b.pass
            res.redirect 307, baseURL + 'schools'
            return
        else
            res.redirect 307, baseURL + 'login.html'
            return
    # If the base URL or unparseable URL is passed, show the directory listing
    if req.url == '/'
        index = serveIndex('./pdfs', 'icons': true)
        index req, res, res.send
    # Otherwise, get the file from the disk and show that
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
webServer.use bodyParser.urlencoded(extended:true)
webServer.use '/schools', cookieParser(), schoolHandler



# Set up web server to dynamically handle form submissions
webServer.post '/form-submit.json', (req, res) ->
    contents = req.body
    console.log 'Received Form Submission'

    try
        data = contents.data.replace(/^data:application\/pdf;base64,/, "");

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
        fs.writeFileSync filename, data, 'base64'
        console.log "PDF Successfully Generated", filename
    catch error
        console.log "Error Generating PDF: " + error

    res.setHeader 'Content-Type', 'application/json'
    res.json {success:true}

# Start Web Server
try
    webServer.listen webPort, webIP
    console.log 'Web Server Listening on port ' + webPort
catch error
    console.log 'Unable to Run Web Server: ' + error
