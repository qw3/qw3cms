# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "qw3cms/version"

Gem::Specification.new do |s|
  s.name        = "qw3cms"
  s.version     = Qw3cms::VERSION
  s.authors     = ["QW3"]
  s.email       = ["contato@qw3.com.br"]
  s.homepage    = "http://www.qw3.com.br"
  s.summary     = %q{Content Management System desenvolvido pela QW3}
  s.description = %q{Gem para controle de conteúdo de sites rails.}

  #s.rubyforge_project = "qw3cms"
  
  s.add_dependency "ckeditor"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
