module Neu::Admin::Helper
  def yes_no(status)
    status ? '✓' : '×'
  end

  def action_link(action, url, opts = {}, &block)
    if action == :delete
      opts = opts.merge(
        # For older rails versions
        method: :delete,
        data: {
          # Cover the rails 7 case
          turbo_confirm: t('neu_admin.are_you_sure'), turbo_method: :delete,
          # For older rails versions
          confirm: t('neu_admin.are_you_sure')
        }
      )
    end

    link_to(url, opts) do
      yield block
    end
  end

  def nav_link(label, url, controller_name, current_class)
    link_to(label, url, class: "nav-link #{(params[:controller] == controller_name ? current_class : '')}")
  end

  def search_bar(search_location, &block)
    content_tag(:div, class: 'search') do
      content_tag(:h3, t('neu_admin.search')) +
        simple_form_for(@search, as: :f, method: :get, url: search_location, &block)
    end
  end

  def resource_label(resource)
    key = resource.class.name.underscore.downcase
    label = resource.class.name.underscore.humanize.downcase

    I18n.t("neu_admin.resources.#{key}", default: label)
  end

  def form_section(title:, description: nil, &block)
    tag.fieldset(class: 'form-section', id: title.parameterize) do
      (tag.div class: 'legend' do
        tag.legend(title) +
        tag.small(description, class: 'muted')
      end) + (tag.div(class: 'fields') do
        yield block
      end)
    end
  end

  def form_nav(items = [])
    tag.nav class: 'form-sections-nav' do
      (items.map do |section|
        link_to section, "##{section.parameterize}"
      end).reduce(&:+)
    end
  end
end
