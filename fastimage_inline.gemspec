# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{fastimage_inline}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Stephen Sykes"]
  s.date = %q{2009-09-15}
  s.description = %q{FastImage Inline places small images inline in you HTML IMG tags code using a 'data' url.}
  s.email = %q{sdsykes@gmail.com}
  s.extra_rdoc_files = ["README", "README.textile"]
  s.files = ["Rakefile", "README", "README.textile", "VERSION.yml", "lib/fastimage_inline.rb"]
  s.homepage = %q{http://github.com/sdsykes/fastimage_inline}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{FastImage Inline - Speeds up your webpages with inline images in HTML using a data url}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
