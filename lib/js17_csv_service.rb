class Js17Csv2Service
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
              "Prix",
              "Atelier 1",
              "Atelier 2",
              "Atelier 3",
              "Atelier 4",
              "Atelier 5",
              "Atelier 6",
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
          registration.job,
          registration.type_price,
          registration.ateliers["atelier1"],
          registration.ateliers["atelier2"],
          registration.ateliers["atelier3"],
          registration.ateliers["atelier4"],
          registration.ateliers["atelier5"],
          registration.ateliers["atelier6"],
          payed,
          registration.event.name,
          I18n.l(registration.created_at, :format => (I18n.t 'time.formats.custom'))
        ]
      end
    end
    return csv_string
  end
end