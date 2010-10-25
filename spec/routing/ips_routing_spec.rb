require "spec_helper"

describe IpsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/ips" }.should route_to(:controller => "ips", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/ips/new" }.should route_to(:controller => "ips", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/ips/1" }.should route_to(:controller => "ips", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/ips/1/edit" }.should route_to(:controller => "ips", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/ips" }.should route_to(:controller => "ips", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/ips/1" }.should route_to(:controller => "ips", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/ips/1" }.should route_to(:controller => "ips", :action => "destroy", :id => "1")
    end

  end
end
