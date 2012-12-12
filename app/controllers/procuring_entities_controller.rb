class ProcuringEntitiesController < ApplicationController
  def index
    @procuring_entities = ProcuringEntity.order(:entity_code).paginate(:page => params[:page])
  end

  def show
    @procuring_entity = ProcuringEntity.find(params[:id])
    @procurements = @procuring_entity.procurements.order("finish_at")

  end
end
