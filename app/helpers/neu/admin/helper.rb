module Neu::Admin::Helper
  def icon(name)
    content_tag :i, nil, class: "icon #{name}"
  end

  def yes_no(status)
    icon(status ? :check : :close)
  end

  def action_link(action, url, opts = {})
    opts = opts.merge(method: :delete, data: {confirm: 'Are you sure?'}) if action == :delete
    link_to icon(action), url, opts
  end

  def search_bar(&block)
    content_tag(:div, class: 'search') do
      content_tag(:h3, 'Search') +
      simple_form_for(@search, as: :f, method: :get, url: list_location) do |f|
        yield f
      end
    end
  end
end
