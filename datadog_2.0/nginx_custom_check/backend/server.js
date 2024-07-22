const express = require('express');
const app = express();
const port = 8080;

app.get('/', (req, res) => {
  res.send('Hello from backend service!');
});

app.listen(port, () => {
  console.log(`Backend service listening at http://localhost:${port}`);
});
