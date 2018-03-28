class ResourceController < Neu::Admin::ResourceController
  def resource_scope
    resource.order(id: :desc)
  end
end
