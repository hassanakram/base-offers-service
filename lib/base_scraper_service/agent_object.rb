require_relative 'user_agent'
require "mechanize"
require "nokogiri"

module BaseScraper
  class Service
    def agent_object
      agent = Mechanize.new
      agent.read_timeout = 5
      agent.open_timeout = 8
      agent.keep_alive = false
      agent.verify_mode = OpenSSL::SSL::VERIFY_NONE
      agent.user_agent = UserAgent.random
      agent.idle_timeout = 5
      agent.pluggable_parser.default = Mechanize::Page

      # Prevent from <Mechanize::Error: unsupported content-encoding: UTF-8>
      content_encoding_hooks_func = lambda do |a, uri, resp, body_io|
        if resp['Content-Encoding'].to_s == 'UTF-8'
          resp['Content-Encoding'] = 'gzip'
        end
      end
      agent.content_encoding_hooks << content_encoding_hooks_func

      agent
    end
  end
end
