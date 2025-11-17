/*
Project: Safdo Crypto Shield
Owner: Deepak Raghunath Raut
Disclaimer: This project is completely owned by Deepak Raghunath Raut.
By using, modifying, or redistributing this code you agree that ownership remains with Deepak Raghunath Raut.
License: MIT (see LICENSE file)
*/
/*
polkadot_bridge.js
Simple bridge exposing wallet discovery and RPC helper to the Flutter Web app via window.safdo.
*/
window.safdo = window.safdo || {};

window.safdo.connectWallet = async function() {
  try {
    if (!window.injectedWeb3) {
      return { success: false, error: 'No polkadot extension detected (window.injectedWeb3 missing)' };
    }
    const providers = Object.keys(window.injectedWeb3).map((k) => ({ name: window.injectedWeb3[k].name, source: k }));
    return { success: true, providers: providers };
  } catch (e) {
    return { success: false, error: e.toString() };
  }
};

window.safdo.enable = async function(source) {
  try {
    if (!window.injectedWeb3 || !window.injectedWeb3[source]) {
      return { success: false, error: 'extension not found' };
    }
    // Request enable via the extension (if supported)
    if (typeof window.injectedWeb3[source].enable === 'function') {
      await window.injectedWeb3[source].enable('Safdo Crypto Shield');
    }
    // Attempt to use polkadot-js extension-dapp methods if available on window
    if (window.polkaHelpers && window.polkaHelpers.web3Accounts) {
      const accounts = await window.polkaHelpers.web3Accounts();
      return { success: true, accounts: accounts };
    }
    return { success: true, accounts: [] };
  } catch (e) {
    return { success: false, error: e.toString() };
  }
};

window.safdo.rpc = async function(nodeUrl, method, params) {
  try {
    const response = await fetch(nodeUrl, {
      method: 'POST',
      headers: { 'Content-Type':'application/json' },
      body: JSON.stringify({ jsonrpc: '2.0', id: 1, method: method, params: params || [] })
    });
    const json = await response.json();
    return { success: true, result: json.result };
  } catch (e) {
    return { success: false, error: e.toString() };
  }
};
