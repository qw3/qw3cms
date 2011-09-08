require "qw3cms/version"
require "inflections"

module Qw3cms
  class Qw3cms < Rails::Engine
    config.autoload_paths << File.expand_path("../app", __FILE__)
  end
end
