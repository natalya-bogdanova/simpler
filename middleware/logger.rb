require 'logger'

class AppLogger
  def initialize(app, **options)
    @logger = Logger.new(options[:logdev] || STDOUT)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)
    @logger.info(log_info(env, status, headers))

    [status, headers, body]
  end

  private

  def log_info(env, status, headers)
    "
    REQUEST : #{env['REQUEST_METHOD']}  #{env['REQUEST_URI']}
    Handler: #{env['simpler.controller'].class}##{env['simpler.action']}
    Parameters: #{env['route.params']}
    Response: #{status} [#{headers['Content-Type']}] #{env['simpler.path']}\n\n"
  end
end
