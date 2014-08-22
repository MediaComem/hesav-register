class Etu14Service
  def self.generate(registrations)
    csv_string = CSV.generate(col_sep: ";") do |csv|
      csv << ["Id",
              "Titre",
              "Prénom",
              "Nom",
              "Rue",
              "Npa",
              "Localité",
              "Pays",
              "Institution",
              "Fonction",           
              "Email",
              "Type d'inscription",
              "Besoin de traduction",
              "Prix",
              "Payé",
              "Date d'inscription"
            ]
      registrations.each do |registration|

        if registration.payed == true
          payed = "oui"
        else
          payed = "non"
        end

        if registration.assistance == true
          assistance = "oui"
        else
          assistance = "non"
        end

        csv << [registration.id,
          registration.title,
          registration.first_name,
          registration.last_name,
          registration.street,
          registration.npa,
          registration.city,
          registration.country,
          registration.employer,
          registration.job,
          registration.email,
          registration.registration_type,
          assistance,
          registration.price,
          payed,
          I18n.l(registration.created_at, :format => (I18n.t 'date.formats.custom'))
        ]
      end
    end
    return csv_string
  end
end