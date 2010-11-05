Factory.define :user, :class => User do |u|
    u.name 'minimal'
    u.email 'minimal@user.com'
    u.password 'test1234'
    u.password_confirmation 'test1234'
end
