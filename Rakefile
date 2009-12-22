require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "fastimage_inline"
    s.summary = "FastImage Inline - Speeds up your webpages with inline images in HTML using a data url"
    s.email = "sdsykes@gmail.com"
    s.homepage = "http://github.com/sdsykes/fastimage_inline"
    s.description = "FastImage Inline places small images inline in you HTML IMG tags code using a 'data' url."
    s.authors = ["Stephen Sykes"]
    s.files = FileList["[A-Z]*", "{lib,test}/**/*"]
    s.add_dependency('fastimage', '>= 1.1.2')
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://
gems.github.com"
end
