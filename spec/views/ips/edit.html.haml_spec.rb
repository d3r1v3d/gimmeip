require 'spec_helper'

describe "ips/edit.html.haml" do
  before(:each) do
    @ip = assign(:ip, stub_model(Ip,
      :new_record? => false,
      :address => "MyString",
      :name => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit ip form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => ip_path(@ip), :method => "post" do
      assert_select "input#ip_address", :name => "ip[address]"
      assert_select "input#ip_name", :name => "ip[name]"
      assert_select "textarea#ip_description", :name => "ip[description]"
    end
  end
end
