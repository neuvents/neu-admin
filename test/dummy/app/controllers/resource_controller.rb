class ResourceController < Neu::Admin::ResourceController
  layout 'application'

  def resource_scope
    resource.order(id: :desc)
  end
end
