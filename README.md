# README

This README would normally document whatever steps are necessary to get the
application up and running.

Please feel free to use a different markup language if you do not plan to run
<tt>rake doc:app</tt>.

## Database Configuration

The `config/database.yml` file uses environment variable for some config values. Each contributor must have a `.env` file in the app root with values for the following environment variable:

* `REGISTER_DB_USER`

### Example
    
`.env` content
`REGISTER_DB_USER=[your_db_username]`

### Production migration
`RAILS_ENV=production rake db:migrate`