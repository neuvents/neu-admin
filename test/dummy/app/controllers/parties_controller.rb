class PartiesController < ResourceController
  resource Party, location: -> { event_parties_path(event) }

  private

  def event
    @event ||= @resource.present? ? @resource.event : Event.find(params[:event_id])
  end

  def resource_builder(attributes = {})
    event.parties.build(attributes)
  end

  def resource_path
    @resource.persisted? ? @resource : [event, @resource]
  end

  def resource_params
    params.require(:party).permit(:title)
  end
end
