class ProcuringEntitiesController < ApplicationController
  def index
    @q = ProcuringEntity.search(params[:q])
    @procuring_entities = @q.result.order(:entity_code).paginate(:page => params[:page])
  end

  def show
    @procuring_entity = ProcuringEntity.find(params[:id])
    @procurements = @procuring_entity.procurements.order("finish_at")

  end
end
