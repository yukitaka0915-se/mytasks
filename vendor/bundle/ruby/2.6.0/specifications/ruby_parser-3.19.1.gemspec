# -*- encoding: utf-8 -*-
# stub: ruby_parser 3.19.1 ruby lib

Gem::Specification.new do |s|
  s.name = "ruby_parser".freeze
  s.version = "3.19.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "https://github.com/seattlerb/ruby_parser/issues", "homepage_uri" => "https://github.com/seattlerb/ruby_parser" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Ryan Davis".freeze]
  s.cert_chain = ["-----BEGIN CERTIFICATE-----\nMIIDPjCCAiagAwIBAgIBBjANBgkqhkiG9w0BAQsFADBFMRMwEQYDVQQDDApyeWFu\nZC1ydWJ5MRkwFwYKCZImiZPyLGQBGRYJemVuc3BpZGVyMRMwEQYKCZImiZPyLGQB\nGRYDY29tMB4XDTIxMTIyMzIzMTkwNFoXDTIyMTIyMzIzMTkwNFowRTETMBEGA1UE\nAwwKcnlhbmQtcnVieTEZMBcGCgmSJomT8ixkARkWCXplbnNwaWRlcjETMBEGCgmS\nJomT8ixkARkWA2NvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALda\nb9DCgK+627gPJkB6XfjZ1itoOQvpqH1EXScSaba9/S2VF22VYQbXU1xQXL/WzCkx\ntaCPaLmfYIaFcHHCSY4hYDJijRQkLxPeB3xbOfzfLoBDbjvx5JxgJxUjmGa7xhcT\noOvjtt5P8+GSK9zLzxQP0gVLS/D0FmoE44XuDr3iQkVS2ujU5zZL84mMNqNB1znh\nGiadM9GHRaDiaxuX0cIUBj19T01mVE2iymf9I6bEsiayK/n6QujtyCbTWsAS9Rqt\nqhtV7HJxNKuPj/JFH0D2cswvzznE/a5FOYO68g+YCuFi5L8wZuuM8zzdwjrWHqSV\ngBEfoTEGr7Zii72cx+sCAwEAAaM5MDcwCQYDVR0TBAIwADALBgNVHQ8EBAMCBLAw\nHQYDVR0OBBYEFEfFe9md/r/tj/Wmwpy+MI8d9k/hMA0GCSqGSIb3DQEBCwUAA4IB\nAQCKB5jfsuSnKb+t/Wrh3UpdkmX7TrEsjVmERC0pPqzQ5GQJgmEXDD7oMgaKXaAq\nx2m+KSZDrqk7c8uho5OX6YMqg4KdxehfSLqqTZGoeV78qwf/jpPQZKTf+W9gUSJh\nzsWpo4K50MP+QtdSbKXZwjAafpQ8hK0MnnZ/aeCsW9ov5vdXpYbf3dpg6ADXRGE7\nlQY2y1tJ5/chqu6h7dQmnm2ABUqx9O+JcN9hbCYoA5i/EeubUEtFIh2w3SpO6YfB\nJFmxn4h9YO/pVdB962BdBNNDia0kgIjI3ENnkLq0dKpYU3+F3KhEuTksLO0L6X/V\nYsuyUzsMz6GQA4khyaMgKNSD\n-----END CERTIFICATE-----\n".freeze]
  s.date = "2022-04-06"
  s.description = "ruby_parser (RP) is a ruby parser written in pure ruby (utilizing\nracc--which does by default use a C extension). It outputs\ns-expressions which can be manipulated and converted back to ruby via\nthe ruby2ruby gem.\n\nAs an example:\n\n    def conditional1 arg1\n      return 1 if arg1 == 0\n      return 0\n    end\n\nbecomes:\n\n    s(:defn, :conditional1, s(:args, :arg1),\n      s(:if,\n        s(:call, s(:lvar, :arg1), :==, s(:lit, 0)),\n        s(:return, s(:lit, 1)),\n        nil),\n      s(:return, s(:lit, 0)))\n\nTested against 801,039 files from the latest of all rubygems (as of 2013-05):\n\n* 1.8 parser is at 99.9739% accuracy, 3.651 sigma\n* 1.9 parser is at 99.9940% accuracy, 4.013 sigma\n* 2.0 parser is at 99.9939% accuracy, 4.008 sigma\n* 2.6 parser is at 99.9972% accuracy, 4.191 sigma\n* 3.0 parser has a 100% parse rate.\n  * Tested against 2,672,412 unique ruby files across 167k gems.\n  * As do all the others now, basically.".freeze
  s.email = ["ryand-ruby@zenspider.com".freeze]
  s.executables = ["ruby_parse".freeze, "ruby_parse_extract_error".freeze]
  s.extra_rdoc_files = ["History.rdoc".freeze, "Manifest.txt".freeze, "README.rdoc".freeze, "debugging.md".freeze, "gauntlet.md".freeze]
  s.files = ["History.rdoc".freeze, "Manifest.txt".freeze, "README.rdoc".freeze, "bin/ruby_parse".freeze, "bin/ruby_parse_extract_error".freeze, "debugging.md".freeze, "gauntlet.md".freeze]
  s.homepage = "https://github.com/seattlerb/ruby_parser".freeze
  s.licenses = ["MIT".freeze]
  s.rdoc_options = ["--main".freeze, "README.rdoc".freeze]
  s.required_ruby_version = Gem::Requirement.new([">= 2.1".freeze, "< 4".freeze])
  s.rubygems_version = "3.1.2".freeze
  s.summary = "ruby_parser (RP) is a ruby parser written in pure ruby (utilizing racc--which does by default use a C extension)".freeze

  s.installed_by_version = "3.1.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<sexp_processor>.freeze, ["~> 4.16"])
    s.add_development_dependency(%q<rake>.freeze, [">= 10", "< 15"])
    s.add_development_dependency(%q<oedipus_lex>.freeze, ["~> 2.6"])
    s.add_development_dependency(%q<racc>.freeze, ["~> 1.5"])
    s.add_development_dependency(%q<rdoc>.freeze, [">= 4.0", "< 7"])
    s.add_development_dependency(%q<hoe>.freeze, ["~> 3.23"])
  else
    s.add_dependency(%q<sexp_processor>.freeze, ["~> 4.16"])
    s.add_dependency(%q<rake>.freeze, [">= 10", "< 15"])
    s.add_dependency(%q<oedipus_lex>.freeze, ["~> 2.6"])
    s.add_dependency(%q<racc>.freeze, ["~> 1.5"])
    s.add_dependency(%q<rdoc>.freeze, [">= 4.0", "< 7"])
    s.add_dependency(%q<hoe>.freeze, ["~> 3.23"])
  end
end
