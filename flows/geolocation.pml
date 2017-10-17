@startuml
!includeurl https://raw.githubusercontent.com/w3c/webpayments-flows/gh-pages/PaymentFlows/skin.ipml

Participant "Station Web Server" as server
Participant "Fuel Device" as pump
participant "Payer Mobile/Car" as phone
Actor "Payer" as payer
participant "Payer Browser" as browser
participant "Payment App" as app
participant "Payer's Bank" as bank

title Initiation based on user device location

== Broadcast of Available Service ==

phone->payer: Display location-based offer for payer selection (e.g., via push notification)
payer->browser: Select offer, launching browser
browser->server: Fetch service station page
server->browser: Deliver page
browser->payer: Display page
note right payer
     User could log into merchant server for loyalty programs,
     including via strong authentication (WebAuthn). Station
     could also send information to fuel device (e.g., one-time pin)
     for enhanced security.
end note

==  Payment Initiation ==

payer->browser: Push "Buy" button, calling Payment Request API
browser->payer: Display matching payment apps (possibly including browser)
payer->browser: Select payment app

alt Payer Interaction with Third Party Payment App 
  browser->app: Provide app with relevant data
  app->bank: Fetch app
  note right app
      To enhance security, geolocation or other data might enable Payer's bank
      (or other service) to perform risk management regarding advertised
      service.
  end note
  bank->app: Deliver app
  app->payer: Display app
  alt Authentication
    note right payer
     Authentication scenarios will vary and strong auth is optional
    end note
    payer->app: Provide credentials (e.g., biometric via WebAuthn)
    app->bank: Forward authentication data
    bank->app: Return authentication status
  end
  payer->app: Finalize transaction
  app->browser: Return response (via Payment Handler API)
end

== Activation of Device ==
browser->server: Return response (via Payment Request API)
server->pump: Activate
pump->payer: Indicate availability
payer->pump: Get fuel
pump->payer: Provide receipt

@enduml
