require 'helper'

describe Kounta::REST::Client do
  subject do
    Kounta::REST::Client.new(
      consumer: {
        key: '1234',
        secret: '5678'
      },
      access_token: 'abcd',
      refresh_token: 'efgh'
    )
  end

  it 'should be able to create a new client' do
    expect(subject).to be_an_instance_of(Kounta::REST::Client)
  end

  it 'should be able to generate a url from an ordered hash' do
    expect(subject.path_from_hash(companies: 162, products: nil)).to eq('companies/162/products')
    expect(subject.path_from_hash(companies: 162, products: 1234)).to eq('companies/162/products/1234')
  end

  it 'should be able to create objects from a response' do
    responses = subject.objects_from_response(Kounta::Product, :get, companies: 162, products: nil)
    responses.each do |response|
      expect(response).to be_an_instance_of Kounta::Product
    end
  end

  it 'should be able to create an object from a response' do
    expect(subject.object_from_response(Kounta::Product, :get, companies: 162, products: 555)).to be_an_instance_of Kounta::Product
  end

  it 'should refresh the token automatically' do
    stub_request(:get, group_endpoint('noop')).to_return(
      body: { message: 'The access token provided has expired' }.to_json,
      headers: endpoint_headers,
      status: 400
    )
    stub_request(:post, 'https://api.kounta.com/v1/token.json')
    expect { subject.perform({ company_id: 123, noop: nil }, :get) }.to raise_error Kounta::Errors::RequestError
  end
end
