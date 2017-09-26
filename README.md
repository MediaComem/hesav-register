# README

To create new form [follow this link](new_form_process.md)

## Environment variables
`.env` is required locally to run the project. For updating production `.env` file, create and edit `.env.production`.

## Database Configuration

The `config/database.yml` file uses environment variable for some config values. Each contributor must have a `.env` file in the app root with values for the following environment variable:

* `REGISTER_DB_USER`

### Example
    
`.env` content
`REGISTER_DB_USER=[your_db_username]`

### Production migration
`RAILS_ENV=production rake db:migrate`

## Database Connection

To connect to the database, use [pgAdmin](https://www.pgadmin.org/) or an equivalent (like [Sequel Pro](https://www.sequelpro.com/) on Mac or [JetBrains DataGrip](https://www.jetbrains.com/datagrip/) on Windows).
The credentials (like DB Host, DB Name, username and password) can be found on the `.env.production` file, which is located on the MEI's KeyPassX.
