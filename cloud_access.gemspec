# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "cloud_access/version"

Gem::Specification.new do |s|
  s.name        = "cloud_access"
  s.version     = CloudAccess::VERSION
  s.authors     = ["Mike Mell"]
  s.email       = ["mike.mell@nthwave.net"]
  s.homepage    = ""
  s.summary     = %q{ruby wrapper for the ec2 API}
  s.description = %q{CloaudAccess wraps the EC2 API and converts the EC2 responses into Ruby class instances.}

  s.rubyforge_project = "cloud_access"

#  s.files         = `git ls-files`.split("\n")
  s.files = FileList["lib/**/*.rb"].to_a
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
#?  s.autorequire = "cloud_access"
  s.has_rdoc = true
  s.extra_rdoc_files = ["README"]
#  s.add_dependency("dependency", ">= 0.x.x")
  s.post_install_message = %q{Thank you for installing CloudAccess!

See the examples for usage.
}

end
