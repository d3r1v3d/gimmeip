Before do
    @attrs = Hash.new
end

Factory.factories.each do |name, factory|
    Given /^an? #{name} exists with the following attributes:$/ do |attrs_table| 
        attrs = {}
        attrs_table.raw.each do |(attr, value)|
            sanitized_attr = attr.gsub(/\s+/, '-').underscore
            attrs[sanitized_attr.to_sym] = value
        end

        #model_class = Kernel.const_get(name.to_s.capitalize)
        #col_keys = attrs.keys.select{ |attr| model_class.columns.map{ |col| col.name.to_sym}.include?(attr)}
        #col_values = attrs.select{ |key, value| col_keys.include?(key) }.values
        #where_clause = col_keys.map{ |key| "#{key} = ?" }.join(' AND ')
        #found = model_class.send(:where, [where_clause, *col_values])

        @attrs[name] ||= Array.new
        @attrs[name] << (obj = Factory.build(name, attrs))
        obj.save if obj.valid?
    end
end

# Session

Given /^I am logged in as "([^"]*)"$/ do |user_name|
    @user = User.all.select{ |u| u.name == user_name }.first
    @user.should_not be_nil

    visit path_to('the sign in page')
    fill_in 'user_email', :with => @user.email
    fill_in 'user_password', :with => @attrs[:user].select{ |u| u.name == user_name }.first.password
    click_button 'user_submit'
    page.should have_content('Signed in successfully.')
end
