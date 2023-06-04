const express = require("express");
const axios = require("axios");

const app = express();

app.get("/api/weather/icon-proxy", async (req, res) => {
  const { icon } = req.query;

  if (!icon) {
    res.status(400).json({ error: "Missing icon query parameter" });
    return;
  }

  const url = `https://www.openweathermap.org/img/wn/${icon}@4x.png`;

  try {
    const response = await axios.get(url, { responseType: "stream" });
    response.data.pipe(res);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Internal Server Error" });
  }
});

const port = process.env.PORT || 3000;
app.listen(port, () => {
  console.log(`Proxy server listening on port ${port}`);
});
