json.name "dataroot"
  json.children @procuring_entities.keys do |pe|
    json.name pe.name
    json.children @procuring_entities[pe] do |procurement|
      json.name procurement.subject
      json.size procurement.price
    end
end

