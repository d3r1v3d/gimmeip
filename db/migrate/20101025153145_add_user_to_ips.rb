class AddUserToIps < ActiveRecord::Migration
    def self.foreign_key_name(to_table)
        "#{to_table.to_s.singularize}_id".to_sym
    end

    def self.up
        user_fk = foreign_key_name(:users)

        change_table :ips do |t|
            t.integer user_fk
        end
        add_foreign_key(:ips, :users, :column => user_fk)
    end

    def self.down
        user_fk = foreign_key_name(:users)

        remove_column(:ips, user_fk)
        remove_foreign_key(:ips, :column => user_fk)
    end
end
