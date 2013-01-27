class TenderersController < ApplicationController
  def index
    @q = Tenderer.search(params[:q])
    @tenderers = @q.result.paginate(:page => params[:page])
  end

  def show
    @tenderer = Tenderer.find(params[:id])
    @winning_tender_infos = @tenderer.tender_infos.includes(:procurement).where(:winning => true)
    @lose_tender_infos = @tenderer.tender_infos.includes(:procurement).where(:winning => false)
    
    respond_to do |format|
      format.html 
      format.json {
        render :json => @tenderer
      }
    end
  end
end
