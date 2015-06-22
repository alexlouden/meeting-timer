// Taken from:
// https://github.com/vincicat/heroku-express/blob/master/app.js

var express = require('express'),
	app = express.createServer()

app.configure(function(){
	app.use(express.static(__dirname + '/dist'));
	app.use(express.bodyParser());
	app.use(express.methodOverride());

	app.use(express.logger());
	app.use(express.errorHandler({
		dumpExceptions: true, 
		showStack: true
	}));
	
	app.use(app.router);
});

app.get('/', function(req, res){
	res.redirect("/dist/index.html");
});

//Heroku
var port = process.env.PORT || 3000;
app.listen(port, function() {
	console.log("Listening on " + port);
});