# README

Incident tracker is a service works on the slash commands for slack application usning slack api's.

Things you may want to cover:

* Ruby version :\
    Ruby-3.0.0

* System dependencies\
   postgres \
   Redis

* install dependencies 
` bundle install `

* Database creation \
	`rails db:migrate`

* Set .env 

* Run server \
  `rails s`

* Installation :
   -  Click on the Add to slack button  on the top right and install the app.
* Usage :
   - the App has a new slash command whcih can create the new incident
   "/rootly declare [incident-title] [incident-description] [incident-severity(sev0/sev1/sev2)]"
  
 - To resolve the status run the below command
 "/rootly resolve"
 