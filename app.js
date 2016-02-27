// Generated by CoffeeScript 1.7.1
var baseURL, bodyParser, cookieParser, error, express, fonts, fs, moment, pdf, pdfPass, pdfUser, printer, schoolHandler, serveIndex, styles, webIP, webPort, webServer;

bodyParser = require('body-parser');

cookieParser = require('cookie-parser');

express = require('express');

fs = require('fs');

moment = require('moment');

pdf = require('pdfmake');

serveIndex = require('serve-index');

webPort = process.env.OPENSHIFT_NODEJS_PORT || 8080;

webIP = process.env.OPENSHIFT_NODEJS_IP || "192.168.0.101";

baseURL = 'http://' + webIP + ':' + webPort + '/';

pdfUser = 'USDA';

pdfPass = 'Demo';

fonts = {
  Roboto: {
    normal: 'fonts/Roboto-Light.ttf',
    bold: 'fonts/Roboto-Medium.ttf',
    bolditalics: 'fonts/Roboto-Regular.ttf',
    italics: 'fonts/Roboto-Thin.ttf'
  }
};

styles = {
  header: {
    marginTop: 12,
    fontSize: 24,
    italics: true
  },
  subheader: {
    marginTop: 9,
    fontSize: 18,
    italics: true
  },
  normal: {
    marginTop: 6,
    fontSize: 12,
    lineHeight: 1.2
  },
  tabbed: {
    marginTop: 6,
    marginLeft: 10,
    fontSize: 12,
    lineHeight: 1.2
  },
  tabbed2: {
    marginTop: 6,
    marginLeft: 20,
    fontSize: 12,
    lineHeight: 1.2
  }
};

printer = new pdf(fonts);

webServer = express();

schoolHandler = function(req, res, next) {
  var b, c, index, path, _ref;
  c = req.cookies;
  if (!c || c.user !== pdfUser || c.pass !== pdfPass) {
    b = (_ref = req.query) != null ? _ref : req.body;
    if (b && b.user === pdfUser && b.pass === pdfPass) {
      res.cookie('user', b.user);
      res.cookie('pass', b.pass);
      res.redirect(307, baseURL + 'schools');
      return;
    } else {
      res.redirect(307, baseURL + 'login.html');
      return;
    }
  }
  if (req.url === '/') {
    index = serveIndex('./pdfs', {
      'icons': true
    });
    return index(req, res, res.send);
  } else {
    path = 'pdfs' + req.url;
    return fs.access(path, fs.F_OK, function(err) {
      var options;
      if (!err) {
        options = {
          root: process.cwd()
        };
        return res.sendFile(path, options);
      } else {
        return res.status(404).end();
      }
    });
  }
};

webServer.use(express["static"]('./public_html/'));

webServer.use(bodyParser.json());

webServer.use('/schools', bodyParser.urlencoded({
  extended: false
}), cookieParser(), schoolHandler);

webServer.post('/form-submit.json', function(req, res) {
  var contents, count, countStr, error, file, filename, writeStream;
  contents = req.body;
  console.log('Received Form Submission', JSON.stringify(contents));
  try {
    file = printer.createPdfKitDocument({
      content: contents,
      styles: styles
    });
    filename = moment().format('YYYYMMDD-hhmmss');
    count = 0;
    while (true) {
      countStr = count ? count.toString() : '';
      try {
        fs.accessSync('pdfs/' + filename + countStr + '.pdf', fs.F_OK);
        count += 1;
        continue;
      } catch (_error) {
        error = _error;
        filename = 'pdfs/' + filename + countStr + '.pdf';
        break;
      }
    }
    writeStream = fs.createWriteStream(filename);
    file.pipe(writeStream);
    file.end();
    console.log("PDF Successfully Generated: " + filename);
  } catch (_error) {
    error = _error;
    console.log("Error Generating PDF: " + error);
  }
  res.setHeader('Content-Type', 'application/json');
  return res.json({
    success: true
  });
});

try {
  webServer.listen(webPort, webIP);
  console.log('Web Server Listening on port ' + webPort);
} catch (_error) {
  error = _error;
  console.log('Unable to Run Web Server: ' + error);
}
