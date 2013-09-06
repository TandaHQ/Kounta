module Helpers

	def company_me_endpoint
		/\/.+\/companies\/me\.json/
	end

	def base_pricelist_endpoint
		/\/.+\/price_lists\/base\.json/
	end

	def singular_endpoint(name)
		/\/.+\/#{name}\/\d+\.json/
	end

	def group_endpoint(name)
		/\/.+\/#{name}\.json/
	end

	def load_json_from_fixture(filename)
		File.read("#{Kounta.root}/spec/fixtures/#{filename}")
	end

	def stub_endpoints

		# create
		stub_request(:post, group_endpoint('products')).to_return(:body => load_json_from_fixture('product.json'))

		# read
		stub_request(:get, company_me_endpoint).to_return(:body => load_json_from_fixture('companies_me.json'))
		stub_request(:get, singular_endpoint('categories')).to_return(:body => load_json_from_fixture('category.json'))
		stub_request(:get, group_endpoint('categories')).to_return(:body => load_json_from_fixture('categories.json'))
		stub_request(:get, singular_endpoint('products')).to_return(:body => load_json_from_fixture('product.json'))
		stub_request(:get, group_endpoint('products')).to_return(:body => load_json_from_fixture('products.json'))
		stub_request(:get, singular_endpoint('sites')).to_return(:body => load_json_from_fixture('site.json'))
		stub_request(:get, group_endpoint('sites')).to_return(:body => load_json_from_fixture('sites.json'))
		stub_request(:get, singular_endpoint('price_lists')).to_return(:body => load_json_from_fixture('price_list.json'))
		stub_request(:get, group_endpoint('price_lists')).to_return(:body => load_json_from_fixture('price_lists.json'))
		stub_request(:get, base_pricelist_endpoint).to_return(:body => load_json_from_fixture('price_list.json'))

		# update
		stub_request(:put, singular_endpoint('products')).to_return(:body => load_json_from_fixture('product.json'))

	end
end