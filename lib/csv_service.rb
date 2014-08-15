class CsvService
  def self.generate(registrations)
    csv_string = CSV.generate(col_sep: ";") do |csv|
      csv << ['Id',
              'Titre',
              'Nom',
              'Prénom',
              'Affiliation',
              'Adresse d\'affiliation',
              'Job',
              'Email',
              'Téléphone',
              'Connaissances théoriques',
              'Connaissances pratique comme participant',
              'Connaissances pratique comme organisateur',
              'Aucune connaissance',
              'Attentes de la formation',
              'Activités dans le domaine éolien',
              'Remarques',
              'Prix',
              'Payé',
              'Date d\'inscription'
            ]
      registrations.each do |registration|

        if registration.paid == true
          payed = "oui"
        else
          payed = "non"
        end

        csv << [registration.id,
          registration.title,
          registration.last_name,
          registration.first_name,
          registration.affiliation,
          registration.affiliation_address,
          registration.job,
          registration.email,
          registration.phone,
          registration.theorical_knowledge,
          registration.practical_p_knowledge,
          registration.practical_o_knowledge,
          registration.no_knowledge,
          registration.expectations,
          registration.activities,
          registration.remarks,
          registration.price,
          payed,
          I18n.l(registration.created_at, :format => (I18n.t 'time.formats.custom'))
        ]
      end
    end
    return csv_string
  end
end