require 'erb'

module Simpler
  class View

    VIEW_BASE_PATH = 'app/views'.freeze

    def initialize(env)
      @env = env
      @format = @env['simpler.template_format']
    end

    def render(binding)

      if @format == 'plain'
        template
      else
        template = File.read(template_path)

        ERB.new(template).result(binding)
      end

    end

    private

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
