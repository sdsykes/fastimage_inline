# FastImage Inline speeds up your webpages with inline images in HTML using a data uri
#
# FastImage Inline uses the data uri scheme to place images inline in your image tags,
# thus saving the http connections that would otherwise have to be made from the browser
# for each image.
#
# === Example
#
#   inline_image_tag("bullet.gif")
#
# Result for request from data-uri capable browser:
#
#   "<img alt=\"Bullet\" src=\"data:image/gif;base64,R0lGODlhCAANAJECAAAAAP///////wAAACH5BAEAAAIALAAAAAAIAA0AAAITlI+p
#   yxgPI5gAUvruzJpfi0ViAQA7\" />"
#
# Result for non-capable browser:
#
#   "<img alt=\"Bullet\" src=\"/images/bullet.gif?1206090639\" />"
#
# === Requirements
#
# FastImage
#
#   sudo gem install sdsykes-fastimage -s http://gems.github.com
#
# === References
#
# * "http://tools.ietf.org/html/rfc2397":http://tools.ietf.org/html/rfc2397
# * "http://en.wikipedia.org/wiki/Data_URI_scheme":http://en.wikipedia.org/wiki/Data_URI_scheme

require 'open-uri'
require 'fastimage'

module FastImageInline
  # Returns a tag for the image
  # Works just like image_tag, except that if the browser making the request being processed
  # can handle data uris then the image itself is sent placed in the src attribute rather 
  # than just the path to it.
  #
  def inline_image_tag(source, options = {})
    options.symbolize_keys!
    options[:alt] ||= File.basename(source, '.*').split('.').first.to_s.capitalize
    options[:src] = inline_image_path(source)

    if size = options.delete(:size)
      options[:width], options[:height] = size.split("x") if size =~ %r{^\d+x\d+$}
    end

    if mouseover = options.delete(:mouseover)
      options[:onmouseover] = "this.src='#{inline_image_path(mouseover)}'"
      options[:onmouseout]  = "this.src='#{inline_image_path(options[:src])}'"
    end

    tag("img", options)
  end

  # Returns the image path for use in a src parameter in an image tag
  # Usage is the same as image_path, or path_to_image, except that if the browser
  # making the request is capable of handling it then the image itself is included
  # in a data uri rather than just the path to the image
  #
  def inline_image_path(source)
    public_path = respond_to?(:compute_public_path) ? compute_public_path(source, 'images') : asset_paths.compute_public_path(source, 'images')

    has_request = respond_to?(:request)

    if has_request && inline_capable_browser?
      inline_image_data(public_path)
    else
      public_path
    end
  end
  
  private
  def inline_image_data(uri)
    if is_uri?(uri)
      u = URI.parse(uri)
      contents = open(u).read
    else
      uri = "#{Rails.root}/public#{uri.gsub(/\?.*$/, "")}"
      contents = File.read(uri)
    end
    data = [contents].pack("m").gsub(/\n/,"")
    type = FastImage.type(uri, :raise_on_failure=>true)
    "data:image/#{type};base64,#{data}"
  end
  
  def is_uri?(path)
    path =~ %r{^[-a-z]+://}
  end

  def inline_capable_browser?
    if @inline_capable_browser.nil?
      ua = request.env['HTTP_USER_AGENT'].downcase
      @inline_capable_browser = if ua.index('msie') && !ua.index('opera') && !ua.index('webtv')
        ua[(ua.index('msie') + 5)..-1].to_i > 7
      elsif ua.index('gecko/') 
        true
      elsif ua.index('opera')
        true
      elsif ua.index('konqueror') 
        true
      elsif ua.index('applewebkit/')
        true
      elsif ua.index('mozilla/')
        true
      else
        false
      end
    else
      @inline_capable_browser
    end
  end
  
end

ActionView::Base.send(:include, FastImageInline)
