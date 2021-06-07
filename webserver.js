const { exec } = require('child_process');
const fs = require("fs");
const http = require("http");

const settings = JSON.parse(fs.readFileSync('settings.json'))

const host = settings['webserver-host-binding'];
const port = settings['webserver-port'];

const requestListener = function (req, res) {
	var buffer = ""
	var returnCode = 500

	if (!req.url.endsWith(".gif") && !req.url.endsWith(".jpeg")) {
		buffer += '<!doctype html><html><head><meta charSet="utf-8"/><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/><meta name="viewport" content="width=device-width, initial-scale=1.0"/></head><body>'
	}

	if (req.url == "/" || req.url == "/index.html" ) {
		returnCode = 200
		buffer += "<h1>Ticker Board</h1>"
		buffer += "<ul>"
		buffer += "<li><a href=\"/override.html\">override</a></li>"
		buffer += "<li><a href=\"/current_ticker.html\">view current ticker</a></li>"
		buffer += "</ul>"
	} else if (req.url == "/current_ticker.html") {
		buffer += "<h1>Current Ticker</h1>"
		buffer += "<div style='width: 448px; overflow: scroll'><img src='/ticker.jpeg' /></div>"
	} else if (req.url == "/override.html") {
		returnCode = 200
		buffer += "<h1>Override</h1>"
		buffer += "<ul>"
		buffer += "<li><a href=\"/override.html/news\">news</a></li>"
		buffer += "<li><a href=\"/override.html/weather\">weather</a></li>"
		buffer += "<li><a href=\"/override.html/finance\">finance</a></li>"
		buffer += "</ul>"
	} else if (req.url == "/override.html/news") {
		var data = restart_ticker ("news")

		returnCode = data.returnCode
		buffer += data.buffer
	} else if (req.url == "/override.html/weather") {
		var data = restart_ticker ("weather")
		
		returnCode = data.returnCode
		buffer += data.buffer
	} else if (req.url == "/override.html/finance") {
		var data = restart_ticker ("finance")
		
		returnCode = data.returnCode
		buffer += data.buffer
	} else if (req.url == "/ticker.jpeg") {
		serveStaticFile (res, '/ticker.jpeg', 'image/jpeg')
	} else {
		returnCode = 404
		buffer += "<h1>Error: 404</h1>"
		buffer += "<p>" + req.url + " is not found</p>"
	}

	if (!req.url.endsWith(".gif") && !req.url.endsWith(".jpeg")) {
		buffer += "</body></html>"

		res.writeHead(returnCode);
		res.end(buffer);
	}
};

function restart_ticker (tickerType) {
	// whitelist input into exec function
	approvedTickerTypes = [ "news", "finance", "weather" ]
	if (approvedTickerTypes.indexOf(tickerType) < 0) {
		console.log ("error: unregistered 'tickerType'")
		return {"returnCode": 504, "buffer": "error: unregistered 'tickerType'" }
    }


	// restart the ticker
	try {
		console.log ("starting " + tickerType + " ticker . ")
		const child = exec("bash restart-ticker.sh " + tickerType, (error, stdout, stderr) => {
			if (error) {
				console.log("error: "+ error.message);
				return
			}

			if (stderr) {
				console.log("stderr: " + stderr);
				return
			}

			console.log("stdout:\n" + stdout);

		})

		console.log ("done")
		return {"returnCode": 200, "buffer": "ok" }
	} catch (error) {
		return {"returnCode": 503, "buffer": "error" }
	}
}

// source: https://stackoverflow.com/questions/44354877/how-to-serve-image-from-node-server-without-express
function serveStaticFile(res, path, contentType, responseCode) {
    if(!responseCode) responseCode = 200;

    // __dirname will resolve to the directory the executing script resides in.
    // So if your script resides in /home/sites/app.js, __dirname will resolve
    // to /home/sites.

    console.log(__dirname + path);

    fs.readFile(__dirname + path, function(err, data) {
        if(err) {
            res.writeHead(500, { 'Content-Type' : 'text/plain' });
            res.end('500 - Internal Error');
        } 
        else {
            res.writeHead( responseCode, { 'Content-Type' : contentType });
            res.end(data);
        }
    });
}

const server = http.createServer(requestListener);
server.listen(port, host, () => {
	console.log(`Server is running on http://${host}:${port}`);
});