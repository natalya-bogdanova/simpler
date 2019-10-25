module Simpler
  class Router
    class Route

      attr_reader :controller, :action, :params

      def initialize(method, path, controller, action)
        @method = method
        @path = path
        @controller = controller
        @action = action
        @params = {}
      end

      def match?(method, path)
        @method == method && path_match?(path)
      end

      private

      def path_match?(path)

        request_fragments = path.split('/').reject(&:empty?)
        path_fragments = @path.split('/').reject(&:empty?)

        return false if request_fragments.size != path_fragments.size

        path_fragments.each_with_index do |fragment, i|
          if fragment.start_with?(':')
            @params[fragment] = request_fragments[i]
          else
            return false if fragment != request_fragments[i]
          end
        end

      end

    end
  end
end
