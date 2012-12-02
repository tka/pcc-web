class SearchController < ApplicationController
  respond_to :json, :html
  def show
    respond_with do |f|
      f.html
      f.json
    end
  end

end
