class TenderersController < ApplicationController
  def index
    @tenderers = Tenderer.order(:id).paginate(:page => params[:page])
    #@tenderers = Tenderer.order("winning_tender_info_count desc, tender_info_count asc" ).paginate(:page => params[:page])
  end
  def show
    @tenderer = Tenderer.find(params[:id])
    @winning_tender_infos = @tenderer.tender_infos.includes(:procurement).where(:winning => true)
    @lose_tender_infos = @tenderer.tender_infos.includes(:procurement).where(:winning => false)
  end
end
