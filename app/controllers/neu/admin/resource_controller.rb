class Neu::Admin::ResourceController < ActionController::Base
  helper Neu::Admin::Helper

  def index
    @resources = resource_scope

    respond_to do |format|
      format.json { render json: @resources }
      format.html
    end
  end

  def new
    @resource = resource.new

    respond_to do |format|
      format.json { render json: @resource }
      format.html
    end
  end

  def create
    @resource = resource.create(resource_params)

    respond_to do |format|
      format.json { render json: @resource }
      format.html do
        if @resource.valid?
          redirect_to resources_location
        else
          render :new
        end
      end
    end
  end

  def edit
    @resource = resource.find(params[:id])

    respond_to do |format|
      format.json { render json: @resource }
      format.html
    end
  end

  def update
    @resource = resource.find(params[:id])
    @resource.update(resource_params)

    respond_to do |format|
      format.json { render json: @resource }
      format.html do
        if @resource.valid?
          redirect_to resources_location
        else
          render :edit
        end
      end
    end
  end

  def destroy
    @resource = resource.find(params[:id])
    @resource.destroy

    respond_to do |format|
      format.json { render json: @resource }
      format.html { redirect_to resources_location }
    end
  end

  private

  def resource_params
    raise NotImplementedError
  end

  def resource
    raise NotImplementedError
  end

  def resources_location
    raise NotImplementedError
  end
  helper_method :resources_location

  def resource_scope
    resource.order(id: :desc)
  end
end
