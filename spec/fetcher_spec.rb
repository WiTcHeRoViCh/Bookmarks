require 'spec_helper'

describe Screencap::Fetcher do
  it 'takes a url' do
    expect(Screencap::Fetcher.new('http://google.com')).not_to be_nil
  end

  it 'supports a custom filename' do
    screenshot = Screencap::Fetcher.new('http://yahoo.com').fetch(:output => TMP_DIRECTORY + 'custom_filename.png')
    expect(File.exists?(screenshot)).to eq(true)
  end

  it 'supports a custom width' do
    screenshot = Screencap::Fetcher.new('http://google.com').fetch(:output => TMP_DIRECTORY + 'custom_width.jpg', :width => 800)
    expect(FastImage.size(screenshot)[0]).to eq(800)
  end

  it 'supports a custom height' do
    screenshot = Screencap::Fetcher.new('http://facebook.com').fetch(:output => TMP_DIRECTORY + 'custom_height.jpg', :height => 600)
    expect(FastImage.size(screenshot)[1]).to eq(600)
  end

  it 'should work when given a query string with ampersand in it' do
    screenshot = Screencap::Fetcher.new('http://google.com?1=2&3=4').fetch(:output => TMP_DIRECTORY + 'ampersand.jpg', :width => 800)
    expect(FastImage.size(screenshot)[0]).to eq(800)
  end
  
  it 'should work with tls' do
    screenshot = Screencap::Fetcher.new('https://www.airbnb.com/').fetch(:output => TMP_DIRECTORY + 'tls.jpg', :phantomjs => {:"--ssl-protocol" => :any})
    expect(File.exists?(screenshot)).to eq(true)
  end
end