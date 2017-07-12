class Psy17Csv2Service
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
              "Payé",
              "Atelier 1 matin",
              "Atelier 1 après-midi",
              "Atelier 2 matin",
              "Atelier 2 après-midi",
              "Atelier 3 matin",
              "Atelier 3 après-midi",
              "Atelier 4 matin",
              "Atelier 4 après-midi",
              "Atelier 5 matin",
              "Atelier 5 après-midi",
              "Atelier 6 matin",
              "Atelier 6 après-midi",
              "Atelier 7 matin",
              "Atelier 7 après-midi",
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
          payed,
          registration.ateliers["atelier1am"],
          registration.ateliers["atelier1pm"],
          registration.ateliers["atelier2am"],
          registration.ateliers["atelier2pm"],
          registration.ateliers["atelier3am"],
          registration.ateliers["atelier3pm"],
          registration.ateliers["atelier4am"],
          registration.ateliers["atelier4pm"],
          registration.ateliers["atelier5am"],
          registration.ateliers["atelier5pm"],
          registration.ateliers["atelier6am"],
          registration.ateliers["atelier6pm"],
          registration.ateliers["atelier7am"],
          registration.ateliers["atelier7pm"],
          registration.event.name,
          I18n.l(registration.created_at, :format => (I18n.t 'time.formats.custom'))
        ]
      end
    end
    return csv_string
  end
end