// Generated by CoffeeScript 1.7.1
var error, express, fonts, fs, fsFunctions, ftpPass, ftpPort, ftpServer, ftpUser, ftpd, moment, parser, pdf, printer, styles, webIp, webPort, webServer;

express = require('express');

parser = require('body-parser');

pdf = require('pdfmake');

fs = require('fs');

ftpd = require('ftpd');

moment = require('moment');

webPort = process.env.OPENSHIFT_NODEJS_PORT || 8080;

webIp = process.env.OPENSHIFT_NODEJS_IP || "127.0.0.1";

ftpPort = 2100;

ftpUser = 'USDA';

ftpPass = 'Demo';

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
    marginTop: 24,
    fontSize: 24,
    italics: true
  },
  normal: {
    lineHeight: 1.15
  },
  subheader: {
    marginTop: 16,
    fontSize: 16,
    italics: true
  }
};

printer = new pdf(fonts);

webServer = express();

webServer.use(express["static"]('./public_html/'));

webServer.use(parser.json());

webServer.post('/form-submit.json', function(req, res) {
  var contents, count, countStr, error, file, filename, writeStream;
  contents = req.body;
  console.log('Received Form Submission', JSON.stringify(contents));
  try {
    file = printer.createPdfKitDocument({
      content: contents,
      style: styles
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

ftpServer = new ftpd.FtpServer('localhost', {
  getInitialCwd: function() {
    return '/';
  },
  getRoot: function() {
    return process.cwd() + '/pdfs/';
  },
  pasvPortRangeStart: 1025,
  pasvPortRangeEnd: 1050,
  allowUnauthorizedTls: true,
  useWriteFile: true,
  useReadFile: false
});

fsFunctions = {
  unlink: fs.unlink,
  readdir: fs.readdir,
  mkdir: fs.mkdir,
  open: fs.open,
  close: fs.close,
  rmdir: fs.rmdir,
  stat: fs.stat,
  createReadStream: fs.createReadStream,
  writeFile: function(file, data, options, callback) {
    if (callback) {
      return callback();
    } else {
      return options();
    }
  }
};

ftpServer.on('error', function(error) {
  return console.log('FTP Server Error:', error);
});

ftpServer.on('client:connected', function(connection) {
  connection.on('command:user', function(user, success, failure) {
    if (user && user === ftpUser) {
      return success();
    } else {
      return failure();
    }
  });
  return connection.on('command:pass', function(pass, success, failure) {
    if (pass && pass === ftpPass) {
      console.log('FTP Client Connected');
      return success(ftpUser, fsFunctions);
    } else {
      return failure();
    }
  });
});

try {
  webServer.listen(webPort, webIp);
  console.log('Web Server Listening on port ' + webPort);
} catch (_error) {
  error = _error;
  console.log('Unable to Run Web Server: ' + error);
}

try {
  ftpServer.listen(ftpPort, webIp);
  console.log('FTP Server Listening on port ' + ftpPort);
} catch (_error) {
  error = _error;
  console.log('Unable to Run FTP Server: ' + error);
}
