const http = require('http');
const fs = require('fs');
const path = require('path');

const baseDir = path.join(__dirname, 'build', 'web');
const mimeTypes = {
  '.html': 'text/html',
  '.js': 'text/javascript',
  '.mjs': 'text/javascript',
  '.css': 'text/css',
  '.json': 'application/json',
  '.png': 'image/png',
  '.jpg': 'image/jpeg',
  '.jpeg': 'image/jpeg',
  '.gif': 'image/gif',
  '.svg': 'image/svg+xml',
  '.ico': 'image/x-icon',
  '.woff': 'application/font-woff',
  '.ttf': 'application/font-ttf',
  '.otf': 'application/font-otf',
  '.wasm': 'application/wasm',
  '.mp4': 'video/mp4'
};

const server = http.createServer((req, res) => {
  let reqPath = decodeURIComponent(req.url.split('?')[0]);
  let filePath = path.join(baseDir, reqPath === '/' ? 'index.html' : reqPath);

  // If path doesn't exist or is a directory, check if it's an asset or SPA route
  if (!fs.existsSync(filePath) || fs.statSync(filePath).isDirectory()) {
    // For SPA routes like /products, /wholesale, fallback to index.html
    if (!path.extname(reqPath) || reqPath.startsWith('/products') || reqPath.startsWith('/wholesale') || reqPath.startsWith('/about') || reqPath.startsWith('/contact')) {
      filePath = path.join(baseDir, 'index.html');
    }
  }

  fs.stat(filePath, (err, stats) => {
    if (err || !stats.isFile()) {
      res.writeHead(404, { 'Content-Type': 'text/plain' });
      res.end('Not found: ' + reqPath);
      return;
    }

    const ext = path.extname(filePath).toLowerCase();
    const contentType = mimeTypes[ext] || 'application/octet-stream';

    res.writeHead(200, {
      'Content-Type': contentType,
      'Cache-Control': 'no-store, no-cache, must-revalidate, max-age=0',
      'Pragma': 'no-cache',
      'Expires': '0',
      'Cross-Origin-Opener-Policy': 'same-origin',
      'Cross-Origin-Embedder-Policy': 'credentialless'
    });

    const stream = fs.createReadStream(filePath);
    stream.pipe(res);
  });
});

const PORT = 8080;
server.listen(PORT, '127.0.0.1', () => {
  console.log(`WELTY Web Server running at http://127.0.0.1:${PORT}/`);
});
