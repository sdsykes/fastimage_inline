require 'rubygems'

require 'test/unit'

PathHere = File.dirname(__FILE__)

require 'fakeweb'

FixturePath = File.join(PathHere, "fixtures")

gem 'rails'

RAILS_ROOT = PathHere
RAILS_ENV = "test"

require File.join(PathHere, 'config', 'environment')

require File.join(PathHere, "..", "lib", 'fastimage_inline')

require 'rails/test_help'

class InlineTests < ActionController::TestCase
  def setup
    @controller = MainController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    super
  end

  BG_PNG_ENC = "data:image/png;base64,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"
  BULLET_GIF_ENC = "data:image/gif;base64,R0lGODlhCAANAJECAAAAAP///////wAAACH5BAEAAAIALAAAAAAIAA0AAAITlI+pyxgPI5gAUvruzJpfi0ViAQA7"
  FLAG_JPG_ENC = "data:image/jpeg;base64,/9j/4AAQSkZJRgABAgAAZABkAAD/7AARRHVja3kAAQAEAAAAPAAA/+4ADkFkb2JlAGTAAAAAAf/bAIQABgQEBAUEBgUFBgkGBQYJCwgGBggLDAoKCwoKDBAMDAwMDAwQDA4PEA8ODBMTFBQTExwbGxscHx8fHx8fHx8fHwEHBwcNDA0YEBAYGhURFRofHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8f/8AAEQgADwAZAwERAAIRAQMRAf/EAIgAAAMBAQAAAAAAAAAAAAAAAAIEBQMGAQEBAQEAAAAAAAAAAAAAAAADBAAFEAABBAAEAwUJAQAAAAAAAAADAQIEBQARIQZBEhRRUhNTlDFhIkLT1BUWVgcRAAECAwUECAcAAAAAAAAAAAIBAwARBCFxElIFMVFhE4GRodHhkiMU8EHBInKiFf/aAAwDAQACEQMRAD8AxiyaW2pR029rClsoUVqpDfHNKYcOeirFKsbmDp8juYbuxuF960yU2CWWUtnXHfXR6qoST7SoeccP7DOS3pJb4RSt2bVmr6Gv3IGZVrHtxutXhIxA9eFWCaViJmrkXi3Rfdgn9QE6kHcu2LKPRqgKB5lR+81SXZDNFS/53tupU1fY1lreFao3Cmkkijo1eJ3sArytXyRoxvec7DOaiNQvqlhbyj9ViMNGqadPQaVXM5Smn4jOy+1boP8Add//ANHtD0a/aYbn6fuWJv5Wrbi8yd8GO52vt6tKW9ZSbgt1RG9LWQgrEA5ddHj5SSX5disGneXErg0zhYWkEUzEXjF7X9IBxvE8u4RRVJb7JD028Ikxdx0Exay6JTVsd8ePaKarexrBmeAauidQNqs+IjtG5ZZ8M8C7TsC+AISEHzWyXdFzFRXFRvEouC5NMCSLFKzZO1eMVo+49n7krCGqIdVt60G3xDVtlDj8qKiZL08gvhiMxV15HqwicFd7MM4wwyU1wOBwJJp2xAy9XujhXntOb8JKK32TS9OqOY/KXXm7V9Cz6WG5um5S+OmN7TW86+bwj//Z"
  
  test "normal image tags are unaffected by browser version" do
    @request.env['HTTP_USER_AGENT'] = "msie 7"
    get "index"
    assert_response :success
    assert_select "img#i1[src=?]", %r{/assets/bg.png}
    @request.env['HTTP_USER_AGENT'] = "msie 8"
    get "index"
    assert_response :success
    assert_select "img#i1[src=?]", %r{/assets/bg.png}
  end

  test "inline image tags are rendered as normal tags if browser is not recognised" do
    @request.env['HTTP_USER_AGENT'] = "rails test"
    get "index"
    assert_response :success
    assert_select "img#i2[src=?]", %r{/images/bg.png}
    assert_select "img#i3[src=?]", %r{/images/bullet.gif}
    assert_select "img#i4[src=?]", %r{/images/flag.jpg}
  end
  
  test "inline images are rendered inline for ie 8" do
    @request.env['HTTP_USER_AGENT'] = "msie 8"
    get "index"
    assert_select "img#i3[src=?]", BULLET_GIF_ENC
  end

  test "inline images are rendered correctly" do
    @request.env['HTTP_USER_AGENT'] = "opera"
    get "index"
    assert_select "img#i2[src=?]", BG_PNG_ENC
    assert_select "img#i3[src=?]", BULLET_GIF_ENC
    assert_select "img#i4[src=?]", FLAG_JPG_ENC
  end
  
  test "specified user agents must receive encoded images" do
    %w{opera gecko/ konqueror applewebkit/ mozilla/}.each do |ua|
      @request.env['HTTP_USER_AGENT'] = ua
      get "index"
      assert_select "img#i2[src=?]", BG_PNG_ENC
    end
  end
end
