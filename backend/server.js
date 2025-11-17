/*
Project: Safdo Crypto Shield
Owner: Deepak Raghunath Raut
Disclaimer: This project is completely owned by Deepak Raghunath Raut.
By using, modifying, or redistributing this code you agree that ownership remains with Deepak Raghunath Raut.
License: MIT (see LICENSE file)
*/
// Simple Node.js backend to proxy uploads to web3.storage and to hold RPC endpoint
// Usage: set WEB3_STORAGE_TOKEN and RPC_ENDPOINT in environment variables
const express = require('express');
const fetch = require('node-fetch');
const app = express();
const port = process.env.PORT || 3000;
const WEB3_TOKEN = process.env.WEB3_STORAGE_TOKEN;
const RPC_ENDPOINT = process.env.RPC_ENDPOINT || 'https://rpc.polkadot.io';

app.use(express.json());
app.get('/rpc/ping', (req, res) => res.json({ ok: true, rpc: RPC_ENDPOINT }));

app.post('/upload', async (req, res) => {
  if (!WEB3_TOKEN) return res.status(500).json({ error: 'Missing WEB3_STORAGE_TOKEN' });
  try {
    const body = req.body && req.body.data ? Buffer.from(req.body.data, 'base64') : null;
    if (!body) return res.status(400).json({ error: 'Missing base64 data' });
    const r = await fetch('https://api.web3.storage/upload', {
      method: 'POST',
      headers: {
        'Authorization': 'Bearer ' + WEB3_TOKEN,
        'Content-Type': 'application/octet-stream'
      },
      body: body
    });
    const j = await r.json();
    res.json(j);
  } catch (e) {
    res.status(500).json({ error: e.toString() });
  }
});

app.listen(port, () => console.log(`Safdo backend listening on ${port}`));
