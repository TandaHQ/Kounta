module Kounta

	class Site < Kounta::Resource
		property :company_id
		property :name
		property :code
		property :business_number
		property :contact_person
		property :shipping_address
		property :postal_address
		property :email
		property :mobile
		property :phone
		property :fax
		property :location
		property :image
		property :website
		property :register_level_reconciliation
		property :products
		property :price_list

		coerce_key :shipping_address, Kounta::Address
		coerce_key :postal_address, Kounta::Address
		coerce_key :price_list, Kounta::PriceList

		has_one :product, Kounta::Product, {:company_id => :company_id}, Proc.new { |klass, item_id| {companies: klass.company_id, sites: klass.id, products: item_id} }
		has_one :category, Kounta::Category, {:company_id => :company_id}, Proc.new { |klass, item_id| {companies: klass.company_id, sites: klass.id, categories: item_id} }
		has_one :address, Kounta::Address, {:company_id => :company_id}, Proc.new { |klass, item_id| {companies: klass.company_id, sites: klass.id, addresses: item_id} }
		has_one :order, Kounta::Order, {:company_id => :company_id}, Proc.new { |klass, item_id| {companies: klass.company_id, sites: klass.id, orders: item_id} }

		has_many :products, Kounta::Product, {:company_id => :company_id}, Proc.new { |klass| {companies: klass.company_id, sites: klass.id, products: nil} }
		has_many :categories, Kounta::Category, {:company_id => :company_id}, Proc.new { |klass| {companies: klass.company_id, sites: klass.id, categories: nil} }
		has_many :addresses, Kounta::Address, {:company_id => :company_id}, Proc.new { |klass| {companies: klass.company_id, sites: klass.id, addresses: nil} }
		has_many :orders, Kounta::Order, {:company_id => :company_id}, Proc.new { |klass| {companies: klass.company_id, sites: klass.id, orders: nil} }
		has_many :inventory, Kounta::Inventory, {:company_id => :company_id}, Proc.new { |klass| {companies: klass.company_id, sites: klass.id, inventory: nil} }
		has_many :shifts_since, Kounta::Shift, {:company_id => :company_id}, Proc.new { |klass, date| {companies: klass.company_id, sites: klass.id, shifts: nil, since: Kounta.format_date(date)} }

		def resource_path
			{companies: company_id, sites: id}
		end

	end

end