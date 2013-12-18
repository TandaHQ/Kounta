module Kounta

	class Company < Kounta::Resource

		property :name
		property :shipping_address
		property :postal_address
		property :addresses
		property :business_number
		property :contact_staff_member
		property :image
		property :website
		property :currency
		property :timezone
		property :sites
		property :registers
		property :email

		has_one :product, Kounta::Product, {:company_id => :id}, lambda { |klass, item_id| {companies: klass.id, products: item_id} }
		has_one :category, Kounta::Category, {:company_id => :id}, lambda { |klass, item_id| {companies: klass.id, categories: item_id} }
		has_one :customer, Kounta::Customer, {:company_id => :id}, lambda { |klass, item_id| {companies: klass.id, customers: item_id} }
		has_one :person, Kounta::Person, {:company_id => :id}, lambda { |klass, item_id| {companies: klass.id, people: item_id} }
		has_one :site, Kounta::Site, {:company_id => :id}, lambda { |klass, item_id| {companies: klass.id, sites: item_id} }
		has_one :price_list, Kounta::PriceList, {:company_id => :id}, lambda { |klass, item_id| {companies: klass.id, price_lists: item_id} }
		has_one :tax, Kounta::Tax, {:company_id => :id}, lambda { |klass, item_id| {companies: klass.id, taxes: item_id} }
		has_one :order, Kounta::Order, {:company_id => :id}, lambda { |klass, item_id| {companies: klass.id, orders: item_id} }
		has_one :register, Kounta::Register, {:company_id => :id}, lambda { |klass, item_id| {companies: klass.id, registers: item_id} }

		has_many :products, Kounta::Product, {:company_id => :id}, lambda { |klass| {companies: klass.id, products: nil} }
		has_many :categories, Kounta::Category, {:company_id => :id}, lambda { |klass| {companies: klass.id, categories: nil} }
		has_many :customers, Kounta::Customer, {:company_id => :id}, lambda { |klass| {companies: klass.id, customers: nil} }
		has_many :people, Kounta::Person, {:company_id => :id}, lambda { |klass| {companies: klass.id, people: nil} }
		has_many :sites, Kounta::Site, {:company_id => :id}, lambda { |klass| {companies: klass.id, sites: nil} }
		has_many :price_lists, Kounta::PriceList, {:company_id => :id}, lambda { |klass| {companies: klass.id, price_lists: nil} }
		has_many :taxes, Kounta::Tax, {:company_id => :id}, lambda { |klass| {companies: klass.id, taxes: nil} }
		has_many :orders, Kounta::Order, {:company_id => :id}, lambda { |klass| {companies: klass.id, orders: nil} }
		has_many :registers, Kounta::Register, {:company_id => :id}, lambda { |klass| {companies: klass.id, registers: nil} }

		def initialize(hash={})
			if hash.empty?
				response = client.perform({:companies => "me"}, :get).parsed
				super(response)
			else
				super(hash)
			end
		end

		def base_price_list
			client.object_from_response(Kounta::PriceList, :get, {companies: id, price_lists: 'base'})
		end

		def resource_path
			{companies: id}
		end

	end

end