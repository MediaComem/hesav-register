class Trm30Csv2Service
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
              "Événement",
              "Date d'inscription"
            ]
      registrations.each do |registration|


        csv << [registration.id,
          registration.last_name,
          registration.first_name,
          registration.email,
          registration.street,
          registration.npa,
          registration.city,
          registration.employer,
          registration.event.name,
          I18n.l(registration.created_at, :format => (I18n.t 'time.formats.custom'))
        ]
      end
    end
    return csv_string
  end
end 