require 'helper'

describe Kounta::REST::Client do
  subject { Kounta::REST::Client.new }

  it 'should throw an error when creating a client without required tokens' do
    Kounta.client_token = nil
    expect { Kounta::REST::Client.new }.to raise_error Kounta::Errors::MissingOauthDetails
  end

  it 'should be able to create a new client' do
    subject.should be_an_instance_of(Kounta::REST::Client)
  end

  it 'should be able to generate a url from an ordered hash' do
    subject.path_from_hash(companies: 162, products: nil).should eq('companies/162/products')
    subject.path_from_hash(companies: 162, products: 1234).should eq('companies/162/products/1234')
  end

  it 'should be able to create objects from a response' do
    responses = subject.objects_from_response(Kounta::Product, :get, companies: 162, products: nil)
    responses.each do |response|
      response.should be_an_instance_of Kounta::Product
    end
  end

  it 'should be able to create an object from a response' do
    subject.object_from_response(Kounta::Product, :get, companies: 162, products: 555).should be_an_instance_of Kounta::Product
  end

  it 'should refresh the token automatically' do
    stub_request(:get, group_endpoint('noop')).to_return(
      body: { message: 'The access token provided has expired' },
      headers: endpoint_headers,
      status: 400
    )
    stub_request(:post, 'https://api.kounta.com/v1/token.json')
    expect { subject.perform({ company_id: 123, noop: nil }, :get) }.to raise_error OAuth2::Error
  end
end
