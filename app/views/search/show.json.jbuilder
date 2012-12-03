      json.name "dataroot"
      json.children ProcuringEntity.includes(:procurements).all do |pe|
        json.name pe.name
        json.children pe.procurements do |procurement|
          json.name procurement.subject
          json.size procurement.price
        end
      end

