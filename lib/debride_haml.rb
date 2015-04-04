require 'debride'
require 'haml'

class Debride
  module Haml
    VERSION = '1.0.0'
  end

  def process_haml file
    haml = File.read file

    ruby = ::Haml::Engine.new(haml, ugly: true).precompiled

    begin
      RubyParser.new.process ruby, file
    rescue => e
      warn ruby if option[:verbose]
      raise e
    end
  end
end
