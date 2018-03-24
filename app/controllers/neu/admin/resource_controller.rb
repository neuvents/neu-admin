class Neu::Admin::ResourceController < ActionController::Base
  helper Neu::Admin::Helper

  def self.resource(resource, location:, &scope)
    define_method(:resource) { resource }

    define_method(:resources_location, &location)
    helper_method :resources_location

    define_method(:resource_scope, &scope) if scope
  end

  def index
    @resources = resource_scope

    respond_to do |format|
      format.json { render json: @resources }
      format.html
    end
  end

  def new
    @resource = resource_builder

    respond_to do |format|
      format.json { render json: @resource }
      format.html
    end
  end

  def create
    @resource = resource_builder(resource_params)
    @resource.save

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

  def resource_scope
    resource.all
  end

  def resource_builder(attributes = {})
    resource.new(attributes)
  end

  helper_method def resource_path
    resource
  end
end
