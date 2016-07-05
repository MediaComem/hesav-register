class Jpsy162CsvService
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

        csv << [registration.id,
          registration.last_name,
          registration.first_name,
          registration.email,
          registration.street,
          registration.npa,
          registration.city,
          registration.employer,
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