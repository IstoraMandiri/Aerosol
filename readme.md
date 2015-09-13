# Aerosol
### Smart Charity Platform

This is a very early work in progress.

## What is a Smart Charity?

It's a fancy name for a simple concept: a Smart Contract that takes an amount of Ether and splits it up to a bunch of pre-defined Ethereum addreses.

## What is a Smart Charity Platform?

It's an application that allows people to create and deploy and share customisable Smart Charity contracts.

## What does Aerosol do

Aerosol consists of a few pieces that together automate the process of designing, compiling and deploying contracts to the blockchain, as well as handling 3rd party payements and converting them into ethereum transactions, which in turn power the smart charity contracts to dish out ether according to the donor's requirements. It contains the following players:

* Deployers - users who create and deploy smart charity contract; anyone
* Donators - users pledging money to particular smart charity; anyone
* Registrants - individuals/organisations in the charity registry (blockchain and/or mongo)
* Recipients - any ethereum wallet; not necessairly registrants
* Withdrawers - people cashing out their donations using the service
* Smart Charity - the dapp that handles the divvying up of donation
* Server - hosts meteor server / static files / geth client
* Deployoment Service - client-only geth (string based), server-side, 3rd-party api, etc.
* Payment Service - Currency -> Eth service (3rd party api plugin, bitcoin wallet + logic, citibank api, etc.)
* Withdrawl Service - Eth -> Currency service (3rd party api plugin, bitcoin wallet + logic, citibank api, etc.)

There are 3 'levels' of decentralization, that can be easily switched around based on meteor packages in use.

* Client Only - No mongo server, [`meteor-build-client`](https://github.com/frozeman/meteor-build-client) files only, blockchain-based registry, or no registry. Fully decentralized via IPFS. Requires local geth node.
* Client Transactions - Mongo-based registry, client-based transactions. Still trustless in terms of cash, and more bells and whistles than blockchain-only registry
* Server-side transactions - No requirement for geth node, transactions handled via server depending on payment gateway plugin and exchange plugin

The process goes as follows:

#### Registration

* **Deployers** Optionally by Meteor Accounts for authenticity and functionality like bookmarking
* **Registrants** By default Meteor Accounts, but should eventually support blockchain name registry option for decentralized

#### Creation

* UI for searching registry (or multiple registries); could be mongo collection or a blockchain namereg or a RSS feed!
* Hand-pick the recipients from the registry and craft, options for encouraging investing in many over few and inventivising good investments (eg. tag system, rep system)
* Sexy UI for managing and visualizing the weightings of your portfolio
* Allow recursive linking of portfolios? (but check for dependancy loops!!!)

#### Compiling

* Take a combination of recipient addresses + weightings from web app and convert them into smart contract code.
* Compile the code for that transaction, deploy, and get shareable URL/TXid + QR Code for sharing

#### Deployment

* For serverless deployments you will just be given a generated string to paste into terminal that will deploy the contract you created
* If the server is enabled then it will handle doing that process, but will require payment or credit first (it's not free to deploy)

#### Donantion

* At this point anyone can use any 3rd party client to make an independent donation via a transaction if they have the contract address
* Also the payment services enabled will accept donations and will handle the passing on of the donation to the contract

#### Processing

* The decentralized bit
* The Smart Charity process on the chain will spring into action each time it's address receives a transaction; it will distribute the transaction according to it's portfolio

#### Withdrawl

* The donation lands in the recipient's eth wallet, so the process is technically complete
* We can also handle conversions to other currencies with a modular layer of 3rd party plugins


## Centralized Fallback

Basically, this means that by default all blockchain interaction will be done via the local geth client if it's avaialble. We'd still serve the Meteor server over HTTP, but when possible clients are performing the actual transactions locally.

In some situations, especially during the early days of Ethereum, many peple will not have access to a geth client. For example there's no easy way to run a node on iOS, and it's not super simple to run on any machine without having the technical knowledge. If a client can't find a local geth node running, the server will kick in and handle all the transactions on behalf of each client - acting as a proxy wallet/node combo that will keep track of the blockchain and execute the deployment of contracts and donations to contracts on behalf of the client.

This will also involve the development of different types of payment plugins and a standardized API that allows package developers to create other implementations for the server to process transactions -- eg paypal, bitcoin, etc.

The other API layer is between the eth exchange and the server, which would need to convert Fiat Currency (USD/HKD) to Ether, which would be ideally sent directly to the charity address, but could also be sent back to the server's wallet and then immediately passed on to the charity. I'm planning to use [gatecoin](https://gatecoin.com/) for the first implementatioin.


## Why is it called 'Aerosol'?

One input (donation) to many outputs (micro donations); the aerosol is what comes out of an atomizer. It's also using solidity files (`aero.sol`)