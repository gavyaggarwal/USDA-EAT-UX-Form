# Required Modules (all under MIT license)
express = require('express')
parser = require('body-parser')
pdf = require('pdfmake')
fs = require('fs')
ftpd = require('ftpd');
moment = require('moment')

# Ports to use for web and ftp servers
webPort = 3000
ftpPort = 2100

# Default username and password for FTP access to PDFs of form submissions
ftpUser = 'USDA'
ftpPass = 'Demo'

# Fonts used in PDF generation
fonts = Roboto:
    normal: 'fonts/Roboto-Light.ttf'
    bold: 'fonts/Roboto-Medium.ttf'
    bolditalics: 'fonts/Roboto-Regular.ttf'
    italics: 'fonts/Roboto-Thin.ttf'

# Formatting Rules for PDF generation
styles =
  header:
    marginTop: 24
    fontSize: 24
    italics: true
  normal: lineHeight: 1.15
  subheader:
    marginTop: 16
    fontSize: 16
    italics: true

# PDF Generator Engine
printer = new pdf(fonts)

# Web Server
webServer = express()

# Set up web server to serve static content
webServer.use express.static('./public_html/')
webServer.use parser.json()

# Set up web server to dynamically handle form submissions
webServer.post '/form-submit.json', (req, res) ->
    contents = req.body
    console.log 'Received Form Submission', JSON.stringify(contents)

    try
        file = printer.createPdfKitDocument
            content: contents
            style: styles

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

# FTP Server
ftpServer = new (ftpd.FtpServer)('localhost',
    getInitialCwd: ->
        '/'
    getRoot: ->
        process.cwd() + '/pdfs/'
    pasvPortRangeStart: 1025
    pasvPortRangeEnd: 1050
    allowUnauthorizedTls: true
    useWriteFile: true
    useReadFile: false)

fsFunctions =
    unlink: fs.unlink
    readdir: fs.readdir
    mkdir: fs.mkdir
    open: fs.open
    close: fs.close
    rmdir: fs.rmdir
    stat: fs.stat
    createReadStream: fs.createReadStream
    writeFile: (file, data, options, callback) ->
        if callback
            callback()
        else
            options()

# FTP Server Error Handler
ftpServer.on 'error', (error) ->
  console.log 'FTP Server Error:', error

# FTP Server Client Connected Handler
ftpServer.on 'client:connected', (connection) ->
    connection.on 'command:user', (user, success, failure) ->
        if user && user == ftpUser
            success()
        else
            # FTP Client Authentication Failed (Wrong Username)
            failure()
    connection.on 'command:pass', (pass, success, failure) ->
        if pass && pass == ftpPass
            console.log 'FTP Client Connected'
            success ftpUser, fsFunctions
        else
            # FTP Client Authentication Failed (Wrong Password)
            failure()

# Start Web and FTP Server
webServer.listen webPort
ftpServer.listen ftpPort
console.log 'Web Server Listening on port ' + webPort
console.log 'FTP Server Listening on port ' + ftpPort
