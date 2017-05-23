class Csv2Service
  def self.generate(registrations)
    csv_string = CSV.generate(col_sep: ";") do |csv|
      csv << ["Id",
              "Prénom",
              "Nom",
              "Email",
              "Rue",
              "Npa",
              "Localité",
              "Employeur",
              "Profession",
              "Traduction",
              "Repas",
              "Prix",
              "Payé",
              "Événement",
              "Date d'inscription"
            ]
      registrations.each do |registration|

        if registration.payed == true
          payed = "oui"
        else
          payed = "non"
        end
        if registration.food == true
          food = "oui"
        else
          food = "non"
        end
        if registration.translate == true
          translate = "oui"
        else
          translate = "non"
        end

        csv << [registration.id,
          registration.last_name,
          registration.first_name,
          registration.email,
          registration.street,
          registration.npa,
          registration.city,
          registration.employer,
          registration.job,
          translate,
          food,
          registration.type_price,
          payed,
          registration.event.name,
          I18n.l(registration.created_at, :format => (I18n.t 'time.formats.custom'))
        ]
      end
    end
    return csv_string
  end
end