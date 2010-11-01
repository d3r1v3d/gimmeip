class User < ActiveRecord::Base
    # :database_authenticatable => encrypts and stores a password in the database for authentication.
    #                              can be done through POST requests or HTTP Basic Authentication
    # :recoverable => allows users to reset their password and e-mails them reset instructions
    # :rememberable => allows users to be 'remembered' using a saved cookie
    # :trackable => maintains various log-in metrics: sign-in count, timestamps, IP address, etc
    # :validatable => allows for customizable validation of user e-mail and password attributes
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable

    attr_accessible :name, :email, :password, :password_confirmation, :remember_me

    validates_presence_of :name
    validates_uniqueness_of :name, :case_sensitive => false
    # has_friendly_id :name, :use_slug => true, :strip_non_ascii => true

    has_and_belongs_to_many :roles
    def role?(role)
        return !!self.roles.find_by_name(role.to_s.camelize)
    end

    has_many :ips, :dependent => :nullify
    validates_associated :ips

    # Allow users to log-in using their username or e-mail address
    def self.find_for_database_authentication(conditions)
        value = conditions[authentication_keys.first]
        where(['name = :value OR email = :value', { :value => value }]).first
    end
end
