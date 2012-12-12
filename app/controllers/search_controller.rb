# encoding: utf-8
class SearchController < ApplicationController
  respond_to :json, :html
  def show
    @search_string = (params[:search_form] && params[:search_form][:name]) || params[:search] || '雲端'
    respond_with do |f|
      f.html
    end
  end

  def result
    search_string = params[:search] 
    @procuring_entities = Procurement.where(["subject like ?", "%#{search_string}%"]).to_a.group_by(&:procuring_entity)
    cache_key= "search-#{search_string}"
    json= Rails.cache.read(cache_key)
    unless json
      json = render_to_string
      Rails.cache.write(cache_key, json)
    end
    render :text => json, content_type => "text/json"
  end

end
