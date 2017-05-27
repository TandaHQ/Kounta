module Kounta
  class Webhook < Kounta::Resource
    property :id
    property :company_id
    property :topic
    property :address
    property :format
    property :created_at
    property :updated_at
    property :filter

    def resource_path
      { companies: company_id, webhooks: id }
    end
  end
end
