module Helpers
  def company_me_endpoint
    %r{/.+/companies/me\.json}
  end

  def base_pricelist_endpoint
    %r{/.+/price_lists/base\.json}
  end

  def singular_endpoint(name)
    %r{/.+/#{name}/\d+\.json}
  end

  def group_endpoint(name)
    %r{/.+/#{name}\.json}
  end

  def load_json_from_fixture(filename)
    File.read("#{Kounta.root}/spec/fixtures/#{filename}")
  end

  def endpoint_headers
    { 'Content-Type' => 'application/json' }
  end

  def stub_endpoints
    # token
    stub_request(:post, group_endpoint('token')).to_return(
      body: {
        access_token: 'abcd',
        refresh_token: 'efgh',
        expires_in: 3600,
        token_type: 'Bearer'
      }.to_json,
      headers: endpoint_headers
    )

    # create
    stub_request(:post, group_endpoint('products')).to_return(body: load_json_from_fixture('product.json'), headers: endpoint_headers)
    stub_request(:post, group_endpoint('customers')).to_return(body: load_json_from_fixture('customer.json'), headers: endpoint_headers)
    stub_request(:post, group_endpoint('people')).to_return(body: load_json_from_fixture('person.json'), headers: endpoint_headers)
    stub_request(:post, group_endpoint('categories')).to_return(body: load_json_from_fixture('category.json'), headers: endpoint_headers)
    stub_request(:post, group_endpoint('addresses')).to_return(body: load_json_from_fixture('address.json'), headers: endpoint_headers)
    stub_request(:post, group_endpoint('payments')).to_return(body: load_json_from_fixture('payment.json'), headers: endpoint_headers)
    stub_request(:post, group_endpoint('lines')).to_return(body: load_json_from_fixture('line.json'), headers: endpoint_headers)
    stub_request(:post, group_endpoint('orders')).to_return(body: load_json_from_fixture('order.json'), headers: endpoint_headers)
    stub_request(:post, group_endpoint('webhooks')).to_return(body: load_json_from_fixture('webhook.json'), headers: endpoint_headers)

    # read
    stub_request(:get, singular_endpoint('categories')).to_return(body: load_json_from_fixture('category.json'), headers: endpoint_headers)
    stub_request(:get, group_endpoint('categories')).to_return(body: load_json_from_fixture('categories.json'), headers: endpoint_headers)
    stub_request(:get, singular_endpoint('customers')).to_return(body: load_json_from_fixture('customer.json'), headers: endpoint_headers)
    stub_request(:get, group_endpoint('customers')).to_return(body: load_json_from_fixture('customers.json'), headers: endpoint_headers)
    stub_request(:get, singular_endpoint('people')).to_return(body: load_json_from_fixture('person.json'), headers: endpoint_headers)
    stub_request(:get, group_endpoint('people')).to_return(body: load_json_from_fixture('people.json'), headers: endpoint_headers)
    stub_request(:get, singular_endpoint('addresses')).to_return(body: load_json_from_fixture('address.json'), headers: endpoint_headers)
    stub_request(:get, group_endpoint('addresses')).to_return(body: load_json_from_fixture('addresses.json'), headers: endpoint_headers)
    stub_request(:get, singular_endpoint('products')).to_return(body: load_json_from_fixture('product.json'), headers: endpoint_headers)
    stub_request(:get, group_endpoint('products')).to_return(body: load_json_from_fixture('products.json'), headers: endpoint_headers)
    stub_request(:get, singular_endpoint('registers')).to_return(body: load_json_from_fixture('register.json'), headers: endpoint_headers)
    stub_request(:get, group_endpoint('registers')).to_return(body: load_json_from_fixture('registers.json'), headers: endpoint_headers)
    stub_request(:get, singular_endpoint('sites')).to_return(body: load_json_from_fixture('site.json'), headers: endpoint_headers)
    stub_request(:get, group_endpoint('sites')).to_return(body: load_json_from_fixture('sites.json'), headers: endpoint_headers)
    stub_request(:get, singular_endpoint('price_lists')).to_return(body: load_json_from_fixture('price_list.json'),
                                                                   headers: endpoint_headers)
    stub_request(:get, group_endpoint('price_lists')).to_return(body: load_json_from_fixture('price_lists.json'), headers: endpoint_headers)
    stub_request(:get, base_pricelist_endpoint).to_return(body: load_json_from_fixture('price_list.json'), headers: endpoint_headers)
    stub_request(:get, company_me_endpoint).to_return(body: load_json_from_fixture('companies_me.json'), headers: endpoint_headers)
    stub_request(:get, group_endpoint('taxes')).to_return(body: load_json_from_fixture('taxes.json'), headers: endpoint_headers)
    stub_request(:get, singular_endpoint('orders')).to_return(body: load_json_from_fixture('order.json'), headers: endpoint_headers)
    stub_request(:get, group_endpoint('orders')).to_return(body: load_json_from_fixture('orders.json'), headers: endpoint_headers)
    stub_request(:get, group_endpoint('inventory')).to_return(body: load_json_from_fixture('inventory.json'), headers: endpoint_headers)
    stub_request(:get, singular_endpoint('webhooks')).to_return(body: load_json_from_fixture('webhook.json'), headers: endpoint_headers)
    stub_request(:get, group_endpoint('webhooks')).to_return(body: load_json_from_fixture('webhooks.json'), headers: endpoint_headers)

    # update
    stub_request(:put, singular_endpoint('products')).to_return(body: load_json_from_fixture('product.json'), headers: endpoint_headers)
    stub_request(:put, singular_endpoint('customers')).to_return(body: load_json_from_fixture('customer.json'), headers: endpoint_headers)
    stub_request(:put, singular_endpoint('people')).to_return(body: load_json_from_fixture('person.json'), headers: endpoint_headers)
    stub_request(:put, singular_endpoint('categories')).to_return(body: load_json_from_fixture('category.json'), headers: endpoint_headers)
    stub_request(:put, singular_endpoint('addresses')).to_return(body: load_json_from_fixture('address.json'), headers: endpoint_headers)
    stub_request(:put, singular_endpoint('payments')).to_return(body: load_json_from_fixture('payment.json'), headers: endpoint_headers)
    stub_request(:put, singular_endpoint('lines')).to_return(body: load_json_from_fixture('line.json'), headers: endpoint_headers)
    stub_request(:put, singular_endpoint('orders')).to_return(body: load_json_from_fixture('order.json'), headers: endpoint_headers)
    stub_request(:put, singular_endpoint('webhooks')).to_return(body: load_json_from_fixture('webhook.json'), headers: endpoint_headers)
  end
end
