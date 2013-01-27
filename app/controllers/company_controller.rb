#encoding: utf-8
class CompanyController < ApplicationController
  def complex_search
    uri     = URI("http://localhost:9200/g0v/company/_search")
    http    = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri)
    @query_string =  params[:query_string] || "{}"
    request.body = @query_string
    
    respone = http.request(request)
    @json = respone.body
    respond_to do |format|
      format.html { render :search }
      format.json { send_data @json, :type => "text/json", :disposition => 'inline' }
    end
  end

  def search
    uri     = URI("http://localhost:9200/g0v/company/_search")
    http    = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri)
    params[:q] ||= "台灣積體電路"
    request.body = <<_EOL_
{
  "query": {
    "bool": {
      "must": [
        {
          "query_string": {
            "fields": [
              "_id",
              "公司名稱",
              "姓名"
            ],
            "query": #{params[:q].to_json},
            "default_operator": "and"
          }
        }
      ]
    }
  }
}
_EOL_
    respone = http.request(request)
    @query_string = request.body
    @json = respone.body
    respond_to do |format|
      format.html 
      format.json { send_data @json, :type => "text/json", :disposition => 'inline' }
    end
  end
end
