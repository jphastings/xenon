require 'xenon/routing/route_directives'

module Xenon
  module Routing
    module HeaderDirectives
      include RouteDirectives

      def optional_header(name)
        extract_request do |request|
          yield request.header(name)
        end
      end

      def header(name)
        optional_header(name) do |value|
          if value
            yield value
          else
            reject Rejection.new(:header, { required: name })
          end
        end
      end

      def respond_with_header(header)
        map_response -> r { r.copy(headers: r.headers.add(header)) } do
          yield
        end
      end

    end
  end
end