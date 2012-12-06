class ProcurementsController < ApplicationController
  def index
    @procurements = Procurement.includes(:procuring_entity).order(:finish_at).paginate(:page => params[:page])
  end
end
