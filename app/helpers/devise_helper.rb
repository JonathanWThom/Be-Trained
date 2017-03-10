module DeviseHelper
  def devise_error_messages!
    if defined?(resource) != nil && resource.is_a?(Coach)
      return '' if resource.errors.empty?

      messages = resource.errors.full_messages.map { |msg| content_tag(:p, msg) }.join
      html = <<-HTML
      <div class="notice">
        #{messages}
      </div>
      HTML

      html.html_safe
    end
  end
end
