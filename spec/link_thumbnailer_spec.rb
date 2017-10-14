require 'spec_helper'

describe LinkThumbnailer do
  it 'works' do
    object = LinkThumbnailer.generate("http://www.google.com")
    expect(object.images.first.src.to_s).to eq("http://www.google.com.ua/textinputassistant/tia.png")
  end

  it 'error "Failed to open TCP connection to www.rgrgsg.com"' do
    expect {
      object = LinkThumbnailer.generate("http://www.iggmfkgnkf.com")
    }.to raise_error LinkThumbnailer::HTTPError, "Failed to open TCP connection to www.iggmfkgnkf.com:80 (getaddrinfo: Name or service not known)"
  end
end
