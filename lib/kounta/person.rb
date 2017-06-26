module Kounta
  class Person < Kounta::Resource
    property :company_id
    property :customer_id
    property :staff_id
    property :first_name
    property :last_name
    property :primary_email_address
    property :email_addresses
    property :shipping_address
    property :postal_address
    property :addresses
    property :phone_numbers
    property :image

    def name
      "#{first_name} #{last_name}"
    end

    def resource_path
      { companies: company_id, people: id }
    end
  end
end
