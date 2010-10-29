class IpAddressValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
        return if value.blank?

        # An IP address is composed of 4 Byte-octets, delimited by periods. Since, in decimal,
        # a Byte ranges from 0-255, each octet can be no more than 3 digits and no less than 1
        matchData = /\A(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})\z/i.match(value)
        return failed(record, attribute) unless matchData && matchData.length == 5
    end

    private

    def failed(record, attribute)
        record.errors[attribute] << (options[:message] || 'is not valid. (example: 192.168.0.1)')
    end
end

class Ip < ActiveRecord::Base
    default_scope :order => :name

    belongs_to :user

    validates :address, :presence => true, :uniqueness => true, :ip_address => true
    validates :name, :presence => true, :uniqueness => {:case_sensitive => false}
end
