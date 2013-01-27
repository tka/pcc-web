#encoding: utf-8
class ProcurementsController < ApplicationController
  def index
    @procurements = Procurement.includes(:procuring_entity).order(:finish_at).paginate(:page => params[:page])
  end

  def complex_search
    uri     = URI("http://localhost:9200/g0v/procurement/_search")
    http    = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri)
    @query_string =  params[:query_string] || '{
    "query": {
      "bool": {
      "must": [
        {
      "query_string": {
      "default_field": "廠商名稱",
    "query": "台灣"
    }
    }
    ]
    }
    },
    "from": 0,
    "size": 50,
    "sort": [ ],
    "facets": { }
    }'
    request.body = @query_string
    
    respone = http.request(request)
    @json = respone.body
    respond_to do |format|
      format.html 
      format.json { send_data @json, :type => "text/json", :disposition => 'inline' }
    end
  end

end
