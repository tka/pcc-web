class TenderersController < ApplicationController
  def index
    @tenderers = Tenderer.order(:id).paginate(:page => params[:page])
  end
end
