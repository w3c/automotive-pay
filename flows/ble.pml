@startuml
!includeurl https://raw.githubusercontent.com/w3c/webpayments-flows/gh-pages/PaymentFlows/skin.ipml

Participant "Station Web Server" as server
Participant "Fueling Device" as pump
participant "Payer Device" as phone
Actor "Payer" as payer
participant "Payer Browser" as browser
participant "Payment App" as app
participant "Payer's Bank" as bank

title BLE-Initiated Service Station Payment

== Device Interaction with User to Open Web Page==

pump->phone: Offer URL via BLE
phone->payer: Display offer for payer selection
payer->browser: Open browser on selected URL
browser->server: Fetch service station page
server->browser: Deliver page for Payer Interaction
browser->payer: Display service station page

==  Payment Initiation ==

payer->browser: Push "Buy" button, calling Payment Request API
browser->payer: Display matching payment apps (possibly including browser)
payer->brower: Select payment app
browser->app: Provide app with relevant data

== Interaction with Payment App == 

app->bank: Fetch page 
bank->app: Deliver page for Payer Interaction
app->payer: Prompt Payer for credentials
payer->app: Provide credentials (possibly biometric)
app->bank: Communicate with bank to get authentication
bank->app: Return authentication status
app->payer: Interact and confirm payment

== Response to Service Station ==

app->browser: Return response (via Payment Handler API)
browser->server: Return response (via Payment Request API)

== Activation of Device ==

server->pump: Activate pump
pump->payer: Signal availability
payer->pump: Use pump
pump->payer: Provide receipt

@enduml
