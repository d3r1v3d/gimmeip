require 'spec_helper'

describe "ips/new.html.haml" do
  before(:each) do
    assign(:ip, stub_model(Ip,
      :address => "MyString",
      :name => "MyString",
      :description => "MyText"
    ).as_new_record)
  end

  it "renders new ip form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => ips_path, :method => "post" do
      assert_select "input#ip_address", :name => "ip[address]"
      assert_select "input#ip_name", :name => "ip[name]"
      assert_select "textarea#ip_description", :name => "ip[description]"
    end
  end
end
