module Simpler
  class Router
    class Route
      attr_reader :controller, :action

      def initialize(method, path, controller, action)
        @method = method
        @path = path
        @route_path = split_path(@path)
        @controller = controller
        @action = action
      end

      def match?(method, path)
        @method == method && match_route_path?(path)
      end

      def params
        @params
      end

      private

      def match_route_path?(path)
        request_path = split_path(path)

        return false if request_path.size != @route_path.size

        extract_params(request_path)
        same_path?(request_path)
      end

      def split_path(path)
        path.split('/').reject(&:empty?)
      end

      def add_param(key, value)
        @params ||= {}
        @params[key] = value
      end

      def extract_params(request_path)
        @route_path.each_with_index { |fragment, i| add_param(fragment, request_path[i]) if param?(fragment) }
      end

      def param?(fragment)
        fragment.start_with?(':')
      end

      def same_path?(request_path)
        @route_path.each_with_index do |fragment, i|
          unless param?(fragment)
            return false if fragment != request_path[i]
          end
        end
      end
    end
  end
end
