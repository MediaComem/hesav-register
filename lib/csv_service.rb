class CsvService
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
              "Type d'inscription",
              "Prix",
              "Payé",
              "Événement",
              "Date d'inscription"
            ]
      registrations.each do |registration|

        if registration.paid == true
          payed = "oui"
        else
          payed = "non"
        end

        csv << [registration.id,
          registration.last_name,
          registration.first_name,
          registration.email,
          registration.npa,
          registration.city,
          registration.employer,
          registration.job,
          registration.type_name,
          registration.type_price,
          payed,
          registration.event.name,
          I18n.l(registration.created_at, :format => (I18n.t 'date.formats.custom'))
        ]
      end
    end
    return csv_string
  end
end