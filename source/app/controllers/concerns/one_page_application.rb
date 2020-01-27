# frozen_string_literal: true

module OnePageApplication
  extend ActiveSupport::Concern
  include Tarquinn

  included do
    layout :layout_for_page
    redirection_rule :render_root, :perform_angular_redirect?
    skip_redirection_rule :render_root, :ajax?, :home?
  end

  private

  def render_root
    "##{request.path}"
  end

  def home?
    request.path == '/'
  end

  def ajax?
    params[:ajax]
  end

  def perform_angular_redirect?
    html?
  end

  def html?
    request.format.html?
  end

  def layout_for_page
    ajax? ? false : 'application'
  end
end
