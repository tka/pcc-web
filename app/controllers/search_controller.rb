# encoding: utf-8
class SearchController < ApplicationController
  respond_to :json, :html
  caches_action :result
  def show
    respond_with do |f|
      f.html
    end
  end

  def result
    search_string = params[:search] || '網站'
    @procuring_entities = Procurement.where(["subject like ?", "%#{search_string}%"]).to_a.group_by(&:procuring_entity)
    respond_with do |f|
      f.json
    end
  end

end
