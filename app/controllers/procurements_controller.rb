class ProcurementsController < ApplicationController
  def index
    @procurements = Procurement.includes(:procuring_entity).order(:finish_at).paginate(:page => params[:page])
  end

  def complex_search
    uri     = URI("http://localhost:9200/g0v/procurement/_search")
    http    = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri)
    @query_string =  params[:query_string] || "{}"
    request.body = @query_string
    
    respone = http.request(request)
    @json = respone.body
    respond_to do |format|
      format.html 
      format.json { send_data @json, :type => "text/json", :disposition => 'inline' }
    end
  end

end
