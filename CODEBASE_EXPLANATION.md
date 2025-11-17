# Safdo Crypto Shield

**Owner:** Deepak Raghunath Raut  
**Disclaimer:** This project is completely owned by Deepak Raghunath Raut. All rights reserved. See LICENSE (MIT) for terms.

## Overview
Codebase Explanation for Safdo Crypto Shield
1. Frontend (lib/, web/ folder)

lib/main.dart
Entry point of the Flutter Web app.
Initializes the app, sets routes, and loads the main UI.
Handles wallet connection and Polkadot.js extension integration.

lib/pages/
Contains Flutter widgets for different screens such as wallet dashboard, transaction list, and upload interface.

lib/services/
Contains Dart classes responsible for interacting with Polkadot RPC, managing wallet connection, and handling multi-chain data fetching.

web/polkadot_bridge.js
JavaScript file loaded in the web app to handle communication with Polkadot wallet browser extensions.
Provides functions for wallet detection, account fetching, signing requests, and bridging JS calls to Dart.

2. Backend (backend/ folder)

backend/server.js
Node.js Express server that acts as a secure proxy for IPFS uploads via web3.storage API.
This prevents exposing the Web3.Storage token on the client side.
It accepts upload requests, forwards them with authorization, and returns the IPFS hash.

backend/.env.example
Environment variables template. You add your own WEB3_STORAGE_TOKEN here and optional RPC endpoint URL.

3. Configuration files

pubspec.yaml
Flutter dependencies and project metadata.

.gitignore
Specifies files/folders to ignore in Git (like build artifacts, .env files).

README.md
Documentation including overview, setup instructions, disclaimers, license info, and demo script reference.

LICENSE
MIT license text with ownership information.

demo_script.md
A guided script for presenting and demoing the app to judges or stakeholders.

4. How components work together

The Flutter frontend loads in a browser, connects to a Polkadot wallet extension (e.g., polkadot.js).

It uses polkadot_bridge.js for wallet integration and sending RPC queries to Polkadot or other chains.

When the user uploads files (e.g., smart contract metadata), the frontend sends these to the Node.js backend proxy instead of directly to Web3.Storage, keeping your token safe.

The backend forwards the upload request to IPFS and returns the response hash.

The frontend displays wallet info, chain data, and IPFS upload status securely and interactively.

Summary

This modular architecture:

Keeps your Web3.Storage API token secure on the backend

Uses Flutter Web for cross-platform UI

Leverages Polkadot.js extension for wallet connect and RPC

Demonstrates key Web3 hackathon criteria: wallet connect, decentralized storage, on-chain verification
