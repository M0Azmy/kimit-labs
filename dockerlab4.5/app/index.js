const http = require('http');
const PORT = 3000;
http.createServer((req, res) => {
  res.writeHead(200, { 'Content-Type': 'text/plain' });
  res.end('Hello From Docker compose\n');
}).listen(port, () => console.log(`Server running  on port ${PORT}`));
