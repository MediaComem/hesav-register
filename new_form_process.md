# HESAV - Nouveau formulaire
## Migrations
Créer la migration pour le nouveau formulaire grâce à cette commande (depuis le dossier du projet) :

`rails generate migration [NomDuFormulaire]`

Dans le fichier nouvellement créé, rajouter le code suivant à l'intérieur de la méthode `change` :

```
create_table :js16_registrations do |t|
  # Les champs suivants sont à modifier pour être adapté aux besoins du nouveau formulaire
  t.string :last_name
  t.string :first_name
  t.string :street
  t.integer :npa
  t.string :city
  t.string :email
  t.string :employer
  
  # Les champs suivants ne doivent PAS être modifiés
  t.string :shopID
  t.string :environment
  t.string :language
  t.boolean :payed
  t.timestamps
  t.integer :event_id
  t.hstore :registration_type
```

Pour un travail en local, modifier le fichier `db/seed.rb` et ajouter un seed pour le nouveau formulaire :

```
# Ruby
# À la fin du document
Event.create!(
	short_name: [nom_raccourci], # exemple : "form16"
    name: [nom_complet], # exemple : "Formulaire 2016"
    description: [description], # exemple : "Description de l'événement en lien avec le formulaire"
    open: DateTime.new(2014,07,14), # Devrait être avant la date du jour pendant le développement
    close: DateTime.new(2016,11,01), # Devrait être bien après la date du jour pendant le développement
    visible: true
)
```
Ne pas oublier de migrer et seeder les nouvelles infos :

`rake db:migrate` _(Note : cette commande va aussi mettre à jour le fichier `db/schema.rb`)_

`rake db:seed`

## Routes
Modifier le fichier `config/routes.rb`et ajouter les lignes suivantes après la dernière route (en indiquant les informations propre au nouveau formulaire) :

```
get '/[url_du_nouveau_formulaire]' => '[nom_raccourci]_registrations#new'
get '/[url_du_nouveau_formulaire]/admin(.:format)', to: '[nom_raccourci]_registrations#admin', as: '[nom_raccourci]_admin'

resources :[nom_raccourci]_registrations, path: '[url_du_nouveau_formulaire]' do
  collection do
    get 'new'
    get 'accepted'
    get 'exception'
    get 'decline'
    get 'cancel'
    get 'cgv'
  end
end
```

## Contrôleur

Dans le dossier `app/controllers`, copier/coller un des contrôleurs présents en modifiant le nom de fichier comme suit : `[nom_raccourci]_registration_controller.rb`.

Modifier les lignes suivantes dans le fichier copié :

```
l:2   -> require '[nom_raccourci]_csv_service'
           # exemple : form16_csv_service
l:4   -> class [nom_raccourci_camel_case]RegistrationsController < ApplicationController
           # exemple : Form16RegistrationController
l:12  -> @event_name = '[nom_raccourci]'
l:13  -> @shop_id = [[nom_raccourci] ou [nom_raccourci]dev]
           # exemple : form16 ou form16dev
l:14  -> @environment = 'test'
           # test ou prod
l:23  -> self.class.layout('[nom_raccourci]')
l:30  -> Changer le nom du modèle XxxRegistration pour celui du nouveau formulaire. exemple : Form16Registration
l:52  -> Idem
l:67  -> Idem
l:73  -> Adapter en fonction des types de prix possibles et de leur montant
l:112 -> Changer le nom du modèle XxxRegistration pour celui du nouveau formulaire. exemple : Form16Registration
l:165 -> Modifier les paramètres de `permit()` pour qu'ils correspondent à ceux du nouveau formulaire
```
## Modèle

Dans le dossier `app/models`, copier/coller un des modèles présents en modifiant le nom de fichier comme suit : `[nom_raccourci]_registration.rb`.

Modifier les attributs de la ligne:3 pour qu'ils correspondent aux attributs obligatoires du nouveau formulaire.
Modifier les valeurs du `store_accessor` à partir de la ligne:7 pour qu'ils correspondent aux attributs propres au nouveau formulaire.

