require 'net/http'

module Brandcaptcha
  class Client
    attr_reader :private_key, :public_key, :response, :debug

    API_HOST        = '//api.pontamedia.net'.freeze
    CHALLENGE_PATH  = 'challenge.php'.freeze
    VERIFY_PATH     = 'verify.php'.freeze

    def initialize(private_key, public_key)
      @private_key = private_key
      @public_key = public_key
      @debug = false
    end

    def script_tag(options={})
      params = options.merge(k: public_key)

      url = uri(CHALLENGE_PATH, options.fetch(:ssl, false))
      url.query = URI.encode_www_form(params)

      %Q[<script type="text/javascript" src="#{url}"></script>]
    end

    def check_answer(captcha, challenge, remote_ip)
      validate!(captcha, challenge, remote_ip)

      url = uri(VERIFY_PATH)
      request = Net::HTTP::Post.new(url)
      request.set_form_data(
        privatekey: private_key,
        remoteip: remote_ip,
        challenge: challenge,
        response: captcha
      )

      http = Net::HTTP.new(url.host, url.port)
      http.set_debug_output($stdout) if debug
      response = http.request(request)
      raise Brandcaptcha::Exception.new('Wrong answer') if response.body.split.first == 'false'.freeze
      response
    end

    private

    def validate!(captcha, challenge, remote_ip)
      raise_if_empty! captcha, 'Empty Response'.freeze
      raise_if_empty! challenge, 'Empty Challenge'.freeze
      raise_if_empty! remote_ip, 'Empty Remote IP'.freeze
    end

    def raise_if_empty!(validate, message)
      raise Brandcaptcha::Exception.new(message) if validate.empty?
    end

    def uri(path, ssl = false)
      if ssl
        URI.parse "https:#{API_HOST}/#{path}"
      else
        URI.parse "http:#{API_HOST}/#{path}"
      end
    end
  end
end
