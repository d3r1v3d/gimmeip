Factory.factories.each do |name, factory|
    Given /^an? #{name} exists with the following attributes:$/ do |attrs_table| 
        attrs = {}
        attrs_table.raw.each do |(attr, value)|
            sanitized_attr = attr.gsub(/\s+/, '-').underscore
            attrs[sanitized_attr.to_sym] = value
        end
       
        klass = Kernel.const_get(name.to_s.capitalize)
        col_keys = attrs.keys.select{ |attr| klass.columns.map{ |col| col.name.to_sym}.include?(attr)}
        where_clause = col_keys.map{ |key| "#{key} = ?" }.join(' AND ')
        found = klass.send(:where, [where_clause, *attrs.values])
        if found.count.zero?
            obj = Factory.create(name, attrs)
        else
            obj = found.first
        end
        self.instance_variable_set("@#{name}".to_sym, obj)
    end
end

# Reset password

Given /^that I have reset my password$/ do
    @user.send_reset_password_instructions
end

When /^I follow the reset password link in my email$/ do
    visit edit_user_password_path(:reset_password_token => @user.reset_password_token)
    page.should have_content('Change your password')
end

Then /^I expect to be able to reset my password$/ do
    visit edit_user_password_path(:reset_password_token => @user.reset_password_token)
    fill_in 'user_password', :with => 'test1234'
    fill_in 'user_password_confirmation', :with => 'test1234'
    click_button 'user_submit'
    page.should have_content('Your password was changed successfully')
end

# Session

Given /^I am logged in$/ do
    @user.save if User.where(['name = ? OR email = ?', @user.name, @user.email]).count.zero?

    visit path_to('the sign in page')
    fill_in 'user_email', :with => @user.email
    fill_in 'user_password', :with => @user.password
    click_button 'user_submit'
    page.should have_content('Signed in successfully.')
end