## Mailer

Dans le dossier `app/mailers`, copier/coller un des modèles présents en modifiant le nom de fichier comme suit : `[nom_raccourci]_mailer.rb`.

Modifier le nom de la classe `XxxMailer` pour correspondre au nom de fichier. Exemple avec un fichier nommé `form16_mailer.rb`, la classe sera `Form16Mailer`.

Eventuellement, changer la valeur de `@super_admin`.

### MailTrap

Pour tester l'envoi de mail, même en local, il est possible d'utiliser le service [MailTrap](https://mailtrap.io/).

Pour cela, il faut s'y créer un compte si ce n'est déjà fait, puis accéder à la boîte fictive du compte et coper le code de l'encadré "Intégration" (en s'assurant que la liste déroulante soit sur "Ruby on Rails"). Ce code est ensuite à copier dans le fichier `app/config/environments/development.rb`, aux lignes 40 à 48.

**Note : Il est nécessaire de redémarrer le serveur (`rails s`) pour que ces changements-ci soient pris en compte.**

## Vues

### Layout

Dans le dossier `app/views/layout`, copier/coller un des layouts présents en modifiant le nom de fichier comme suit : `[nom_raccourci].html.slim`.

Modifier, dans le nouveau fichier, la valeur de `title` (l:4), éventuellement celle `stylesheet_link_tag`(l:6), ainsi que la valeur de `image_path()` (l:14), qui doit pointer sur la bannière du nouveau formulaire (à placer dans le dossier `app/assets/images`).

### Templates

Dans le dossier `app/views`, copier/coller un des dossiers présents (suffixé par `_registration`) et le renommer comme suit : `[nom_raccourci]_registrations`

Dans le fichier `accepted.html.slim` du dossier copié, modifier la ligne:5 pour que le lien pointe vers la bonne news. Faire la même chose dans le fichier `error.html.slim` à la ligne:5.

Dans le fichier `admin.html.slim`, modifier l'appel à la fonction `xxx_admin_path` à la ligne:2 pour qu'il corresponde au nom raccourci du nouveau formulaire. Exemple : `form16_admin_path`.

Modifier les templates des fichier `new.html.slim` et `cgv.html.slim` en fonction des besoins du nouveau formulaire et du contenu des cgv, respectivement.

### Mails

Dans le dossier `app/views`, copier/coller un des dossiers présents (suffixé par `_mailer`) et le renommer comme suit : `[nom_raccourci]_mailer`.

Dans le fichier `error_email.html.slim`, remplacer la valeur du h1 par le titre de l'événement.

Dans le fichier `success_email.html.slim`, modifier le template pour qu'il corresponde au corps de mail souhaité.

## Export CSV

Dans le dossier `lib`, copier/coller un des fichiers présents et le renommer comme suit : `[nom_raccourci]_csv_service.rb`.

Dans le fichier nouvellement créé, modifier les noms des attributs du deuxième tableau pour qu'ils correspondent à ceux du formulaire. Modifier les noms du premier tableau en conséquence.

## Workshop ou atlier à places limitées

En cas de besoin de limitation dans le nombre d'inscription à un workshop dans une conf, la conf JS17 propose un nombre de place limitées pour les ateliers 2 et 3. 

## Message d'erreur

Dans le fichier `config/locales/fr.yml`, sous la clé `activerecord.attributes`, créer une nouvelle clé nommée `[nom_raccourci]_registration`. Sous cette clé, créer une nouvelle clé pour chaque attribut du formulaire et lui donner comme valeur le nom à afficher pour cet attribut lors des messages d'erreurs.

## Traductions

Dans le dossier `config/locales`, ajouter les entrées correspondantes

## Paiements avec Stripe

Le formulaire utilise [Stripe Checkout](https://stripe.com/docs/checkout/tutorial) pour traiter les paiements. Les clés à insérer dans les fichiers `.env` sont disponibles directement dans la documentation _checkout_ ou dans la dashboard Stripe dans la rubrique _API_


Les clés nécessaire pour le 