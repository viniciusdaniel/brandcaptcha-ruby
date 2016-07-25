require "brandcaptcha/version"
require "brandcaptcha/client"
require "brandcaptcha/exception"

module Brandcaptcha
  module_function

  def create(*args)
    Brandcaptcha::Client.new *args
  end
end
