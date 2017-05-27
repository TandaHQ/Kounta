
require 'helper'

describe Kounta::Register do
  subject { Kounta::Company.new(@client).webhook(537) }

  it 'should have a resource path' do
    expect(subject.resource_path).to eq(companies: 162, webhooks: 537)
  end

  it 'should be a listable resource' do
    expect(Kounta::Company.new(@client).webhooks.map(&:resource_path))
      .to eq([
               { companies: 162, webhooks: 537 },
               { companies: 162, webhooks: 549 }
             ])
  end

  it 'should be creatable' do
    Kounta::Company.new(@client).webhook.merge(
      topic: 'orders/completed',
      address: 'http://mywebsite.com/somewhere',
      format: 'json'
    ).save!

    expect(WebMock).to have_requested(:post, group_endpoint('webhooks'))
  end
end
