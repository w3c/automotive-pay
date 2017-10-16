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
phone->payer: Display Offer for Payer Selection
payer->browser: Payer Selection opens Brower
browser->server: Browser fetches Service Station page
server->browser: Server delivers page for Payer Interaction

==  Payment Initiation ==

payer->browser: Pushes "Buy" button, calling Payment Request API
browser->payer: Display matching payment apps (possibly including browser)
payer->brower: Select payment app
browser->app: Provide app with relevant data

== Interaction with Payment App == 

app->bank: Fetch page from Bank Server
bank->app: Bank delivers page for Payer Interaction
app->payer: App prompts Payer for credentials
payer->app: User provides credentials (possibly biometric)
app->bank: App communicates with bank who authenticates Payer
bank->app: Bank returns results of authentication
app->payer: User interacts further with app to confirm payment

== Response to Service Station ==

app->browser: App returns response information to browser
browser->server: Browser returns response information to Station server

== Activation of Device ==

server->pump: Station activates pump
pump->payer: Pump signals availability to Payer
payer->pump: User activates pump
pump->payer: Pump provides receipt to Payer

@enduml
