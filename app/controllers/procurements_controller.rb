class ProcurementsController < ApplicationController
  def index
    @procurements = Procurement.paginate(:page => params[:page])
  end
end
