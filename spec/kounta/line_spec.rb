require 'helper'

describe Kounta::Line do
  subject { Kounta::Line.new }

  it 'should have a resource path' do
    subject.company_id = 162
    subject.order_id = 6789
    subject.id = 1
    subject.resource_path.should eq(companies: 162, orders: 6789, lines: 1)
  end
end
