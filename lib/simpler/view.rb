require 'erb'

module Simpler
  class View
    VIEW_BASE_PATH = 'app/views'.freeze

    def initialize(env)
      @env = env
      @format = @env['simpler.template_format'] || 'html'
    end

    def render(binding)
      send("render_#{@format}", binding)
    end

    private

    def render_plain(_binding)
      template
    end

    def render_html(binding)
      template = File.read(template_path)

      ERB.new(template).result(binding)
    end

    def controller
      @env['simpler.controller']
    end

    def action
      @env['simpler.action']
    end

    def template
      @env['simpler.template']
    end

    def template_path
      path = template || [controller.name, action].join('/')

      view_path = "#{path}.html.erb"
      @env['simpler.path'] = view_path

      Simpler.root.join(VIEW_BASE_PATH, view_path)
    end
  end
end
