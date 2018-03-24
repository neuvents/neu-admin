class EventsController < Neu::Admin::ResourceController
  layout 'application'

  private

  def resource_params
    params.require(:event).permit(:title, :description)
  end

  def resource
    Event
  end

  def resources_location
    events_path
  end
end
