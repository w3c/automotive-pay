@startuml
!includeurl https://raw.githubusercontent.com/w3c/webpayments-flows/gh-pages/PaymentFlows/skin.ipml

Participant "Station Web Server" as server
Participant "Fuel Device" as pump
participant "Payer Mobile" as phone
Actor "Payer" as payer
participant "Payer Browser" as browser
participant "Payment App" as app
participant "Payer's Bank" as bank

title BLE-Initiated Service Station Payment

== Broadcast of Available Service ==

pump->phone: Offer URL via BLE
phone->payer: Display offer for payer selection
payer->browser: Select offer, launching browser
browser->server: Fetch service station page
server->browser: Deliver page
browser->payer: Display page

==  Payment Initiation ==

payer->browser: Push "Buy" button, calling Payment Request API
browser->payer: Display matching payment apps (possibly including browser)
payer->browser: Select payment app
browser->app: Provide app with relevant data

== Payer Interaction with Payment App == 

app->bank: Fetch page 
bank->app: Deliver page
note right payer
   Authentication scenarios will vary and strong auth is optional
end note
group Authentication
  app->payer: Prompt for credentials
  payer->app: Provide credentials (possibly biometric)
  app->bank: Forward authentication data
  bank->app: Return authentication status
end
payer->app: Interact and confirm payment

== Response to Service Station ==

app->browser: Return response (via Payment Handler API)
browser->server: Return response (via Payment Request API)

== Activation of Device ==

server->pump: Activate pump
pump->payer: Signal availability
payer->pump: Use pump
pump->payer: Provide receipt

@enduml
