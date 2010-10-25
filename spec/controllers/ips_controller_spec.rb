require 'spec_helper'

describe IpsController do

  def mock_ip(stubs={})
    (@mock_ip ||= mock_model(Ip).as_null_object).tap do |ip|
      ip.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all ips as @ips" do
      Ip.stub(:all) { [mock_ip] }
      get :index
      assigns(:ips).should eq([mock_ip])
    end
  end

  describe "GET show" do
    it "assigns the requested ip as @ip" do
      Ip.stub(:find).with("37") { mock_ip }
      get :show, :id => "37"
      assigns(:ip).should be(mock_ip)
    end
  end

  describe "GET new" do
    it "assigns a new ip as @ip" do
      Ip.stub(:new) { mock_ip }
      get :new
      assigns(:ip).should be(mock_ip)
    end
  end

  describe "GET edit" do
    it "assigns the requested ip as @ip" do
      Ip.stub(:find).with("37") { mock_ip }
      get :edit, :id => "37"
      assigns(:ip).should be(mock_ip)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created ip as @ip" do
        Ip.stub(:new).with({'these' => 'params'}) { mock_ip(:save => true) }
        post :create, :ip => {'these' => 'params'}
        assigns(:ip).should be(mock_ip)
      end

      it "redirects to the created ip" do
        Ip.stub(:new) { mock_ip(:save => true) }
        post :create, :ip => {}
        response.should redirect_to(ip_url(mock_ip))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved ip as @ip" do
        Ip.stub(:new).with({'these' => 'params'}) { mock_ip(:save => false) }
        post :create, :ip => {'these' => 'params'}
        assigns(:ip).should be(mock_ip)
      end

      it "re-renders the 'new' template" do
        Ip.stub(:new) { mock_ip(:save => false) }
        post :create, :ip => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested ip" do
        Ip.should_receive(:find).with("37") { mock_ip }
        mock_ip.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :ip => {'these' => 'params'}
      end

      it "assigns the requested ip as @ip" do
        Ip.stub(:find) { mock_ip(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:ip).should be(mock_ip)
      end

      it "redirects to the ip" do
        Ip.stub(:find) { mock_ip(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(ip_url(mock_ip))
      end
    end

    describe "with invalid params" do
      it "assigns the ip as @ip" do
        Ip.stub(:find) { mock_ip(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:ip).should be(mock_ip)
      end

      it "re-renders the 'edit' template" do
        Ip.stub(:find) { mock_ip(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested ip" do
      Ip.should_receive(:find).with("37") { mock_ip }
      mock_ip.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the ips list" do
      Ip.stub(:find) { mock_ip }
      delete :destroy, :id => "1"
      response.should redirect_to(ips_url)
    end
  end

end
