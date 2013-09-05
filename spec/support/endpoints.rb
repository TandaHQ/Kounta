require "oj"

module Helpers
	ROOT = "http://www.kounta.com/v1"

	def load_json_from_fixture(filename)
		File.read("#{Kounta.root}/spec/fixtures/#{filename}")
	end

	def stub_endpoints
		stub_request(:get, /#{ROOT}\/companies\/me\.json/).to_return(:body => load_json_from_fixture('companies_me.json')) # match */companies/me.json
		stub_request(:get, /#{ROOT}\/.+\/categories\/\d+\.json/).to_return(:body => load_json_from_fixture('category.json')) # match */categories/1234.json
		stub_request(:get, /#{ROOT}\/.+\/categories\.json/).to_return(:body => load_json_from_fixture('categories.json')) # match */categories.json
		stub_request(:get, /#{ROOT}\/.+\/products\/\d+\.json/).to_return(:body => load_json_from_fixture('product.json')) # match */products/1234.json
		stub_request(:get, /#{ROOT}\/.+\/products\.json/).to_return(:body => load_json_from_fixture('products.json')) # match */products.json
		stub_request(:get, /#{ROOT}\/.+\/sites\/\d+\.json/).to_return(:body => load_json_from_fixture('site.json')) # match */sites/1234.json
		stub_request(:get, /#{ROOT}\/.+\/sites\.json/).to_return(:body => load_json_from_fixture('sites.json')) # match */sites.json
		stub_request(:get, /#{ROOT}\/.+\/price_lists\/\d+\.json/).to_return(:body => load_json_from_fixture('price_list.json')) # match */sites/1234.json
		stub_request(:get, /#{ROOT}\/.+\/price_lists\.json/).to_return(:body => load_json_from_fixture('price_lists.json')) # match */sites.json
		stub_request(:get, /#{ROOT}\/.+\/price_lists\/base\.json/).to_return(:body => load_json_from_fixture('price_list.json')) # match */price_lists/base.json
	end
end