## Installation

Add this line to your application's Gemfile:

```ruby
gem 'neu-admin', github: 'neuvents/neu-admin'
```

And then execute:

```bash
$ bundle
```

Create `Admin::ApplicationController` in your application namespace.

## Admin Resource

The `Neu::Admin::ResourceController` provides basic CRUD actions out of the box. These include:

- listing of resources
- creating resources
- updating resources
- deleting resource

It is encouraged to create your own `ResourceController`, that inherits from `Neu::Admin::ResourceController`, in order to put your customizations to the base functionality.

```ruby
class Admin::ResourceController < Neu::Admin::ResourceController
  def resource_scope
    resource.order(id: :desc)
  end
end
```

### Controllers

Then you can use it just like that:

```ruby
class Admin::EventsController < ResourceController
  resource Event, location: -> { events_path }

  private

  def resource_params
    params.require(:event).permit(:title, :description)
  end
end
```

The DSL accepts the model and index location (used for redirects and Cancel buttons). Then you need to define the permitted params.

You can override the resource_scope method in your controllers to add scopes, paging, search and so on.

### Nested resources

Here's an example of the controller code for a nested resource (assume that Event has many Parties and shallow routes):

```ruby
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
```

## Views

For the Views you need to supply your own index.html.erb and \_form.html.erb

```bash
app/views/admin/events/index.html.erb
app/views/admin/events/_form.html.erb
```

Here are some basic examples:

#### Index

```erb
<%= page_title "Events" %>

<%= toolbar do %>
  <%= link_to 'Create', new_event_path, class: 'btn-success' %>
<% end %>

<table class="data-grid">
  <thead>
    <tr>
      <th class="primary">Title</th>
      <th class="actions">&nbsp;</th>
    </tr>
  </thead>

  <tbody>
    <% if @resources.present? %>
      <% @resources.each do |record| %>
        <tr>
          <td class="primary"><%= link_to record.title, edit_event_path(record), class: 'primary-action' %></td>
          <td class="actions">
            <%= action_link :edit, edit_event_path(record) %>
            <%= action_link :delete, event_path(record) %>
          </td>
        </tr>
      <% end %>
    <% else %>
      <tr>
        <td colspan="4">No records.</td>
      </tr>
    <% end %>
  </tbody>
</table>
```

#### Form

```erb
<%= form_with model: @resource, data: {remote: false} do |f| %>
  <div class="form-group">
    <%= f.label :title, class: 'control-label' %>
    <%= f.text_field :title, class: 'form-control' %>
  </div>

  <div class="form-group">
    <%= f.label :description, class: 'control-label' %>
    <%= f.text_area :description, class: 'form-control' %>
  </div>

  <%= f.submit 'Save', class: 'btn-primary lg' %>
  <%= link_to 'Cancel', resources_location, class: 'btn-secondary lg' %>
<% end %>
```

Here's an example with simple_form:

```erb
<%= simple_form_for [:admin, @resource] do |f| %>
  <%= f.input :title %>
  <%= f.input :description %>

  <%= f.submit 'Save', class: 'btn-primary lg' %>
  <%= link_to 'Cancel', resources_location, class: 'btn-secondary lg' %>
<% end %>
```

### Helpers

This library provides the following helpers:

#### Nav helper for the main menu

```ruby
nav_link('Events', events_path, 'admin/events') # label, url, controller name
```

#### Footer

```ruby
footer('Neuvents') # Copyright information
```

### Translations

The following translations are available:

```yml
en:
  neu_admin:
    search: "Search"
    are_you_sure: "Are you sure?"
    new_resource: "New %{resource}"
    edit_resource: "Edit %{resource}"
```

It is possible to custumize the resource name for the `new` and `edit` pages like so:

```yml
en:
  neu_admin:
    search: "Search"
    are_you_sure: "Are you sure?"
    new_resource: "New %{resource}"
    edit_resource: "Edit %{resource}"
    resources:
      product: "awesome product"
```

This way on the `new` form the title would be: `New awesome product`.

In order to translate just add this structure in the desired language in your rails appplication.

## Contributing

TODO: Contribution directions go here.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
