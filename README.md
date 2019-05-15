# README

⚠️Le code source de la page qui permet de s'inscrire aux séance d'information est "stocké" sur [Gitlab](https://gitlab.com/sysin/iRegisterRails-hesav-seances-info).

To create new form [follow this link](new_form_process.md)

## Environment variables
`.env` is required locally to run the project. For updating production `.env` file, create and edit `.env.production`.

### Example

`.env` content
`REGISTER_DB_USER=[your_db_username]`

## Deploy to production

The app is hosted on a paid Heroku dyno.

To deploy on this dyno, simply add Heroku as a git remote with:
```shell
$> git remote add heroku https://git.heroku.com/hesav-forms.git
```

Then push the desired project state on Heroku, from any branch or commit with:
```shell
$> git push heroku master
```

## Production migration
To execute the migration on Heroku, use the following command:
```shell
$> heroku run rails db:migrate
```
## Connect to database

The application being deployed to Heroku, a PostgreSQL add-in is activated there.

Thus, to connect to the production database, type the following command in the app code source directory on your machine:

```sh
$> heroku pg:psql
```

## Heroku tips

To configure `hstore` on the database, you have to connect to database with `heroku pg:psql` then run `CREATE EXTENSION hstore;`. Finally you can run `heroku run rake db:create` etc...

## Mailgun

App is using Mailgun to send mail through action mailer. Mailgun is an add-on on Heroku. You can access Mailgun config from Heroku app dashboard. Mail config is defined in `/config/environments/production.rb`.
