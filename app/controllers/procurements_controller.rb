class ProcurementsController < ApplicationController
  def index
    @procurements = Procurement.includes(:procuring_entity).paginate(:page => params[:page])
  end
end
