Gem::Specification.new do |s| 
  s.name = "CloudAccess"
  s.version = "0.0.1"
  s.date = %q{2011-04-25}
  s.author = "Michael Mell"
  s.email = "cloud_access@nthwave.net"
#  s.homepage = ""
  s.platform = Gem::Platform::RUBY
  s.summary = "ruby access to the ec2 command line interface"
  s.files = FileList["lib/**/*.rb"].to_a
  s.require_path = "lib"
  s.autorequire = "cloud_access"
  s.test_files = FileList["rspec/**/*.rb"].to_a
  s.has_rdoc = true
  s.extra_rdoc_files = ["README"]
#  s.add_dependency("dependency", ">= 0.x.x")
  s.post_install_message = %q{Thank you for installing Cloud Access!

See the examples for usage. }
}