module Neu::Admin::Helper
  def icon(name)
    content_tag :i, nil, class: "icon #{name}"
  end

  def yes_no(status)
    icon(status ? :check : :close)
  end

  def action_link(action, url, opts = {})
    opts = opts.merge(method: :delete, data: {confirm: t('neu_admin.are_you_sure')}) if action == :delete
    link_to icon(action), url, opts
  end

  def search_bar(search_location, &block)
    content_tag(:div, class: 'search') do
      content_tag(:h3, t('neu_admin.search')) +
      simple_form_for(@search, as: :f, method: :get, url: search_location) do |f|
        yield f
      end
    end
  end

  def page_title(title)
    content_tag(:div, class: 'page-title') do
      content_tag(:h1, title)
    end
  end

  def toolbar(&block)
    content_tag(:div, class: 'btn-toolbar') do
      yield block
    end
  end

  def nav_link(label, url, controller_name)
    link_to(label, url, class: (params[:controller] == controller_name ? 'current' : ''))
  end

  def footer(copyright = 'Administration')
    content_tag(:div, class: 'footer') do
      content_tag(:div, class: 'container') do
        content_tag(:small, "© #{Date.today.year}, #{copyright}")
      end
    end
  end

  def resource_label(resource)
    label = resource.class.name.underscore.humanize.downcase

    I18n.t("neu_admin.resources.#{label}", default: label)
  end
end
