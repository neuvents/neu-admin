class EventsController < ResourceController
  resource Event, location: -> { events_path }

  private

  def resource_params
    params.require(:event).permit(:title, :description)
  end
end
