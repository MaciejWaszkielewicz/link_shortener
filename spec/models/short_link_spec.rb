require 'rails_helper'

RSpec.describe ShortLink, type: :model do
  before(:each) do
    @short_link = build :short_link
  end

  it "is valid with valid attributes" do
    expect(@short_link).to be_valid
  end

  it "is not valid with wrong url format" do
    ['google.com', 'invalid', 'not valid'].each do |url|
      @short_link.url = url
      expect(@short_link).to_not be_valid
    end
  end

  it "is not valid with with wrong slug format" do
    @short_link.slug = 'with space'
    expect(@short_link).to_not be_valid
  end

  it "provided slug should be not changed" do
    @short_link.slug = 'test'
    @short_link.save

    expect(@short_link.slug).to eql 'test'
  end
end