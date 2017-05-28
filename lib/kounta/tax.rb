module Kounta
  class Tax < Kounta::Resource
    property :company_id
    property :code
    property :name
    property :rate
  end
end
