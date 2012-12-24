module ApplicationHelper
  include Redcarpet

  def html_options
    {:filter_html => true, :hard_wrap => true}
  end

  def markdown_options
    {:autolink => true, :no_intra_emphasis => true, :superscript => true}
  end

  def markdown text
    @markdown ||= Markdown.new(Render::HTML.new(html_options), markdown_options)
    @markdown.render(text).html_safe
  end
end
