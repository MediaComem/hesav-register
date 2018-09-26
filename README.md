# README

⚠️Le code source de la page qui permet de s'inscrire aux séance d'information est "stocké" sur [Gitlab](https://gitlab.com/sysin/iRegisterRails-hesav-seances-info).

To create new form [follow this link](new_form_process.md)

## Environment variables
`.env` is required locally to run the project. For updating production `.env` file, create and edit `.env.production`.

### Example
    
`.env` content
`REGISTER_DB_USER=[your_db_username]`

### Production migration
`RAILS_ENV=production rake db:migrate`

## Heroku tips

To configure `hstore` on the database, you have to connect to database with `heroku pg:psql` then run `CREATE EXTENSION hstore;`. Finally you can run `heroku run rake db:create` etc...

## Mailgun

App is using Mailgun to send mail through action mailer. Mailgun is an add-on on Heroku. You can access Mailgun config from Heroku app dashboard. Mail config is defined in `/config/environments/production.rb`.
