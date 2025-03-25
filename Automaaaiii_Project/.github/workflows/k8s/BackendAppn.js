//this file is mainly kept to show what port developers has exposed in backend developer file.

const express = require('express');
const app = express();
const port = 3000; // Port defined here

app.get('/', (req, res) => {
  res.send('Hello, World!');
});

app.listen(port, () => {
  console.log(`App is running on port ${port}`);
});


