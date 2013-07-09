module Linkedin2
  module API
  
    # The Base class of API
    class Request
      DEFAULT_HEADERS = {
        'x-li-format' => 'json'
      }

      API_PATH = '/v1'

      def initialize(client)
        @client = client
      end

      protected
        def request(verb, path, opts={}, &block)
          reise_authorized?

          response = @client.token.request(verb, path, opts, &block)
          raise_errors(response)
          response.body
        end


        def get(path, options={})
          request(:get, "#{API_PATH}#{path}", DEFAULT_HEADERS.merge(options), &block)
        end

        def post(path, body='', options={})
          reise_authorized?

          response = @client.token.post("#{API_PATH}#{path}", body, DEFAULT_HEADERS.merge(options))
          raise_errors(response)
          response
        end

        def put(path, body, options={})
          reise_authorized?
          
          response = @client.token.put("#{API_PATH}#{path}", body, DEFAULT_HEADERS.merge(options))
          raise_errors(response)
          response
        end

        def delete(path, options={})
          request(:delete, "#{API_PATH}#{path}", DEFAULT_HEADERS.merge(options), &block)
        end

        def reise_authorized?
          raise "I can't find a valid access_token. Forgot to get it or expired?" unless @client.is_authorized?
        end

      private

        def raise_errors(response)
          # Even if the json answer contains the HTTP status code, LinkedIn also sets this code
          # in the HTTP answer (thankfully).
          case response.code.to_i
          when 401
            data = Mash.from_json(response.body)
            raise LinkedIn::Errors::UnauthorizedError.new(data), "(#{data.status}): #{data.message}"
          when 400
            data = Mash.from_json(response.body)
            raise LinkedIn::Errors::GeneralError.new(data), "(#{data.status}): #{data.message}"
          when 403
            data = Mash.from_json(response.body)
            raise LinkedIn::Errors::AccessDeniedError.new(data), "(#{data.status}): #{data.message}"
          when 404
            raise LinkedIn::Errors::NotFoundError, "(#{response.code}): #{response.message}"
          when 500
            raise LinkedIn::Errors::InformLinkedInError, "LinkedIn had an internal error. Please let them know in the forum. (#{response.code}): #{response.message}"
          when 502..503
            raise LinkedIn::Errors::UnavailableError, "(#{response.code}): #{response.message}"
          end
        end


        # Stolen from Rack::Util.build_query
        def to_query(params)
          params.map { |k, v|
            if v.class == Array
              to_query(v.map { |x| [k, x] })
            else
              v.nil? ? escape(k) : "#{CGI.escape(k.to_s)}=#{CGI.escape(v.to_s)}"
            end
          }.join("&")
        end

        def to_uri(path, options)
          uri = URI.parse(path)

          if options && options != {}
            uri.query = to_query(options)
          end
          uri.to_s
        end

    end
    
  end
end
