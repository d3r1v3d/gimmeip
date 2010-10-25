require 'spec_helper'

describe "ips/index.html.haml" do
  before(:each) do
    assign(:ips, [
      stub_model(Ip,
        :address => "Address",
        :name => "Name",
        :description => "MyText"
      ),
      stub_model(Ip,
        :address => "Address",
        :name => "Name",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of ips" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
